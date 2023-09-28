// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import './FeedingAnimal.sol';

contract AnimalHelper is  FeedingAnimal{
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
}