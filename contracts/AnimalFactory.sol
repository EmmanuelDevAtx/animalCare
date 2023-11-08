// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./AnimalRewards.sol";

contract AnimalFactory is AnimalReward{

    struct Animal {

        string name;

        uint8 fatCount;
        uint8 feedCount;
        uint8 currentPoints;
        uint8 exerciseCount;
        uint8 dirty;
        uint8 tired;

        uint256 level;
        uint256 timeBathroomUse;

        bool needsBathroom;
        bool canPlay;
        bool canFeed;
    }

    event NewAnimal(string name, uint level);
    
    uint16 maxLevelAndPoints = 500;

    uint256 timeWaitBathroom = 2 hours;
    uint256 timeReduceBathroom = 1 hours;

    mapping(uint => address) public animalToOwner;
    mapping(address => uint) animalOwnerCount;

    mapping(uint => address) public shareAnimalWith;
    mapping(address => uint8 ) public countSharedOwnAnimal;

    Animal[] public animals;

    modifier validOwner(uint256 _animalId) {
        require(animalToOwner[_animalId] == msg.sender  || shareAnimalWith[_animalId] == msg.sender, 'You are not the owner');
        _;
    }

    function createNewAnimal(string memory _name) public {
        require(animalOwnerCount[msg.sender] < 3);
        animals.push(Animal(_name, 0,0,0,5,0,0, 0,uint256(block.timestamp + timeWaitBathroom), false, true, true));
        emit NewAnimal(_name, 0);
        _createPoints();
        animalToOwner[animals.length - 1] = msg.sender;
        animalOwnerCount[msg.sender] = animalOwnerCount[msg.sender] + 1;
        _createOwnerToItem();
    }
}
