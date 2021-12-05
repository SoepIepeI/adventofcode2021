const fs = require('fs')

try {
  const file = fs.readFileSync('day5.txt', 'utf8');

  var lines = file.split("\n");

  console.log("Result PART 1: "+ processFile(lines, false));
  console.log("Result PART 2: "+ processFile(lines, true));
} catch (err) {
  console.error(err);
}

function processFile(lines, diagonals){
    var totals = [];
  lines.forEach(line => {
    totals = totals.concat(getCoordsFromLine(line, diagonals));
  });

    map = {}
    totals.forEach(function(total) {
        var key = JSON.stringify(total)
        map[key] = (map[key] || 0) + 1
    });

    count = 0;
    for (const [key, value] of Object.entries(map)) {
        if(value >= 2){
            count++;
        }
    }

    return count;
}

function getCoordsFromLine(line, diagonals) {
    var [firstX, secondX, firstY, secondY] = breakUpLine(line);

    var allCoords = [];
    if(firstX == secondX){
        allCoords = allCoords.concat(getNumbersBetween(firstY, secondY, firstX, true));
    }else if (firstY == secondY){
        allCoords = allCoords.concat(getNumbersBetween(firstX, secondX, firstY, false));
    }else if(diagonals){
        allCoords = allCoords.concat(getNumbersBetweenDiagonal(firstX, secondX, firstY, secondY));
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

function getNumbersBetweenDiagonal(firstX, secondX, firstY, secondY) {
    var allCoords = [];

    var diffX = firstX - secondX > 0 ? firstX - secondX : (firstX - secondX)*-1;
    var diffY = firstY - secondY > 0 ? firstY - secondY : (firstY - secondY)*-1;

    if(diffX == diffY){
        if (firstX > secondX && firstY > secondY){
            for (var i = firstX, j = firstY; i >= secondX; i--, j--) {
                allCoords.push({"x":i, "y":j});
            }
        }else if (firstX < secondX && firstY < secondY){
            for (var i = firstX, j = firstY; i <= secondX; i++, j++) {
                allCoords.push({"x":i, "y":j});
            }
        }else if(firstX < secondX && firstY > secondY){
            for (var i = firstX, j = firstY; i <= secondX; i++, j--) {
                allCoords.push({"x":i, "y":j});
            }
        }else if(firstX > secondX && firstY < secondY){
            for (var i = firstX, j = firstY; i >= secondX; i--, j++) {
                allCoords.push({"x":i, "y":j});
            }
        }
    }

    return allCoords;
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