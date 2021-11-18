//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Faucet {

    uint256 withdraw_limit = 1E17;

    function withdraw(uint withdraw_amt) public {
        require(withdraw_amt <= withdraw_limit);
        payable(msg.sender).transfer(withdraw_amt);
    }

    function deposit() public payable{}

    function contractBalance() public view returns(uint) {
    return address(this).balance;
    }
}
