var fishies = [3,1,5,4,4,4,5,3,4,4,1,4,2,3,1,3,3,2,3,2,5,1,1,4,4,3,2,4,2,4,1,5,3,3,2,2,2,5,5,1,3,4,5,1,5,5,1,1,1,4,3,2,3,3,3,4,4,4,5,5,1,3,3,5,4,5,5,5,1,1,2,4,3,4,5,4,5,2,2,3,5,2,1,2,4,3,5,1,3,1,4,4,1,3,2,3,2,4,5,2,4,1,4,3,1,3,1,5,1,3,5,4,3,1,5,3,3,5,4,2,3,4,1,2,1,1,4,4,4,3,1,1,1,1,1,4,2,5,1,1,2,1,5,3,4,1,5,4,1,3,3,1,4,4,5,3,1,1,3,3,3,1,1,5,4,2,5,1,1,5,5,1,4,2,2,5,3,1,1,3,3,5,3,3,2,4,3,2,5,2,5,4,5,4,3,2,4,3,5,1,2,2,4,3,1,5,5,1,3,1,3,2,2,4,5,4,2,3,2,3,4,1,3,4,2,5,4,4,2,2,1,4,1,5,1,5,4,3,3,3,3,3,5,2,1,5,5,3,5,2,1,1,4,2,2,5,1,4,3,3,4,4,2,3,2,1,3,1,5,2,1,5,1,3,1,4,2,4,5,1,4,5,5,3,5,1,5,4,1,3,4,1,1,4,5,5,2,1,3,3];

function processFishies(days){
    var fishiesByDay = {
        0: fishies.filter((fishy) => {return fishy == 0}).length,
        1: fishies.filter((fishy) => {return fishy == 1}).length,
        2: fishies.filter((fishy) => {return fishy == 2}).length,
        3: fishies.filter((fishy) => {return fishy == 3}).length,
        4: fishies.filter((fishy) => {return fishy == 4}).length,
        5: fishies.filter((fishy) => {return fishy == 5}).length,
        6: fishies.filter((fishy) => {return fishy == 6}).length,
        7: fishies.filter((fishy) => {return fishy == 7}).length,
        8: fishies.filter((fishy) => {return fishy == 8}).length
    };
    
    for(i = 1; i <= days; i++){
        const duplicatingFishies = fishiesByDay[0];
        fishiesByDay[0] = fishiesByDay[1];
        fishiesByDay[1] = fishiesByDay[2];
        fishiesByDay[2] = fishiesByDay[3];
        fishiesByDay[3] = fishiesByDay[4];
        fishiesByDay[4] = fishiesByDay[5];
        fishiesByDay[5] = fishiesByDay[6];
        fishiesByDay[6] = fishiesByDay[7] + duplicatingFishies;
        fishiesByDay[7] = fishiesByDay[8];
        fishiesByDay[8] = duplicatingFishies;
    }
    
    var result = 0;
    
    for (const [key, value] of Object.entries(fishiesByDay)) {
        result += value;
    }

    return result;
}


console.log("Result PART 1: "+processFishies(80));
console.log("Result PART 2: "+processFishies(256));