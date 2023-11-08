//SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./AnimalActions.sol";

contract AnimalsPayable is AnimalActions{

    address payable contractAddress;
    address owner;
    uint valuePrice;
    
    
    constructor(address payable payableContract){
        contractAddress = payableContract;
        owner = msg.sender;
        valuePrice = 0.0001 ether;

    }
    
    //TODO: put all function payable, and next think about some rewards;
    
    function reduceFatAndTired(uint _animalId) public  payable validOwner(_animalId) {
       _payAnimalAction(valuePrice);
       animals[_animalId].tired = uint8(MathLibrary._checkCeroValue(animals[_animalId].tired, 6));
       animals[_animalId].fatCount = uint8(MathLibrary._checkCeroValue(animals[_animalId].fatCount, 6));
    }

    function upgradeLevel(uint _animalId) public  payable validOwner(_animalId) {
       _payAnimalAction(valuePrice);
       animals[_animalId].level = animals[_animalId].level + 10;
    }

    function changeContractPayable(address payable _contractAddress) public {
        require(owner == msg.sender);
        contractAddress = _contractAddress;
    }

    function updatePrice(uint _amount) public {
        require(owner == msg.sender);
        valuePrice = _amount;
    }

    function _payAnimalAction(uint _valuaPrice) internal {
        require(msg.value >= _valuaPrice, "Your amount its less that the price");
        
        uint change = msg.value - _valuaPrice;

        contractAddress.transfer(_valuaPrice);
        if(change > 0 ){
            payable(msg.sender).transfer(change);
        }
    }

    function buyPoints(uint _amount) public payable returns(bool){
        require(ownerPoints[msg.sender] > maxLevelAndPoints, 'Check your points, max are 500');
        uint currentPrice = valuePrice * _amount;
        _payAnimalAction(currentPrice);
        ownerPoints[msg.sender] = MathLibrary._checkMaxNumber(ownerPoints[msg.sender] + _amount, maxLevelAndPoints);
        return(true);
    }   


}
