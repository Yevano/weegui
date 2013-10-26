--@import see.util.Color

function Pixel:init(char, bg, fg)
    self.char = char or STR" "[1]
    self.bg = bg or Color.BLACK
    self.fg = fg or Color.WHITE
end