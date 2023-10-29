//SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./AnimalItems.sol";

contract AnimalReward is AnimalItems{

    mapping(address => uint) public ownerPoints;
    mapping(address => bool) havePoints;

    function _createPoints() internal {
        if(!havePoints[msg.sender]){
            ownerPoints[msg.sender] = 0;
            havePoints[msg.sender] = true;
        }
    }

    function _addPoints( uint8 _points) internal {
        ownerPoints[msg.sender] = ownerPoints[msg.sender] + _points;
    }

    function getMeal(Food _foodSelected, uint amount) public {
        if (_foodSelected == Food.soap_simple) {
            require(ownerPoints[msg.sender] >= amount * 3, "You need more points");
            items[itemId[msg.sender]].soap_simple = uint16(items[itemId[msg.sender]].soap_simple + amount);
            ownerPoints[msg.sender] = MathLibrary._checkCeroValue(ownerPoints[msg.sender],amount * 3);
            return;
        }

        if (_foodSelected == Food.soap_medium) {
            require(ownerPoints[msg.sender] >= amount * 5, "You need more points");
            items[itemId[msg.sender]].soap_medium = uint16(items[itemId[msg.sender]].soap_medium + amount); 
            ownerPoints[msg.sender] = MathLibrary._checkCeroValue(ownerPoints[msg.sender],amount * 5);
            return;
        }

        if (_foodSelected == Food.soap_premium) {
            require(ownerPoints[msg.sender] >= amount * 8, "You need more points");
            items[itemId[msg.sender]].soap_premium = uint16(items[itemId[msg.sender]].soap_premium + amount);
            
            ownerPoints[msg.sender] = MathLibrary._checkCeroValue(ownerPoints[msg.sender],amount * 8);
            return;
        }

        if (_foodSelected == Food.carrot) {
            require(ownerPoints[msg.sender] >= amount * 3, "You need more points");
            items[itemId[msg.sender]].carrot = uint16(items[itemId[msg.sender]].carrot + amount);
            
            ownerPoints[msg.sender] = MathLibrary._checkCeroValue(ownerPoints[msg.sender],amount * 3);
            return;
        }

    }
}