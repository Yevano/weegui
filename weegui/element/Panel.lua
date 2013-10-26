--@import see.util.Color

--@import weegui.element.Container
--@import weegui.graphics.Image
--@import weegui.graphics.Pixel

--@extends weegui.element.Container

function Panel:init(parent, x, y, w, h, bg, fg)
    Container.init(self, parent, x, y, w, h)
    self.children = Array.new()
    self.bg = bg or Color.WHITE
    self.fg = fg or Color.BLACK
end

function Panel:paint(ctx)
    ctx.bg = self.bg
    ctx.fg = self.fg
    ctx.char = " "
    ctx:drawRect(1, 1, self.w, self.h)
    Container.paint(self, ctx)
end

function Panel:onClick(button, x, y)
    Container.onClick(self, button, x, y)
end

function Panel:onDrag(button, x, y, dx, dy)
    Container.onDrag(self, button, x, y, dx, dy)
end