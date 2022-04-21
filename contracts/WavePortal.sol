// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint) balances;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }
    function wave()public{
        totalWaves+=1;
        balances[msg.sender]+=1;
        console.log("%s has waved",msg.sender);
    }
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d waves!", totalWaves);
        console.log("the address %s has %d number of waves", msg.sender , balances[msg.sender]);
        return totalWaves;
    }
}