// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./AnimalHelper.sol";

contract FeedAnimal is AnimalHelper {
    uint8 moduleFeed = 2;
    uint8 moduleFeedIncreasePoints = moduleFeed + 2;
    uint8 maxExcercise = 10;

    uint256 maxLevel = 370;


    function feedAnimal(uint256 _animalId) public validOwner(_animalId) validNeedBathroom(_animalId){
        //First require that your animal get not limit fat to can feed
        require(animals[_animalId].canFeed == true);
        animals[_animalId].feedCount++;

        Animal memory currentAnimal = animals[_animalId];
        
        if(currentAnimal.feedCount % moduleFeed == 0){
            _increaseNeedBathRoom(_animalId);
        }

        if(currentAnimal.feedCount % maxFeed == 0){
            _increasePoints(_animalId, 1);
            animals[_animalId].dirty++;
        }

        if(currentAnimal.feedCount > maxFeed){
            _increaseFat(_animalId);
            animals[_animalId].currentPoints--;
        }

        if(currentAnimal.feedCount >= maxFeed){
            animals[_animalId].canFeed = false;
        }

    }

    function _increaseLevelAnimal(
        uint256 _animalId
    ) private validOwner(_animalId) {
        animals[_animalId].level++;
    }

    function _getFat(uint256 _animalId) private {
        animals[_animalId].fatCount++;
    }
}
