// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./AnimalActions.sol";

contract AnimalsPayable is AnimalActions{

    address payable contractAddress;
    address owner;
    
    constructor(address payable payableContract){
        contractAddress = payableContract;
        owner = msg.sender;
    }


    //Todo: Update this function like, reduceFat, excecie etc..
    function payAnyEht() public  payable {
        contractAddress.transfer(msg.value);
    }

    function changeContractPayable(address payable _contractAddress) public {
        require(owner == msg.sender);
        contractAddress = _contractAddress;
    }


}
