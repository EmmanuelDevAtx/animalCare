// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./AnimalFactory.sol";

contract FeedingAnimal is AnimalFactory {
    uint8 private limitPoints = 9;
    uint8 private maxFeed = 3;
    uint8 private limitFat = 6;

    uint8 private timeWait = 1 minutes;

    function feedAnimal(uint256 _animalId) public validOwner(_animalId) {
        //First require that your animal get not limit fat to can feed
        require(
            animals[_animalId].feedCount <= limitFat
        );

        if (animals[_animalId].feedCount == maxFeed) {
            _increaseLevelAnimal(_animalId);
        }

        if (animals[_animalId].feedCount == maxFeed) {

        }
    }

    function _increaseCurrentPoints(
        uint256 _animalId
    ) external validOwner(_animalId) {
        //It gonna valid if the animal countFeed croos
        if (animals[_animalId].currentPoints >= limitPoints) {
            animals[_animalId].currentPoints = 0;
            _increaseLevelAnimal(_animalId);
        }
        animals[_animalId].currentPoints++;
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
