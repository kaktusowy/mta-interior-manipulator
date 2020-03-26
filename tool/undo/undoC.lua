
function undoLastAction()
    triggerServerEvent("onActionUndo", getLocalPlayer());
end

addEvent("onNothingToUndo", true)
addEventHandler("onNothingToUndo", getLocalPlayer(), function()
    outputChatBox("You have nothing left to undo!");
end);