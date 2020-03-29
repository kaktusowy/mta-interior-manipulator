
function moveInterior(x, y, z, toPosition)
    triggerServerEvent("onInteriorRelocateMove", getLocalPlayer(), x, y, z, toPosition, false, getLocalPlayer():getDimension());
end

function moveInteriorToPosition(position)
    moveInterior(position.x, position.y, position.z, true);
end