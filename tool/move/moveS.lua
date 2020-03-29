
function onInteriorRelocateMove(x, y, z, toPosition, undo, dimension)
    local editorResource = getResourceFromName("editor_main");
    if not editorResource then
        outputDebugString("MTA Map Editor is required to use this addon.");
        return;
    end

    local rootElement = getResourceRootElement(editorResource);
    if rootElement and isElement(rootElement) then
        local objects = getElementsByType("object", rootElement);
        local midpointX, midpointY, midpointZ = Maths.calculateInteriorMidpoint(objects, dimension);
        local aX, aY, aZ = Maths.calculateMovingObjectAxisAdditions(Vector3(x, y, z), midpointX, midpointY, midpointZ);
        if not undo then
            if toPosition then
                pushMoveAction(aX, aY, aZ, dimension);
            else
                pushMoveAction(x, y, z, dimension);
            end
        end
        for i, object in ipairs(objects) do
            if object:getDimension() == dimension then
                local pos = object:getPosition();
                local newPos;

                if toPosition then
                    newPos = Vector3(pos.x + aX, pos.y + aY, pos.z + aZ);
                else
                    newPos = Vector3(pos.x + x, pos.y + y, pos.z + z);
                end
                
                exports["edf"]:edfSetElementPosition(object, newPos.x, newPos.y, newPos.z);
            end
        end
    end
end
addEvent("onInteriorRelocateMove", true)
addEventHandler("onInteriorRelocateMove", getRootElement(), onInteriorRelocateMove)