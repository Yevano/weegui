--@import weegui.element.Button
--@import weegui.element.Element
--@import weegui.concurrent.GuiManager

--@extends weegui.element.Button

function MenuBarButton:init(parent, x, text, bg, fg)
    text = cast(text, String)
    Button.init(self, parent, x, 1, text:length() + 1, 1, text, bg, fg)

    self:addListener(Element.CLICK, function(button, x, y)
        if not self.menu then return end
        self.menu.parent = GuiManager.instance.basePanel
        GuiManager.instance.basePanel:add(self.menu)
        GuiManager.instance.basePanel:focus(self.menu)
    end)
end

function MenuBarButton:setMenu(menu)
    self.menu = menu
    self.menu.x = self:getRelativeX(GuiManager.instance.basePanel)
    self.menu.y = self:getRelativeY(GuiManager.instance.basePanel) + 1
end