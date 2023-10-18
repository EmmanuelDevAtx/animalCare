//SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./AnimalItems.sol";

contract AnimalReward is AnimalItems{

    using SafeMath for uint256;

    mapping(address => uint) public ownerPoints;
    mapping(address => bool) havePoints;

    function _createPoints() internal {
        if(!havePoints[msg.sender]){
            ownerPoints[msg.sender] = 0;
            havePoints[msg.sender] = true;
        }
    }

    function _addPoints( uint8 _points) public {
        ownerPoints[msg.sender] = ownerPoints[msg.sender].add(_points);
    }

    function getMeal(Food _foodSelected, uint amount) public {
        if (_foodSelected == Food.soap_simple) {
            require(ownerPoints[msg.sender] >= amount * 3, "You need more points");
            addMeal(amount, _foodSelected);
            ownerPoints[msg.sender] = _checkCeroValue(ownerPoints[msg.sender],amount * 3);
            return;
        }

        if (_foodSelected == Food.soap_medium) {
            require(ownerPoints[msg.sender] >= amount * 5, "You need more points");
            addMeal(amount, _foodSelected);
            ownerPoints[msg.sender] = _checkCeroValue(ownerPoints[msg.sender],amount * 5);
            return;
        }

        if (_foodSelected == Food.soap_premium) {
            require(ownerPoints[msg.sender] >= amount * 8, "You need more points");
            addMeal(amount, _foodSelected);
            ownerPoints[msg.sender] = _checkCeroValue(ownerPoints[msg.sender],amount * 8);
            return;
        }

        if (_foodSelected == Food.carrot) {
            require(ownerPoints[msg.sender] >= amount * 3, "You need more points");
            addMeal(amount, _foodSelected);
            ownerPoints[msg.sender] = _checkCeroValue(ownerPoints[msg.sender],amount * 3);
            return;
        }

        if (_foodSelected == Food.anyMeal) {
            require(ownerPoints[msg.sender] >= amount * 10, "You need more points");
            addMeal(amount, _foodSelected);
            ownerPoints[msg.sender] = _checkCeroValue(ownerPoints[msg.sender],amount * 10);
            return;
        }
    }
}