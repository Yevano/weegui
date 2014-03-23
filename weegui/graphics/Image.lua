--@import see.util.FastArray

--@import weegui.graphics.Pixel

function Image:init(w, h)
    self.w = w
    self.h = h
    self.buffer = { }
    for i = 1, w do
        FastArray.insert(self.buffer, { })
    end
end

function Image:setPixel(x, y, char, bg, fg)
    local col = self.buffer[x]
    y = y * 3
    col[y    ] = char
    col[y + 1] = bg
    col[y + 2] = fg
end

function Image:getPixel(x, y)
    local col = self.buffer[x]
    y = y * 3
    return Pixel:new(col[y], col[y + 1], col[y + 2])
end

function Image:resize(w, h)
    self.h = h

    if w > self.w then
        for i = self.w + 1, w do
            FastArray.insert(self.buffer, { })
        end
    end
    self.w = w
end