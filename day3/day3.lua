local file = io.open("day3.txt", "r");
local arr = {}
for line in file:lines() do
    table.insert (arr, line);
end

-- PART 1
Gamma = "";
Epsilon = "";

for i = 1, #arr[1] do
    local total = 0;
    local totalPositives = 0;

    for s, arrElem in ipairs(arr) do
        total = total + 1;
        totalPositives = totalPositives + tonumber(string.sub(arrElem, i, i));
    end

    local result = (total / 2) < totalPositives;

    if(result) then
        print("positive");
        Gamma = Gamma .. "1";
        Epsilon = Epsilon .. "0";
    else
        print("negative");
        Gamma = Gamma .. "0";
        Epsilon = Epsilon .. "1";
    end
end

print(tonumber(Gamma, 2) * tonumber(Epsilon, 2));


-- PART 2
local index = 1;

function SplitNumbers(data, iGiveUpTryingToDoItInOneGo)
    local negative = {};
    local positive = {};
    for s, arrElem in ipairs(data) do
        local value = string.sub(arrElem, index, index);
        table.insert((value == "0" and negative or positive), arrElem);
    end

    index = index + 1;
    
    if (#positive == 1 and #negative == 1) then
        return iGiveUpTryingToDoItInOneGo and positive or negative;
    end

    return iGiveUpTryingToDoItInOneGo and SplitNumbers((#positive >= #negative and positive or negative), iGiveUpTryingToDoItInOneGo) or SplitNumbers((#positive >= #negative and negative or positive), iGiveUpTryingToDoItInOneGo);
end

local oxygen = SplitNumbers(arr, true);
index = 1;
local co2 = SplitNumbers(arr, false);

print(tonumber(oxygen[1], 2) * tonumber(co2[1], 2));

