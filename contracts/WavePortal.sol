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

       /*
     * We will be using this below to help generate a random number
     */
    uint256 private seed;

     /*
     * a mapping that will store the timestamp when the user waved
     */
     mapping (address => uint256)  lastWavedAt;

    constructor() payable {
        console.log("I am a contract and I am smart");
        /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }
    function wave(string memory _message)public{
        /*
         * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
         */
        require(
            lastWavedAt[msg.sender] + 30 seconds< block.timestamp,
            "Wait 30 seconds before waving again"
        );

        /*
         * Update the current timestamp we have for the user
         */
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves+=1;
        balances[msg.sender]+=1;
        console.log("%s has waved",msg.sender);
        waves.push(Wave(msg.sender, _message, block.timestamp));


         /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);


         /*
         * Give a 50% chance that the user wins the prize.
         */
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            /*
             * The same code we had before to send the prize.
             */
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "The contract doesn't have that amount of ether"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Fail to withrow the money from the contract");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
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