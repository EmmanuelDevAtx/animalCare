// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

import "./AnimalActions.sol";

contract AnimalsPayable is AnimalActions{

    function payAnyEht(address payable _to) payable {
        _to.transfer(msg.value);
    }

    function showAmount() view returns(uint256){
        return address(this).balance;
    }
}
