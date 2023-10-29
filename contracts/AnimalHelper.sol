// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./AnimalFactory.sol";

contract AnimalHelper is AnimalFactory {
    uint8 maxTargetLevel = 10;
    uint8 maxFeed = 4;


    modifier validNeedBathroom(uint256 _animalId) {
        if (
            animals[_animalId].timeBathroomUse >
            uint256(block.timestamp + timeWaitBathroom)
        ) {
            animals[_animalId].needsBathroom = true;
        }

        require(!animals[_animalId].needsBathroom,'Necesita ir al bano');
        _;
    }

    modifier animalCanPlay(uint256 _animalId){


        require(animals[_animalId].canPlay == true,'The animal is tired' );
        _;
    }

    function totalAnimalOwner() public view returns (uint256) {
        return animalOwnerCount[msg.sender];
    }

    function getAnimalsOwner() public view returns (uint8[] memory) {
        uint8[] memory animalsOwner = new uint8[](
            animalOwnerCount[msg.sender]
        );

        uint8 counter = 0;
        for (uint8 i = 0; i < animals.length; i++) {
            if (animalToOwner[i] == msg.sender) {
                animalsOwner[counter] = uint8(i);
                counter = uint8(counter + 1);
            }
        }

        return animalsOwner;
    }

    function _increasePoints(
        uint256 _animalId,
        uint8 _points
    ) internal validOwner(_animalId) {

        uint8 _currentPoints = uint8(animals[_animalId].currentPoints + _points);

        if (_currentPoints >= maxTargetLevel) {
            animals[_animalId].currentPoints = (_currentPoints > maxTargetLevel) ? _currentPoints-maxTargetLevel : 0;
            animals[_animalId].level = uint8(animals[_animalId].level + _points);
        }else{
            animals[_animalId].currentPoints = _currentPoints; 
        }
    }

    function _increaseNeedBathRoom(uint256 _animalId) internal {
        animals[_animalId].timeBathroomUse = uint256(animals[_animalId].timeBathroomUse - timeWaitBathroom);
    }

    function _increaseFat(uint256 _animalId) internal {
        animals[_animalId].fatCount = uint8(animals[_animalId].fatCount + 1) ;
        if (animals[_animalId].fatCount >= maxTargetLevel) {
            animals[_animalId].canFeed = false;
        }
    }

}
