// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract VolcanoCoin {

    uint totalSupply = 10000;
    address owner;
    mapping(address => uint) balances;
    mapping(address => Payment[]) payments;

    event newTotalSupply(uint _totalSupply);
    event newTransfer(address _from, address _to, uint _value);

    struct Payment {
        address recipient;
        uint256 amount;
    }

    constructor() {
        owner = msg.sender;
        balances[owner] = totalSupply;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this.");
        _;
    }

    function getTotalSupply() public view returns (uint) {
        return totalSupply;
    }

    function getBalance(address _address) public view returns (uint) {
        return balances[_address];
    }

    function increaseTotalSupply() public onlyOwner {
        totalSupply += 1000;
        emit newTotalSupply(totalSupply);
    }

    function transfer(address _recipient, uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient funds.");
        balances[msg.sender] -= amount;
        balances[_recipient] += amount;
        emit newTransfer(msg.sender, _recipient, amount);

        Payment memory payment = Payment(_recipient, amount);
        payments[msg.sender].push(payment);
    }

    function getPayments(address _address) public view returns (Payment[] memory) {
        return payments[_address];
    }
}