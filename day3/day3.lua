local file = io.open("day3.txt", "r");
local arr = {}
for line in file:lines() do
    table.insert (arr, line);
end

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

print(tonumber(Gamma, 2));
print(tonumber(Epsilon, 2));
print("-------------------");
print(tonumber(Gamma, 2) * tonumber(Epsilon, 2));