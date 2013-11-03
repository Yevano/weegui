--@import weegui.element.Button

--@extends weegui.element.Button

function MenuButton:init(parent, y, text, bg, fg)
    text = cast(text, String)
    Button.init(self, parent, 1, y, text:length(), 1, text, bg, fg)
end