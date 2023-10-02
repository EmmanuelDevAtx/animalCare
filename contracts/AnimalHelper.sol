// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./AnimalFactory.sol";

contract AnimalHelper is AnimalFactory {
    uint8 maxPoints = 10;
    uint8 maxFeed = 4;
    uint8 maxFeedFat = maxFeed * 2;
    uint8 maxTired = 10;
    uint256 timeWaitBathroom = 3 minutes;

    modifier validNeedBathroom(uint256 _animalId) {
        //TODO: mostrar el mensaje de Que "necesita un baño";

        if (
            animals[_animalId].timeBathroomUse >
            uint256(block.timestamp + timeWaitBathroom)
        ) {
            animals[_animalId].needsBathroom = true;
        }

        require(!animals[_animalId].needsBathroom);
        _;
    }

    modifier animalCanPlay(uint256 _animalId){
        if(animals[_animalId].tired > (maxTired / 2) ){
            animals[_animalId].canPlay = true;
        } 

        require(animals[_animalId].canPlay);
        _;
    }

    function totalAnimalOwner() public view returns (uint256) {
        return animalOwnerCount[msg.sender];
    }

    function getAnimalsOwner() public view returns (Animal[] memory) {
        Animal[] memory animalsOwner = new Animal[](
            animalOwnerCount[msg.sender]
        );

        uint counter = 0;
        for (uint i = 0; i < animals.length; i++) {
            if (animalToOwner[i] == msg.sender) {
                animalsOwner[counter] = animals[i];
                counter++;
            }
        }

        return animalsOwner;
    }

    function _increasePoints(
        uint256 _animalId,
        uint8 _points
    ) internal validOwner(_animalId) {
        if (animals[_animalId].currentPoints > maxPoints) {
            animals[_animalId].currentPoints = 0;
            animals[_animalId].currentPoints += _points;
            animals[_animalId].level++;
        } else {
            animals[_animalId].currentPoints += _points;
        }
    }

    function _increaseNeedBathRoom(uint256 _animalId) internal {
        animals[_animalId].timeBathroomUse -= timeWaitBathroom;
    }

    function _increaseFat(uint256 _animalId) internal {
        animals[_animalId].fatCount++;
        if (animals[_animalId].fatCount >= maxFeedFat) {
            animals[_animalId].canFeed = false;
        }
    }
}
