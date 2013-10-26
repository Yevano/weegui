--@import see.util.FastArray

--@import weegui.graphics.Pixel

function Image:init(w, h)
    self.w = w
    self.h = h
    self.buffer = { }
    for i = 1, w do
        FastArray.insert(self.buffer, { })
        for j = 1, h do
            FastArray.insert(self.buffer[i], Pixel.new())
        end
    end
end

function Image:setPixel(x, y, char, bg, fg)
    local bufPix = self.buffer[x][y]
    bufPix.char = char
    bufPix.bg = bg
    bufPix.fg = fg
end

function Image:getPixel(x, y)
    return self.buffer[x][y]
end

function Image:resize(w, h)
    if h > self.h then
        for i = 1, self.w do
            for j = self.h + 1, h do
                FastArray.insert(self.buffer[i], Pixel.new())
            end
        end
    end
    self.h = h

    if w > self.w then
        for i = self.w + 1, w do
            FastArray.insert(self.buffer, { })
            for j = 1, h do
                FastArray.insert(self.buffer[i], Pixel.new())
            end
        end
    end
    self.w = w
end