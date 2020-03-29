Maths = {};

function Maths.calculateInteriorMidpoint(objects, dimension)
    local x1, x2, y1, y2, z1, z2;

    for i, object in ipairs(objects) do
        if object:getDimension() == dimension then
            local position = object:getPosition();
                
            if not x1 or position.x < x1 then
                x1 = position.x;
            end
            if not x2 or position.x > x2 then
                x2 = position.x;
            end

            if not y1 or position.y < y1 then
                y1 = position.y;
            end
            if not y2 or position.y > y2 then
                y2 = position.y;
            end

            if not z1 or position.z < z1 then
                z1 = position.z;
            end
            if not z2 or position.z > z2 then
                z2 = position.z;
            end
        end
    end

    local x = x1 + (x2 - x1) / 2;
    local y = y1 + (y2 - y1) / 2;
    local z = z1 + (z2 - z1) / 2;

    return x, y, z;
end

function Maths.calculateMovingObjectAxisAdditions(newMidpoint, midpointX, midpointY, midpointZ)
    local x = newMidpoint.x - midpointX;
    local y = newMidpoint.y - midpointY;
    local z = newMidpoint.z - midpointZ;

    return x, y, z;
end

function Maths.calculateRotatingObjectPosition(object, angle, midpointX, midpointY)
    local objectPosition = object:getPosition();
    local a = math.rad(angle);

    local x = midpointX + (objectPosition.x - midpointX) * math.cos(a) - (objectPosition.y - midpointY) * math.sin(a);
    local y = midpointY + (objectPosition.x - midpointX) * math.sin(a) + (objectPosition.y - midpointY) * math.cos(a);

    return x, y;
end