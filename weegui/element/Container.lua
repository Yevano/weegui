--@import weegui.concurrent.GuiManager
--@import weegui.element.Element
--@import weegui.graphics.ImageDrawContext

--@extends weegui.element.Element

function Container:init(parent, x, y, w, h)
    Element.init(self, parent, x, y, w, h)
    self.children = Array.new()
end

function Container:add(element)
    self.children:add(element)
end

function Container:paint(ctx)
    for child in self.children:iRange(-1, 1) do
        if child.repaintf then
            local childCtx = ImageDrawContext.new(child.drawBuffer)
            child:paint(childCtx)
        end
        ctx:drawImage(child.x, child.y, child.drawBuffer)
    end
    Element.paint(self, ctx)
end

function Container:resize(w, h)
    Element.resize(self, w, h)
end

function Container:onClick(button, x, y)
    for child in self.children:iAll() do
        if child:contains(x, y) then
            child:onClick(button, x - child.x + 1, y - child.y + 1)
            self.dragging = child
            self:focus(child)
            break
        end
    end
    Element.onClick(self, button, x, y)
end

function Container:onDrag(button, x, y, dx, dy)
    for child in self.children:iAll() do
        if child:contains(x, y) and self.dragging == child then
            child:onDrag(button, x - child.x + 1, y - child.y + 1, dx, dy)
        end
    end
    Element.onDrag(self, button, x, y, dx, dy)
end

function Container:focus(child)
    local index = self.children:indexOf(child)
    if not index then return end
    self.children:remove(index)
    self.children:insert(1, child)
end

function Container:remove(child)
    if not child then
        Element.remove(self)
    else
        self.children:remove(self.children:indexOf(child))
    end
end