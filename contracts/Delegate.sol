pragma solidity ^0.8.0;

import "hardhat/console.sol";

/*
The goal of this level is for you to claim ownership of the instance you are given.

  Things that might help

- Look into Solidity's documentation on the delegatecall low level function, 
  how it works, how it can be used to delegate operations to on-chain libraries, 
  and what implications it has on execution scope.
- Fallback methods
- Method ids
*/

contract Delegate {

  address public owner;

  constructor(address _owner) public {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
    console.log("got called");
  }
}