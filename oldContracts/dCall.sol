//SPDX-License-Identifier: Unlicense

/**
Bob calls contract A, 
which delegate calls contract B, 
which delegate calls contract C, 
which calls contract D, 
which delegate calls contract E, 
which delegate calls contract A.

Who is msg.sender when the execution reaches back contract A?
*/

pragma solidity ^0.8.0;

library E {
    function f(A a) external returns(address) {
        (,bytes memory ret) = address(a).delegatecall(abi.encodeWithSignature("g()"));
        return abi.decode(ret, (address));
    }
}
contract D {
    function f(A a) external returns(address) {
        return E.f(a);
    }
}
library C {
    function f(A a) external returns(address) {
        D d = new D();
        return d.f(a);
    }
}
library B {
    function f(A a) external returns(address) {
        return C.f(a);
    }
}
contract A {
    function f() external returns(address) {
        return B.f(this);
    }
    function g() external view returns(address) {
        return msg.sender;
    }
    function current() external view returns(address) {
        return address(this);
    }
}