--@import weegui.concurrent.GuiManager
--@import weegui.graphics.Image

Element.CLICK = "ElementClick"
Element.DRAG  = "ElementDrag"
Element.PAINT = "ElementPaint"
Element.FOCUS = "ElementFocus"
Element.UNFOCUS = "ElementUnfocus"

function Element:init(parent, x, y, w, h)
    if not GuiManager.instance then
        GuiManager.new()
    end

    if parent == nil then
        self.parent = GuiManager.instance.basePanel
    elseif parent then
        self.parent = parent
    end

    if self.parent then
        self.parent:add(self)
    end

    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.repaintf = true

    self.drawBuffer = Image.new(w, h)

    self.listeners = { }
end

function Element:onClick(button, x, y)
    self:callListeners(Element.CLICK, button, x, y)
end

function Element:onDrag(button, x, y, dx, dy)
    self:callListeners(Element.DRAG, button, x, y, dx, dy)
end

function Element:paint(ctx)
    self:callListeners(Element.PAINT, ctx)
    self.repaintf = false
end

function Element:repaint()
    self.repaintf = true
    if self.parent then
        self.parent:repaint()
    end
end

function Element:resize(w, h)
    self.w = w
    self.h = h
    self.drawBuffer:resize(w, h)
end

function Element:contains(x2, y2)
    local x1, y1 = self.x, self.y
    local w, h = self.w, self.h
    return x2 >= x1 and x2 <= x1 + w - 1 and y2 >= y1 and y2 <= y1 + h - 1
end

function Element:addListener(eventType, listener)
    if not self.listeners[eventType] then
        self.listeners[eventType] = Array.new()
    end

    self.listeners[eventType]:add(listener)
end

function Element:callListeners(eventType, ...)
    local l = self.listeners[eventType]
    if not l then return end
    for listener in l:iAll() do
        listener(...)
    end
end

function Element:remove()
    self.parent:remove(self)
end

function Element:getRelativeX(element)
    return self.parent == element and self.x or (self.parent:getRelativeX(element) + self.x - 1)
end

function Element:getRelativeY(element)
    return self.parent == element and self.y or (self.parent:getRelativeY(element) + self.y - 1)
end