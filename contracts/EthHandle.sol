// SPDX-License-Identifier: Mit
pragma solidity ^0.8.9;

contract ethReciver {

    address owner;

    event log(uint amount, uint gas);

    constructor(){
        owner = msg.sender;
    }

    modifier validOwner(address _owner){
        require(_owner == owner,"Only owner can do all");
        _;
    }

    receive() external payable {
        emit log(address(this).balance, gasleft()   );
    }

    function shoBalance() public view validOwner(msg.sender) returns(uint256){
        return address(this).balance;
    }

    function reciveAllEth(address payable _to) public  payable validOwner(msg.sender){
        _to.transfer(address(this).balance);
    }
}