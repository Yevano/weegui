--@import weegui.element.Button

--@extends weegui.element.Button

function MenuButton:init(parent, y, w, text, bg, fg)
    text = cast(text, String)
    self:super(Button).init(parent, 1, y, w or text:length(), 1, text, bg, fg)
end