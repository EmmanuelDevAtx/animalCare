// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./AnimalActions.sol";

contract AnimalsPayable is AnimalActions{

    address payable contractAddress;
    address owner;
    uint valuePrice;
    
    using SafeMath for uint256;
    
    constructor(address payable payableContract){
        contractAddress = payableContract;
        owner = msg.sender;
        valuePrice = 1 ether;

    }
    
    //TODO: put all function payable, and next think about some rewards;
    
    function reduceFatAndTired(uint _animalId) public  payable validOwner(_animalId){
       _payAnimalAction(valuePrice);
       animals[_animalId].tired = uint8(_checkCeroValue(animals[_animalId].tired, 6));
       animals[_animalId].fatCount = uint8(_checkCeroValue(animals[_animalId].fatCount, 6));
    }

    function upgradeLevel(uint _animalId) public  payable validOwner(_animalId){
       _payAnimalAction(valuePrice + 1 ether);
       animals[_animalId].level = animals[_animalId].level.add(10);
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
        // First require that the value price its less or equal user sender eth
        require(msg.value >= _valuaPrice, "Your amount its less that the price");
        
        uint change = msg.value - _valuaPrice;

        contractAddress.transfer(_valuaPrice);
        if(change > 0 ){
            payable(msg.sender).transfer(change);
        }
    }

    function buyMeal(uint _amount, Food _foodSelected) public payable returns(bool){
        uint currentPrice = 1 ether * _amount;
        _payAnimalAction(currentPrice);
        addMeal(_amount, _foodSelected);
        return(true);
    }   


}
