//SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./FeedAnimal.sol";

contract AnimalActions is FeedAnimal {
    function useBath(uint256 _animalId) public validOwner(_animalId) {
        uint256 currentTime = uint256(block.timestamp) + timeWaitBathroom;
        require(animals[_animalId].timeBathroomUse > currentTime);
        animals[_animalId].timeBathroomUse = currentTime;
        _increasePoints(_animalId, 1);
        animals[_animalId].dirty++;
    }

    function doExercise(uint256 _animalId) public validOwner(_animalId) {
        require(animals[_animalId].exerciseCount <= maxExcercise);
        animals[_animalId].exerciseCount++;
        _increaseNeedBathRoom(_animalId);

        //TODO hacer un Random entre 1 - 2
        uint8 points = 2;

        _increasePoints(_animalId, points);
        animals[_animalId].dirty++;
        animals[_animalId].tired++;
    }

    function takeABath(uint256 _animalId) public validOwner(_animalId) {
        require(animals[_animalId].dirty > 0);
        if ((animals[_animalId].dirty / 2) == 5) {
            _increasePoints(_animalId, 1);
        }
        animals[_animalId].dirty -= 4;
        _increaseNeedBathRoom(_animalId);
    }

    function play(uint256 _animalId) public validOwner(_animalId) animalCanPlay(_animalId){

        //TODO hacer un Random entre 1 - 3;
        uint8 pointsPlay = 2;

        _increasePoints(_animalId, pointsPlay);
        animals[_animalId].tired += pointsPlay;
        animals[_animalId].dirty += (pointsPlay - 1);

        if(animals[_animalId].tired >= maxTired){
            animals[_animalId].canPlay = false;
        }
        
    }
}
