pragma solidity ^0.8.0;

import "./Delegate.sol";

contract Delegation {

  address public owner;
  Delegate delegate;
  bytes public lastCallData;

  constructor(address _delegateAddress) public {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }
  
  fallback() external {
    lastCallData = msg.data;
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}