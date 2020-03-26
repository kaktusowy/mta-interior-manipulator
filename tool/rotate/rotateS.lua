
function onInteriorRelocateRotate(angle, undo)
    local editorResource = getResourceFromName("editor_main");
    if not editorResource then
        outputDebugString("MTA Map Editor is required to use this addon.");
        return;
    end

    local rootElement = getResourceRootElement(editorResource);
    if rootElement and isElement(rootElement) then
        local objects = getElementsByType("object", rootElement);
        local midpointX, midpointY = Maths.calculateInteriorMidpoint(objects);
        if not undo then
            pushRotateAction(angle);
        end
        for i, object in ipairs(objects) do
            local pos = object:getPosition();
            local rx, ry, rz = exports["edf"]:edfGetElementRotation(object);

            local x, y = Maths.calculateRotatingObjectPosition(object, angle, midpointX, midpointY);

            exports["edf"]:edfSetElementRotation(object, rx, ry, rz + angle);
            exports["edf"]:edfSetElementPosition(object, x, y, pos.z);
        end
    end
end
addEvent("onInteriorRelocateRotate", true)
addEventHandler("onInteriorRelocateRotate", getRootElement(), onInteriorRelocateRotate)