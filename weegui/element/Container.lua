--@import weegui.util.GuiManager

--@import weegui.element.Element
--@import weegui.graphics.ImageDrawContext

--@extends weegui.element.Element

function Container:init(parent, x, y, w, h)
    Element.init(self, parent, x, y, w, h)
    self.children = Array.new()

    self:addListener(Element.UNFOCUS, function()
        if self.children:length() > 0 then
            self.children[1]:callListeners(Element.UNFOCUS)
        end
    end)
end

function Container:add(element)
    element.parent = self
    self.children:add(element)
end

function Container:paint(ctx)
    for child in self.children:iRange(-1, 1) do
        if child.repaintf then
            local childCtx = ImageDrawContext.new(child.drawBuffer)
            child:paint(childCtx)
        end

        if child.visible then
            ctx:drawImage(child.x, child.y, child.drawBuffer)
        end
    end
    Element.paint(self, ctx)
end

function Container:resize(w, h)
    Element.resize(self, w, h)
end

function Container:onClick(button, x, y)
    for child in self.children:iAll() do
        if child.visible and child:contains(x, y) then
            self.dragging = child
            self:focus(child)
            child:onClick(button, x - child.x + 1, y - child.y + 1)
            break
        end
    end
    Element.onClick(self, button, x, y)
end

function Container:onDrag(button, x, y, dx, dy)
    for child in self.children:iAll() do
        if child.visible and child:contains(x, y) and self.dragging == child then
            child:onDrag(button, x - child.x + 1, y - child.y + 1, dx, dy)
        end
    end
    Element.onDrag(self, button, x, y, dx, dy)
end

function Container:focus(child)
    local unfocused
    for child in self.children:iAll() do
        unfocused = child
        if not unfocused.alwaysOnTop then break end
    end
    if unfocused == child then return end
    unfocused:callListeners(Element.UNFOCUS)
    child:callListeners(Element.FOCUS)
    local index = self.children:indexOf(child)
    if not index then return end
    self.children:remove(index)
    self.children:insert(self.children:indexOf(unfocused), child)
end

function Container:remove(child)
    if not child then
        Element.remove(self)
    else
        child.parent = false
        self.children:remove(self.children:indexOf(child))
    end
end