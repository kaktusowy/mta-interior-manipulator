
function rotateInterior(angle)
    triggerServerEvent("onInteriorRelocateRotate", getLocalPlayer(), angle, false, getLocalPlayer():getDimension());
end