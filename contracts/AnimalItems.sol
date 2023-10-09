// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./AnimalFactory.sol";

contract AnimalItems{

    struct Item{
        uint16 soap_simple;
        uint16 soap_medium;
        uint16 soap_premium;
        
        uint16 carrot;
        uint16 anyMeal;
    }
    
    mapping(uint => Address) public itemToOwner;

    Item[] public items;

    funtcion _createOwnerToItem() internal {
        items.push(Item(2, 2, 1, 3, 2));
    }
}