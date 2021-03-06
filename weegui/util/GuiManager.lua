--@import see.rt.RuntimeException
--@import see.io.Terminal
--@import see.util.Color
--@import see.concurrent.Thread
--@import see.event.impl.MousePressEvent
--@import see.event.impl.MouseDragEvent
--@import see.event.impl.KeyPressEvent

--@import weegui.element.Panel
--@import weegui.graphics.Image
--@import weegui.graphics.ImageDrawContext
--@import weegui.graphics.MonitorDrawContext

function GuiManager:init()
    if GuiManager.instance then
        throw(RuntimeException:new("Cannot create more than one instance of weegui.concurrent.GuiManager."))
    end

    GuiManager.instance = self

    self.running = true

    self.monitorSize = Terminal.getSize()
    self.monitorCtx = MonitorDrawContext:new()
    self.uiImage = Image:new(self.monitorSize.x, self.monitorSize.y)
    self.uiCtx = ImageDrawContext:new(self.uiImage)

    self.basePanel = Panel:new(nil, 1, 1, self.monitorSize.x, self.monitorSize.y, Color.BLACK)

    self.paintThread = Thread:new(function()
        while self.running do
            self.basePanel:paint(self.uiCtx)
            self.monitorCtx:drawImage(1, 1, self.uiImage)
            try(function()
                Thread.sleep(1/20)
            end, function() end)
        end
    end)
    self.paintThread:start()

    self.eventThread = Thread:new(function()
        while self.running do
            local event
            try(function()
                event = Events.pull(MousePressEvent, MouseDragEvent, KeyPressEvent)
            end, function() end)

            if event then
                if event.ident == "mouse_click" then
                    self.lastPos = event
                    self.basePanel:onClick(event.button, event.x, event.y)
                elseif event.ident == "mouse_drag" then
                    local lc = self.lastPos
                    self.basePanel:onDrag(event.button, lc.x, lc.y, event.x - lc.x, event.y - lc.y)
                    self.lastPos = event
                elseif event.ident == "key" then
                end
            end
        end
    end)
    self.eventThread:start()
end

function GuiManager.stop()
    Thread:new(function()
        local self = GuiManager.instance
        self.running = false
        self.paintThread:interrupt()
        self.paintThread:join()
        self.eventThread:interrupt()
        self.eventThread:join()
        self.monitorCtx:clear()
    end):start()
end