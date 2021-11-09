// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Score {

    uint score;
    address owner;

    event newScore(uint _newScore);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if (msg.sender == owner){
            _;
        }
    }

    function getScore() public view returns (uint) {
        return score;
    }

    function setScore(uint _newScore) public onlyOwner {
        score = _newScore;
        emit newScore(score);
    }
}