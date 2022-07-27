//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;


// the first account is used 

contract Lottery{

    // payable as they will get paid back

    address payable[] public players;
    address public manager;



    constructor(){
        manager = msg.sender;
        // transfer message to the manager msg.sender is global variable
    }

    // only one payable and receive ()n

    receive () payable external{

        // transfer ether

        require(msg.value == 1 ether);
        // the address is now a player
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender == manager,"You are not the manager");
        return address(this).balance;
    }


// random ()n to give a random number

    function random() internal view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    //    return to uint format
    }


// pickwinner and get balance only manager can do

    function pickWinner() public{

        require(msg.sender == manager);
        require (players.length >= 3);

        uint r = random();
        address payable winner;


        uint index = r % players.length;

        winner = players[index];

        // all money transfer

        winner.transfer(getBalance());

        //   dynamic array reset
        players = new address payable[](0);


    }

}


