--@import see.util.Math

--@import weegui.element.Element

--@import weegui.util.Alignment

--@extends weegui.element.Element

function Button:init(parent, x, y, w, h, text, bg, fg)
    Element.init(self, parent, x, y, w, h)
    self.bg = bg
    self.fg = fg
    self.text = cast(text or "", String)
    self.alignmentX = Alignment.CENTER
    self.alignmentY = Alignment.CENTER
end

function Button:setTextAlignment(alignmentX, alignmentY)
    self.alignmentX = alignmentX
    self.alignmentY = alignmentY
    self:repaint()
end

function Button:paint(ctx)
    ctx.char = " "
    ctx.bg = self.bg
    ctx.fg = self.fg
    ctx:drawRect(1, 1, self.w, self.h)

    --System.print(self.alignmentX)

    local x, y
    if self.alignmentX == Alignment.LEFT then
        x = 1
    elseif self.alignmentX == Alignment.CENTER then
        x = Math.floor(self.w/2 - self.text:length()/2) + 1
    elseif self.alignmentX == Alignment.RIGHT then
        x = self.w - self.text:length() + 1
    end
    if self.alignmentY == Alignment.TOP then
        y = 1
    elseif self.alignmentY == Alignment.CENTER then
        y = Math.floor(self.h/2) + 1
    elseif self.alignmentY == Alignment.BOTTOM then
        y = self.h
    end
    ctx:drawString(self.text, x, y)
    Element.paint(self, ctx)
end