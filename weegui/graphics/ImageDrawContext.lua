--@import weegui.graphics.DrawContext

--@import see.io.Terminal

--@extends weegui.graphics.DrawContext

function ImageDrawContext:init(image)
    self:super(DrawContext).init()
    self.image = image
end

function ImageDrawContext:getSize()
    return { x = self.image.w, y = self.image.h }
end

function ImageDrawContext:setPixel(x, y)
    self.image:setPixel(x, y, self.char, self.bg, self.fg)
end

function ImageDrawContext:getPixel(x, y)
    return self.image.buffer[x][y]
end