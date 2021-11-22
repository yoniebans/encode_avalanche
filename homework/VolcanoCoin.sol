// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract VolcanoCoin {

    uint totalSupply = 10000;
    address owner;

    event newTotalSupply(uint _totalSupply);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if (msg.sender == owner){
            _;
        }
    }

    function getTotalSupply() public view returns (uint) {
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner {
        totalSupply += 1000;
        emit newTotalSupply(totalSupply);
    }

}