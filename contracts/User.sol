// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract User {
    uint256 balance;

    function charge_balance(uint amount) public {
        balance += amount;
    }

    function view_balance() public view returns(uint256) {
        return balance;
    }
    
}