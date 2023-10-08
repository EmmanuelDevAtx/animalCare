//SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./FeedAnimal.sol";

contract AnimalActions is FeedAnimal {

    using SafeMath for uint8;

    function useBath(uint256 _animalId) public validOwner(_animalId) {
        uint256 currentTime = uint256(block.timestamp) + timeReduceBathroom;
        require(animals[_animalId].timeBathroomUse < block.timestamp, 'El tiempo del uso del bathroom debe ser mayor');
        animals[_animalId].timeBathroomUse = currentTime;
        _increasePoints(_animalId, 1);
        animals[_animalId].dirty = uint8(_checkMaxNumber(animals[_animalId].dirty.add(1)));
    }

    function doExercise(uint256 _animalId) public validOwner(_animalId) {
        require(animals[_animalId].exerciseCount < maxTargetLevel);
        animals[_animalId].exerciseCount = uint8(_checkMaxNumber(animals[_animalId].exerciseCount.add(1)));
        _increaseNeedBathRoom(_animalId);

        //TODO hacer un Random entre 1 - 2
        uint8 points = 2;

        _increasePoints(_animalId, points);
        
        animals[_animalId].dirty = uint8(_checkMaxNumber(animals[_animalId].dirty.add(1)));
        animals[_animalId].tired = uint8(_checkMaxNumber(animals[_animalId].tired.add(1)));
    }

    function takeABath(uint256 _animalId) public validOwner(_animalId) {
        require(animals[_animalId].dirty > 0);

        if ((animals[_animalId].dirty / 2) == 5) {
            _increasePoints(_animalId, 1);
        }
         animals[_animalId].tired = uint8(_checkCeroValue(animals[_animalId].tired, 2));
        animals[_animalId].dirty = uint8(_checkCeroValue(animals[_animalId].dirty,4));
        _increaseNeedBathRoom(_animalId);
    }

    function play(uint256 _animalId) public validOwner(_animalId) animalCanPlay(_animalId){
        //TODO hacer un Random entre 1 - 3;
        uint8 pointsPlay = 2;

        _increasePoints(_animalId, pointsPlay);
        animals[_animalId].tired = uint8(_checkMaxNumber(animals[_animalId].tired.add(pointsPlay)));
        animals[_animalId].dirty = uint8(_checkMaxNumber(animals[_animalId].dirty.add(pointsPlay - 1)));


    }
}
