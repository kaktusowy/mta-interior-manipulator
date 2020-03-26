local gui;
local guiKey = "R";

function triggerGui()
    if not gui then
        gui = Gui();
    end
    gui:trigger();
end

bindKey(guiKey, "up", triggerGui);