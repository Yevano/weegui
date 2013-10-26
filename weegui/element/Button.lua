--@import see.util.Math

--@import weegui.element.Element

--@extends weegui.element.Element

function Button:init(parent, x, y, w, h, text, bg, fg)
    Element.init(self, parent, x, y, w, h)
    self.bg = bg
    self.fg = fg
    self.text = cast(text or "", String)
end

function Button:paint(ctx)
    ctx.char = " "
    ctx.bg = self.bg
    ctx.fg = self.fg
    ctx:drawRect(1, 1, self.w, self.h)
    ctx:drawString(self.text, Math.floor(self.w/2 - self.text:length()/2) + 1, Math.floor(self.h/2) + 1)
    Element.paint(self, ctx)
end

function Button:onClick(button, x, y)
    Element.onClick(self, button, x, y)
end