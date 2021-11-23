// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract VolcanoCoin is ERC20("VolcanoCoin", "VLC"), Ownable {

    uint256 constant initialSupply = 10000;
    mapping(address => Payment[]) public payments;
    event supplyChanged(uint _changeAmount);
    event newTransfer(address _from, address _to, uint _value);

    struct Payment {
        address recipient;
        uint256 amount;
    }

    constructor() {
        _mint(msg.sender, initialSupply);
    }

    function addToTotalSupply(uint _amount) public onlyOwner {
        _mint(msg.sender, _amount);
        emit supplyChanged(_amount);
    }

    function transfer(address _recipient, uint amount) public virtual override returns (bool) {
        _transfer(msg.sender, _recipient, amount);
        addPaymentRecord(msg.sender, _recipient, amount);
        return true;
    }

    function addPaymentRecord(address _sender, address _recipient, uint _amount) internal {
        payments[_sender].push(Payment(_recipient, _amount));
        emit newTransfer(_sender, _recipient, _amount);
    }

    function getPayments(address _address) public view returns (Payment[] memory) {
        return payments[_address];
    }
}