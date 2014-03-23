--@import see.util.Color

--@import weegui.element.Container
--@import weegui.element.Element
--@import weegui.element.Label

--@extends weegui.element.Container

function SelectionList:init(parent, x, y, w, bg, fg, strings)
    self:super(Container).init(parent, x, y, w, strings:length())
    self.bg = bg
    self.fg = fg
    self.selected = Array:new()

    for string in strings:iAll() do
        local item = Label:new(self, 1, self.children:length() + 1, string, self.bg, self.fg)
        item:addListener(Element.CLICK, function(button, x, y)
            if self.selected:contains(item) then
                self.selected:remove(self.selected:indexOf(item))
                item.fg = self.fg
                item.bg = self.bg
            else
                self.selected:add(item)
                item.fg = self.bg
                item.bg = self.fg
            end

            item:repaint()
        end)
    end
end

function SelectionList:paint(ctx)
    ctx.char = " "
    ctx.bg = Color.GRAY
    for i = 1, self.children:length() do
        local len = self.children[i].text:length()
        ctx:drawRect(len + 1, i, self.w - len, 1)
    end
    self:super(Container).paint(ctx)
end