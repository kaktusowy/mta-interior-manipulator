local editorResource = getResourceFromName("editor_main");

local actionHistory = {};

function pushAction(action)
    table.insert(actionHistory, action);
end

function pushMoveAction(x, y, z, dim)
    local action = {};
    action.type = "move";
    action.x = x;
    action.y = y;
    action.z = z;
    action.dim = dim;

    pushAction(action);
end

function pushRotateAction(angle, dim)
    local action = {};
    action.type = "rotate";
    action.angle = angle;
    action.dim = dim;

    pushAction(action);
end

function clearActionHistory()
    actionHistory = {};
end

function onActionUndo()
    if not editorResource then
        outputDebugString("MTA Map Editor is required to use this addon.");
        return;
    end

    local size = #actionHistory;
    if size > 0 then
        local action = actionHistory[size];
        if action then
            if action.type == "move" then
                triggerEvent("onInteriorRelocateMove", getRootElement(), -action.x, -action.y, -action.z, false, true, action.dim);
            else
                triggerEvent("onInteriorRelocateRotate", getRootElement(), -action.angle, true, action.dim);
            end
            table.remove(actionHistory, size);
        end
    else
        triggerClientEvent(source, "onNothingToUndo", getRootElement());
    end
end
addEvent("onActionUndo", true)
addEventHandler("onActionUndo", getRootElement(), onActionUndo)

if editorResource then
    local rootElement = getResourceRootElement(editorResource);
    if rootElement and isElement(rootElement) then
        addEventHandler("onMapOpened", rootElement, function()
            clearActionHistory();
        end)
    end
end