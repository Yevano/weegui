--@import see.util.Color

--@import weegui.element.Element

--@extends weegui.element.Element

function ResizeHandle:init(parent, x, y)
    self:super(Element).init(parent, x, y, 1, 1)
    self:addListener(Element.DRAG, function(button, x, y, dx, dy)
        self.parent:resize(self.parent.w + dx, self.parent.h + dy)
    end)
end

function ResizeHandle:paint(ctx)
    ctx.bg = Color.GRAY
    ctx.fg = Color.WHITE
    ctx.char = "/"
    ctx:setPixel(1, 1)
    self:super(Element).paint(ctx)
end