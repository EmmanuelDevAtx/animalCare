// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./AnimalFactory.sol";

contract AnimalHelper is AnimalFactory {
    uint8 maxTargetLevel = 10;
    uint8 maxFeed = 4;

    using SafeMath for uint256;
    using SafeMath for uint8;


    modifier validNeedBathroom(uint256 _animalId) {
        //TODO: mostrar el mensaje de Que "necesita un baño";

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
        if(animals[_animalId].tired > 10 ){
            animals[_animalId].canPlay = false;
        } 

        require(animals[_animalId].canPlay == true );
        _;
    }

    function totalAnimalOwner() public view returns (uint256) {
        return animalOwnerCount[msg.sender];
    }

    function getAnimalsOwner() public view returns (Animal[] memory) {
        Animal[] memory animalsOwner = new Animal[](
            animalOwnerCount[msg.sender]
        );

        uint8 counter = 0;
        for (uint i = 0; i < animals.length; i = i.add(1)) {
            if (animalToOwner[i] == msg.sender) {
                animalsOwner[counter] = animals[i];
                counter = uint8(counter.add(1));
            }
        }

        return animalsOwner;
    }

    function _increasePoints(
        uint256 _animalId,
        uint8 _points
    ) internal validOwner(_animalId) {
        if (animals[_animalId].currentPoints > maxTargetLevel) {
            animals[_animalId].currentPoints = 0;
            animals[_animalId].level = uint8(animals[_animalId].level.add(1));
        } 
        animals[_animalId].currentPoints = uint8(animals[_animalId].currentPoints.add(_points));
    }

    function _increaseNeedBathRoom(uint256 _animalId) internal {
        animals[_animalId].timeBathroomUse = uint256(animals[_animalId].timeBathroomUse.sub(timeWaitBathroom));
    }

    function _increaseFat(uint256 _animalId) internal {
        animals[_animalId].fatCount = uint8(animals[_animalId].fatCount.add(1)) ;
        if (animals[_animalId].fatCount >= maxTargetLevel) {
            animals[_animalId].canFeed = false;
        }
    }

    function _checkCeroValue(uint _value, uint8 _reduceValue) internal pure  returns(uint){
        if(_value != 0){
            return (_value - _reduceValue);
        }
        return 0;
    }
}
