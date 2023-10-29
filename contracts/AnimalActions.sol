//SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./FeedAnimal.sol";

contract AnimalActions is FeedAnimal {
    

    function sharedAnimal(uint256 _animalId, address _targetUser) public validOwner(_animalId){
        require(countSharedOwnAnimal[msg.sender] < 3, 'You cannot share more animals');
        require(countSharedOwnAnimal[_targetUser] < 3, 'You cannot share more animals with him');

        shareAnimalWith[_animalId] = _targetUser;
        countSharedOwnAnimal[msg.sender] = uint8(countSharedOwnAnimal[msg.sender]+ 1);
        countSharedOwnAnimal[_targetUser] = uint8(countSharedOwnAnimal[_targetUser]+1);
    }

    function removeShareAnimal(uint256 _animalId) public validOwner(_animalId){
        countSharedOwnAnimal[msg.sender] = uint8(MathLibrary._checkCeroValue(countSharedOwnAnimal[msg.sender], 1));
        countSharedOwnAnimal[shareAnimalWith[_animalId]] = uint8(MathLibrary._checkCeroValue(countSharedOwnAnimal[shareAnimalWith[_animalId]], 1));
        shareAnimalWith[_animalId] = msg.sender;
    }

     function getShareAnimal() public view returns (uint8[] memory) {
        uint8[] memory animalsOwner = new uint8[](
            countSharedOwnAnimal[msg.sender]
        );

        uint8 counter = 0;
        for (uint i = 0; i < animals.length; i++) {
            if (shareAnimalWith[i] == msg.sender) {
                animalsOwner[counter] = uint8(i);
                counter = uint8(counter + 1);
            }
        }

        return animalsOwner;
    }

    function useBath(uint256 _animalId) public validOwner(_animalId) validPermisions(_animalId) {
        uint256 currentTime = uint256(block.timestamp) + timeReduceBathroom;
        require(
            animals[_animalId].timeBathroomUse < block.timestamp,
            "El tiempo del uso del bathroom debe ser mayor"
        );
        _addPoints(2);
        animals[_animalId].timeBathroomUse = currentTime;
        _increasePoints(_animalId, 1);
        animals[_animalId].dirty = uint8(
            MathLibrary._checkMaxNumber(animals[_animalId].dirty++, maxTargetLevel)
        );
    }

    function doExercise(uint256 _animalId) public validOwner(_animalId) validPermisions(_animalId) {
        require(animals[_animalId].exerciseCount < maxTargetLevel);
        animals[_animalId].exerciseCount = uint8(
            MathLibrary._checkMaxNumber(animals[_animalId].exerciseCount++, maxTargetLevel)
        );
        _increaseNeedBathRoom(_animalId);
        _addPoints(2);

        _increasePoints(_animalId, 2);

        animals[_animalId].dirty = uint8(
            MathLibrary._checkMaxNumber(animals[_animalId].dirty++, maxTargetLevel)
        );
        animals[_animalId].tired = uint8(
            MathLibrary._checkMaxNumber(animals[_animalId].tired++, maxTargetLevel)
        );
    }

    function takeABath(uint256 _animalId) public validOwner(_animalId) validPermisions(_animalId) {
        require(animals[_animalId].dirty > 0);
        _addPoints(2);
        if ((animals[_animalId].dirty / 2) == 5) {
            _increasePoints(_animalId, 1);
        }
        animals[_animalId].tired = uint8(
            MathLibrary._checkCeroValue(animals[_animalId].tired, 2)
        );
        animals[_animalId].dirty = uint8(
            MathLibrary._checkCeroValue(animals[_animalId].dirty, 4)
        );
        _increaseNeedBathRoom(_animalId);
    }

    function play(
        uint256 _animalId
    ) public validOwner(_animalId) animalCanPlay(_animalId) validPermisions(_animalId) {
        
        uint8 pointsPlay = 2;
        _addPoints(2);
        _increasePoints(_animalId, pointsPlay);
        animals[_animalId].tired = uint8(
            MathLibrary._checkMaxNumber(animals[_animalId].tired + pointsPlay, maxTargetLevel)
        );
        animals[_animalId].dirty = uint8(
            MathLibrary._checkMaxNumber(animals[_animalId].dirty + (pointsPlay - 1), maxTargetLevel)
        );
        if(animals[_animalId].tired >= maxTargetLevel ){
            animals[_animalId].canPlay = false;
        } 
    }
}
