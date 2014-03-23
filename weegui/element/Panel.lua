--@import see.util.Color

--@import weegui.element.Container
--@import weegui.graphics.Image
--@import weegui.graphics.Pixel

--@extends weegui.element.Container

function Panel:init(parent, x, y, w, h, bg, fg)
    self:super(Container).init(parent, x, y, w, h)
    self.children = Array:new()
    self.bg = bg or Color.BLACK
    self.fg = fg or Color.WHITE
end

function Panel:paint(ctx)
    ctx.bg = self.bg
    ctx.fg = self.fg
    ctx.char = " "
    ctx:drawRect(1, 1, self.w, self.h)
    self:super(Container).paint(ctx)
end

function Panel:onClick(button, x, y)
    self:super(Container).onClick(button, x, y)
end

function Panel:onDrag(button, x, y, dx, dy)
    self:super(Container).onDrag(button, x, y, dx, dy)
end