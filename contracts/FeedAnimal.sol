// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./AnimalHelper.sol";

contract FeedAnimal is AnimalHelper {
    uint8 moduleFeed = 2;
    uint8 moduleFeedIncreasePoints = moduleFeed + 2;
    uint8 maxExcercise = 10;

    uint256 maxLevel = 370;


    function feedAnimal(uint256 _animalId, Food _foodSelected) public validOwner(_animalId) validNeedBathroom(_animalId) {
        //First require that your animal get not limit fat to can feed
        require(animals[_animalId].canFeed == true);
        animals[_animalId].feedCount = uint8(MathLibrary._checkMaxNumber(animals[_animalId].feedCount + 1, maxTargetLevel));
        uint8 points = _reduceItem(_foodSelected);
        _addPoints(points);
        
        if(animals[_animalId].feedCount % moduleFeed == 0){
            _increaseNeedBathRoom(_animalId);
        }

        if(animals[_animalId].feedCount % maxFeed == 0){
            _increasePoints(_animalId, 1);
            animals[_animalId].dirty = uint8(MathLibrary._checkMaxNumber(animals[_animalId].dirty + 1, maxTargetLevel));
        }

        if(animals[_animalId].feedCount > maxFeed){
            _increaseFat(_animalId);

            animals[_animalId].exerciseCount = uint8(MathLibrary._checkCeroValue(animals[_animalId].exerciseCount, 1));
            
        }

        if(animals[_animalId].feedCount >= maxTargetLevel){
            animals[_animalId].canFeed = false;
        }


    }

    function _increaseLevelAnimal(
        uint256 _animalId
    ) private  validOwner(_animalId)  {
        animals[_animalId].level = animals[_animalId].level + 1;
    }

}
