--@import see.util.Color

--@import weegui.element.Element

--@extends weegui.element.Element

function Label:init(parent, x, y, text, bg, fg)
    self.text = cast(text or "", String)
    self.bg = bg or Color.WHITE
    self.fg = fg or Color.BLACK
    Element.init(self, parent, x, y, self.text:length(), 1)
end

function Label:paint(ctx)
    ctx.fg = self.fg
    ctx.bg = self.bg
    ctx:drawString(self.text, 1, 1)
    Element.paint(self, ctx)
end

function Label:setText(text)
    self.text = cast(text, String)
    self.drawBuffer:resize(self.text:length(), 1)
    self:repaint()
end

function Label:onClick(button, x, y)
    Element.onClick(self, button, x, y)
end