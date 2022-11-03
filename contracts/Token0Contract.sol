// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract Token0 is ERC20 {
    uint128 price;
    constructor(uint256 initialSupply) ERC20("Token0", "T0") {
        _mint(msg.sender, initialSupply);
        price = 1000;
    }

    function mint(uint128 amount) public payable {
        require(amount > 0, "mint amount has to be positive");
        _mint(msg.sender, amount);
    }
}