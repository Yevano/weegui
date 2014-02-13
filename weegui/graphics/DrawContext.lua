--@import see.util.Color

function DrawContext:init()
    self.x = 1
    self.y = 1
    self.char = " "
    self.bg = Color.WHITE
    self.fg = Color.BLACK
end

function DrawContext:translate(x, y)
    self.x = self.x + x
    self.y = self.y + y
end

function DrawContext:drawString(string, x, y)
    string = cast(string, String)
    for i = x, x + string:length() - 1 do
        self.char = String.char(string[i - x + 1])
        self:setPixel(i + self.x - 1, y + self.y - 1)
    end
end

function DrawContext:drawRect(x, y, w, h)
    for i = x, x + w - 1 do
        for j = y, y + h - 1 do
            self:setPixel(i + self.x - 1, j + self.y - 1)
        end
    end
end

function DrawContext:drawImage(x, y, image)
    for i = x, x + image.w - 1 do
        for j = y, y + image.h - 1 do
            local col = image.buffer[i - x + 1]
            local iy = (j - y + 1) * 3
            self.char = col[iy] or " "
            self.fg   = col[iy + 2] or Color.BLACK
            self.bg   = col[iy + 1] or Color.WHITE
            self:setPixel(i + self.x - 1, j + self.y - 1)
        end
    end
end

function DrawContext:clear(bg, fg)
    self.bg = bg or Color.BLACK
    self.fg = fg or Color.BLACK
    local size = self:getSize()
    self:drawRect(1, 1, size.x, size.y)
end