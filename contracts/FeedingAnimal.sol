// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./AnimalFactory.sol";

contract FeedingAnimal is AnimalFactory {
    uint8 private maxFeed = 3;

    modifier validOwner(uint256 _animalId) {
        require(animalToOwner[_animalId] == msg.sender);
        _;
    }

    function feedAnimal(uint256 _animalId) public validOwner(_animalId) {
        if (animals[_animalId].countFeed >= maxFeed) {
            animals[_animalId].countFeed = 0;
            _increaseLevelAnimal(_animalId);
        }
        animals[_animalId].countFeed++;
    }

    function _increaseLevelAnimal(
        uint256 _animalId
    ) private validOwner(_animalId) {
        animals[_animalId].level++;
    }
}
