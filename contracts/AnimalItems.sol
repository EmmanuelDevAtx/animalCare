// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./MathLibrary.sol";

contract AnimalItems {

    struct Item {
        uint16 soap_simple;
        uint16 soap_medium;
        uint16 soap_premium;
        uint16 carrot;
    }

    enum Food {
        soap_simple,
        soap_medium,
        soap_premium,
        carrot
    }

    mapping(address => uint) itemId;
    mapping(address => uint) itemCount;

    Item[] public items;

    function _createOwnerToItem() internal {
        if (itemCount[msg.sender] >= 1) {
            return;
        }
        items.push(Item(2, 2, 1, 3));
        itemId[msg.sender] = items.length - 1;
        itemCount[msg.sender] = itemCount[msg.sender]++;
    }

    function _reduceItem(Food _foodSelected) internal  returns(uint8 points){
        if (_foodSelected == Food.soap_simple) {
            require(
                items[itemId[msg.sender]].soap_simple > 0,
                "You havent yet meal"
            );
            
            items[itemId[msg.sender]].soap_simple = uint8(
                MathLibrary._checkCeroValue(items[itemId[msg.sender]].soap_simple, 1)
            );
            return 2 ;
        }

        if (_foodSelected == Food.soap_medium) {
            require(
                items[itemId[msg.sender]].soap_medium > 0,
                "You havent yet meal"
            );
            
            items[itemId[msg.sender]].soap_medium = uint8(
                MathLibrary._checkCeroValue(items[itemId[msg.sender]].soap_medium, 1)
            );
            return 3;
        }

        if (_foodSelected == Food.soap_premium) {
            require(
                items[itemId[msg.sender]].soap_premium > 0,
                "You havent yet meal"
            );
            
            items[itemId[msg.sender]].soap_premium = uint8(
                MathLibrary._checkCeroValue(items[itemId[msg.sender]].soap_premium, 1)
            );
            return 4;
        }

        if (_foodSelected == Food.carrot) {
            require(
                items[itemId[msg.sender]].carrot > 0,
                "You havent yet meal"
            );
            
            items[itemId[msg.sender]].carrot = uint8(
                MathLibrary._checkCeroValue(items[itemId[msg.sender]].carrot, 1)
            );
            return 3;
        }
    }

    function showItems() public view returns (Item memory item) {
        return items[itemId[msg.sender]];
    }


}
