// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    mapping(address => uint) balances;
    //let the contract know that the event is going to be emitted
    event NewWave(address indexed from, uint256 timestamp, string message);
    //struct for the event
      struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }
    //an array of the struct to stroe data
      Wave[] waves;

    constructor() payable {
        console.log("I am a contract and I am smart");
    }
    function wave(string memory _message)public{
        totalWaves+=1;
        balances[msg.sender]+=1;
        console.log("%s has waved",msg.sender);
        waves.push(Wave(msg.sender, _message, block.timestamp));
        emit NewWave(msg.sender, block.timestamp, _message);

        uint prizeAmount=0.0001 ether;
        // address(this).balance is the balance of the contract itself
        require(prizeAmount<= address(this).balance , "The contract doesn't have that amount of ether");

        (bool success,)= (msg.sender).call{value:prizeAmount}("");
        require(success, "Failed to withraw  the money");
    }

     function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d waves!", totalWaves);
        return totalWaves;
    }

       function getAdressWaves(address _address) public view returns (uint256) {
        console.log("the address %s has %d number of waves",_address , balances[_address]);
        return balances[_address];
    }
}