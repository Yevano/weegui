--@import weegui.element.Button
--@import weegui.element.Element
--@import weegui.util.GuiManager

--@extends weegui.element.Button

function MenuBarButton:init(parent, x, text, bg, fg)
    text = cast(text, String)
    self:super(Button).init(parent, x, 1, text:length() + 1, 1, text, bg, fg)
end

function MenuBarButton:onClick(button, x, y)
    self:super(Button).onClick(button, x, y)
    if not self.menu then return end
    self.menu:setVisible(not self.menu.visible)
    if self.menu.visible then
        if self.parent.active then
            self.parent.active.menu:setVisible(false)
        end
        self.parent.active = self
        GuiManager.instance.basePanel:focus(self.menu)
    else
        self.parent.active = nil
    end
end

function MenuBarButton:setMenu(menu)
    self.menu = menu
    self.menu.attachedTo = self
    self.menu:setVisible(false)
    self.menu:setAlwaysOnTop(true)
    self.menu.x = self:getRelativeX(GuiManager.instance.basePanel)
    self.menu.y = self:getRelativeY(GuiManager.instance.basePanel) + 1
end