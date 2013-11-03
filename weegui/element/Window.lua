--@import see.util.Color
--@import see.util.Math

--@import weegui.element.Element
--@import weegui.element.Container
--@import weegui.element.Panel
--@import weegui.element.Button
--@import weegui.element.Label
--@import weegui.element.ResizeHandle

--@extends weegui.element.Container

function Window:init(parent, x, y, w, h, title)
    Container.init(self, parent, x, y, w, h)
    self.titleBar = Panel.new(self, 1, 1, w, 1, Color.GRAY)
    self.titleBar:addListener(Element.DRAG, function(button, x, y, dx, dy)
        self.x = Math.min(Math.max(self.x + dx, 1), self.parent.w - self.w + 1)
        self.y = Math.min(Math.max(self.y + dy, 1), self.parent.h - self.h + 1)
    end)

    self.titleLabel = Label.new(self.titleBar, 1, 1, title, Color.GRAY, Color.WHITE)
    self.closeButton = Button.new(self.titleBar, w, 1, 1, 1, "x", Color.RED, Color.WHITE)

    self.resizeHandle = ResizeHandle.new(self, w, h)

    self.contentPanel = Panel.new(self, 2, 2, w - 2, h - 2, Color.BLACK)
end

function Window:paint(ctx)
    ctx.bg = Color.GRAY
    ctx.char = " "
    ctx:drawRect(1, 2, 1, self.h - 1)
    ctx:drawRect(self.w, 2, 1, self.h - 2)
    ctx:drawRect(2, self.h, self.w - 2, 1)
    Container.paint(self, ctx)
end

function Window:resize(w, h)
    w = Math.max(w, 2)
    h = Math.max(h, 2)
    Container.resize(self, w, h)
    self.titleBar:resize(w, 1)
    self.titleBar:repaint()
    self.closeButton.x = w
    self.resizeHandle.x = w
    self.resizeHandle.y = h
    self.contentPanel:resize(w - 2, h - 2)
    self.contentPanel:repaint()
    self:repaint()
end

function Window:removeOnClose()
    self.closeButton:addListener(Element.CLICK, function(button, x, y)
        self:remove()
    end)
    return self
end