GuiListener = {}
GuiListener.__index = GuiListener

setmetatable(GuiListener, {
    __call = function(cls, ...)
        local self = setmetatable({}, cls)
        self:_construct(...)
        return self
    end,
})

function GuiListener:_construct(guiElement, func)
    assert(guiElement ~= nil, "guiElement argument cannot be null");
    assert(func ~= nil, "func argument cannot be null");

    self.guiElement = guiElement;
    self.func = func;

    self:run();
end

function GuiListener:handleEvent(button, state)
    if button ~= 'left' or state ~= 'up' then
        return;
    end
    self:func();
end

function GuiListener:run()
    addEventHandler("onClientGUIClick", self.guiElement, function(button, state)
        self:handleEvent(button, state);
    end, false);
end