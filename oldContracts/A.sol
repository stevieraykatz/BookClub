//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

contract A {
    address _b;

    function setBAddr(address B) public {
        _b = B;
    }

    function call_setVal(uint256 _val) public returns (bool){
        require(_b.call(bytes4(keccak256("getVal()"))), _val);
        return(true);
    }
}