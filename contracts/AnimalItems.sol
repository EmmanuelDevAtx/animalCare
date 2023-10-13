// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract AnimalItems {
    using SafeMath for uint256;

    struct Item {
        uint16 soap_simple;
        uint16 soap_medium;
        uint16 soap_premium;
        uint16 carrot;
        uint16 anyMeal;
    }

    enum Food {
        soap_simple,
        soap_medium,
        soap_premium,
        carrot,
        anyMeal
    }

    mapping(address => uint) itemId;
    mapping(address => uint) itemCount;

    Item[] public items;

    function _createOwnerToItem() internal {
        if (itemCount[msg.sender] >= 1) {
            return;
        }
        items.push(Item(2, 2, 1, 3, 2));
        itemId[msg.sender] = items.length - 1;
        itemCount[msg.sender] = itemCount[msg.sender].add(1);
    }

    function _reduceItem(Food _foodSelected) internal {
        if (_foodSelected == Food.soap_simple) {
            require(
                items[itemId[msg.sender]].soap_simple > 0,
                "You havent yet meal"
            );
            items[itemId[msg.sender]].soap_simple = uint8(
                _checkCeroValue(items[itemId[msg.sender]].soap_simple, 1)
            );
            return;
        }

        if (_foodSelected == Food.soap_medium) {
            require(
                items[itemId[msg.sender]].soap_medium > 0,
                "You havent yet meal"
            );
            items[itemId[msg.sender]].soap_medium = uint8(
                _checkCeroValue(items[itemId[msg.sender]].soap_medium, 1)
            );
            return;
        }

        if (_foodSelected == Food.soap_premium) {
            require(
                items[itemId[msg.sender]].soap_premium > 0,
                "You havent yet meal"
            );
            items[itemId[msg.sender]].soap_premium = uint8(
                _checkCeroValue(items[itemId[msg.sender]].soap_premium, 1)
            );
            return;
        }

        if (_foodSelected == Food.carrot) {
            require(
                items[itemId[msg.sender]].carrot > 0,
                "You havent yet meal"
            );
            items[itemId[msg.sender]].carrot = uint8(
                _checkCeroValue(items[itemId[msg.sender]].carrot, 1)
            );
            return;
        }

        if (_foodSelected == Food.anyMeal) {
            require(
                items[itemId[msg.sender]].anyMeal > 0,
                "You havent yet meal"
            );
            items[itemId[msg.sender]].anyMeal = uint8(
                _checkCeroValue(items[itemId[msg.sender]].anyMeal, 1)
            );
            return;
        }
    }

    function _checkCeroValue(
        uint _value,
        uint8 _reduceValue
    ) internal pure returns (uint) {
        if (_value < _reduceValue) {
            return 0;
        }
        if (_value != 0) {
            return (_value - _reduceValue);
        }
        return 0;
    }

    function showItems() public view returns (Item memory item) {
        return items[itemId[msg.sender]];
    }

    function addMeal(uint amount, Food _foodSelected) internal {
        if (_foodSelected == Food.soap_simple) {
            items[itemId[msg.sender]].soap_simple = items[itemId[msg.sender]].soap_simple.add(amount);
            return;
        }

        if (_foodSelected == Food.soap_medium) {
            items[itemId[msg.sender]].soap_medium = items[itemId[msg.sender]].soap_medium.add(amount);
            return;
        }

        if (_foodSelected == Food.soap_premium) {
            items[itemId[msg.sender]].soap_premium = items[itemId[msg.sender]].soap_premium.add(amount);
            return;
        }

        if (_foodSelected == Food.carrot) {
            items[itemId[msg.sender]].carrot = items[itemId[msg.sender]].carrot.add(amount);
            return;
        }

        if (_foodSelected == Food.anyMeal) {
            items[itemId[msg.sender]].anyMeal = items[itemId[msg.sender]].anyMeal.add(amount);
            return;
        }
    }
}
