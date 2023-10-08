// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./AnimalHelper.sol";

contract FeedAnimal is AnimalHelper {
    uint8 moduleFeed = 2;
    uint8 moduleFeedIncreasePoints = moduleFeed + 2;
    uint8 maxExcercise = 10;

    uint256 maxLevel = 370;

    using SafeMath for uint8;
    using SafeMath for uint256;


    function feedAnimal(uint256 _animalId) public validOwner(_animalId) validNeedBathroom(_animalId){
        //First require that your animal get not limit fat to can feed
        require(animals[_animalId].canFeed == true);
        animals[_animalId].feedCount = uint8(_checkMaxNumber(animals[_animalId].feedCount.add(1)));

        Animal memory currentAnimal = animals[_animalId];
        
        if(currentAnimal.feedCount % moduleFeed == 0){
            _increaseNeedBathRoom(_animalId);
        }

        if(currentAnimal.feedCount % maxFeed == 0){
            _increasePoints(_animalId, 1);
            animals[_animalId].dirty = uint8(_checkMaxNumber(animals[_animalId].dirty.add(1)));
        }

        if(currentAnimal.feedCount > maxFeed){
            _increaseFat(_animalId);

            animals[_animalId].exerciseCount = uint8(_checkCeroValue(animals[_animalId].exerciseCount, 1));
            
        }

        if(currentAnimal.feedCount >= maxTargetLevel){
            animals[_animalId].canFeed = false;
        }


    }

    function _increaseLevelAnimal(
        uint256 _animalId
    ) private  validOwner(_animalId)  {
        animals[_animalId].level = animals[_animalId].level.add(1);
    }

}
