const fs = require('fs')

try {
  const file = fs.readFileSync('day5.txt', 'utf8');

  var lines = file.split("\n");

  var totals = [];
  lines.forEach(line => {
    totals = totals.concat(getCoordsFromLine(line));
  });

  map = {}
  totals.forEach(function(obj) {
        var key = JSON.stringify(obj)
        map[key] = (map[key] || 0) + 1
    });

    count = 0;
    for (const [key, value] of Object.entries(map)) {
        if(value >= 2){
            count++;
        }
    }

    console.log("Result: "+count);
} catch (err) {
  console.error(err);
}

function getCoordsFromLine(line) {
    var [firstX, secondX, firstY, secondY] = breakUpLine(line);

    var allCoords = [];
    if(firstX == secondX){
        allCoords = allCoords.concat(getNumbersBetween(firstY, secondY, firstX, true));
    }else if (firstY == secondY){
        allCoords = allCoords.concat(getNumbersBetween(firstX, secondX, firstY, false));
    }

    return allCoords;
}

function breakUpLine(line){
    const brokenUp = line.split(",");
    var firstX = parseInt(brokenUp[0]);
    var secondX = parseInt(brokenUp[1].split(" -> ")[1]);
    var firstY = parseInt(brokenUp[1].split(" -> ")[0]);
    var secondY = parseInt(brokenUp[2]);

    return [firstX, secondX, firstY, secondY];
}

function getNumbersBetween(firstCoord, secondCoord, base, baseIsX) {
    var allCoords = [];

    if(firstCoord < secondCoord){
        for (var i = firstCoord; i <= secondCoord; i++) {
            if(baseIsX){
                allCoords.push({"x":base, "y":i});
            }else{
                allCoords.push({"x":i, "y":base});
            }
        }
    }else{
        for (var i = firstCoord; i >= secondCoord; i--) {
            if(baseIsX){
                allCoords.push({"x":base, "y":i});
            }else{
                allCoords.push({"x":i, "y":base});
            }
        }
    }
   

    return allCoords;
}