Gui = {}
Gui.__index = Gui

setmetatable(Gui, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_construct(...)
        return self
    end,
})

function Gui:_construct(x, y, name)
    local sW, sH = guiGetScreenSize();
    self.x = x or sW - 250;
    self.y = y or sH - 600;
    self.w = 250;
    self.h = 200;
    self.name = name or "Interior Manipulator";
    self.init = false;
    self.opened = false;
end

function Gui:trigger()
    if not self.init then
        self:initGui();
    end
    if self.opened then
        self.opened = false;
        self.window:setVisible(false);
    else
        self.opened = true;
        self.window:setVisible(true);
    end
end

function Gui:resetMoveTabXEdit()
    self.tabMoveEditX:setText("0");
end

function Gui:resetMoveTabYEdit()
    self.tabMoveEditY:setText("0");
end

function Gui:resetMoveTabZEdit()
    self.tabMoveEditZ:setText("0");
end

function Gui:resetRotateTabZEdit()
    self.tabRotateEditZ:setText("0");
end

function Gui:initListeners()
    GuiListener(self.tabMoveButtonResetX, function() self:resetMoveTabXEdit() end);
    GuiListener(self.tabMoveButtonResetY, function() self:resetMoveTabYEdit() end);
    GuiListener(self.tabMoveButtonResetZ, function() self:resetMoveTabZEdit() end);
    GuiListener(self.tabMoveButtonMove, function() self:move() end);
    GuiListener(self.tabMoveButtonMoveHere, function() self:moveToPlayer() end);
    GuiListener(self.tabRotateButtonRotate, function() self:rotate() end);
    GuiListener(self.tabRotateButtonResetZ, function() self:resetRotateTabZEdit() end);
    GuiListener(self.undoButton, function() self:undo() end);
end

function Gui:initGui()
    self.window = GuiWindow(self.x, self.y, self.w, self.h, self.name, false);
    self.undoButton = GuiButton(0, 0.8, 1, 0.2, "Undo", true, self.window);
    self.tabPanel = GuiTabPanel(0, 0.1, 1, 0.68, true, self.window);
    self.tabMove = GuiTab("Move", self.tabPanel);
    self.tabRotate = GuiTab("Rotate", self.tabPanel);

    -- MOVE TAB
    self.tabMoveLabelX = GuiLabel(0.04, 0.12, 0.2, 0.2, "X", true, self.tabMove);
    self.tabMoveLabelY = GuiLabel(0.04, 0.34, 0.2, 0.2, "Y", true, self.tabMove);
    self.tabMoveLabelZ = GuiLabel(0.04, 0.56, 0.2, 0.2, "Z", true, self.tabMove);

    self.tabMoveEditX = GuiEdit(0.11, 0.08, 0.5, 0.2, "0", true, self.tabMove);
    self.tabMoveEditY = GuiEdit(0.11, 0.3, 0.5, 0.2, "0", true, self.tabMove);
    self.tabMoveEditZ = GuiEdit(0.11, 0.52, 0.5, 0.2, "0", true, self.tabMove);

    self.tabMoveButtonResetX = GuiButton(0.65, 0.08, 0.3, 0.2, "Reset", true, self.tabMove);
    self.tabMoveButtonResetY = GuiButton(0.65, 0.3, 0.3, 0.2, "Reset", true, self.tabMove);
    self.tabMoveButtonResetZ = GuiButton(0.65, 0.52, 0.3, 0.2, "Reset", true, self.tabMove);

    self.tabMoveButtonMove = GuiButton(0.01, 0.78, 0.48, 0.18, "Move", true, self.tabMove);
    self.tabMoveButtonMoveHere = GuiButton(0.51, 0.78, 0.48, 0.18, "Move here", true, self.tabMove);

    -- ROTATE TAB
    self.tabRotateLabelZ = GuiLabel(0.04, 0.56, 0.2, 0.2, "Z", true, self.tabRotate);
    self.tabRotateEditZ = GuiEdit(0.11, 0.52, 0.5, 0.2, "0", true, self.tabRotate);
    self.tabRotateButtonResetZ = GuiButton(0.65, 0.52, 0.3, 0.2, "Reset", true, self.tabRotate);
    self.tabRotateButtonRotate = GuiButton(0.01, 0.78, 0.98, 0.18, "Rotate", true, self.tabRotate);

    self.window:setVisible(false);

    self:initListeners();
    self.init = true;
end

function Gui:move()
    local x = tonumber(self.tabMoveEditX:getText()) or 0;
    local y = tonumber(self.tabMoveEditY:getText()) or 0;
    local z = tonumber(self.tabMoveEditZ:getText()) or 0;

    moveInterior(x, y, z, false);
end

function Gui:rotate()
    local z = tonumber(self.tabRotateEditZ:getText()) or 0;

    rotateInterior(z);
end

function Gui:moveToPlayer()
    moveInteriorToPosition(getLocalPlayer():getPosition());
end

function Gui:undo()
    undoLastAction();
end