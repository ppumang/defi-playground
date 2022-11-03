// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';
import './Token0Contract.sol';
import './Token1Contract.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/IERC20.sol';

contract Pool {
    address token0Address;
    address token1Address;
    ERC20 token0;
    ERC20 token1;
    uint256 K;
    
    function setConfig(address token0_addr, address token1_addr, uint256 k) public {
        token0Address = token0_addr;
        token1Address = token1_addr;
        token0 = Token0(token0Address);
        token1 = Token1(token1Address);
        K = k;
    }

    function fetchAmounts() public view returns( uint256[] memory ) {
        uint256[] memory ret = new uint256[](2);
        ret[0] = token0.balanceOf(address(this));
        ret[1] = token1.balanceOf(address(this));
        return ret;
    }


    function provideLiquidity(uint256 token0_amt, uint256 token1_amt) public {
        uint256 userToken0Allowance = token0.allowance(msg.sender, address(this));
        uint256 userToken1Allowance = token1.allowance(msg.sender, address(this));
        require(userToken0Allowance >= token0_amt, "lack of token0 balance");
        require(userToken1Allowance >= token1_amt, "lack of token1 balance");

        token0.transferFrom(msg.sender, address(this), token0_amt);
        token1.transferFrom(msg.sender, address(this), token1_amt);

        setK();
    }

    function swap(bool zeroToOne, uint256 amt) public payable returns(uint256 delta_y)  {
        ERC20 token_x = zeroToOne ? token0 : token1;
        ERC20 token_y = zeroToOne ? token1 : token0;

        require(token_x.balanceOf(msg.sender) >= amt, "lack of balance");
        delta_y = uint256(K / amt);
        token_y.transferFrom(address(this), msg.sender, delta_y);

        setK();
    }

    function setK() internal {
        K = token0.balanceOf(address(this)) * token1.balanceOf(address(this));
    }

    function viewThisAddress() public view returns(address) {
        return address(this);
    }

    function dummy(uint256 token0_amt, uint256 token1_amt) public view returns(uint256[] memory){
        uint256 userToken0Balance = token0.balanceOf(msg.sender);
        uint256 userToken1Balance = token1.balanceOf(msg.sender);
        require(userToken0Balance >= token0_amt, "lack of token0 balance");
        require(userToken1Balance >= token1_amt, "lack of token1 balance");
        uint256[] memory ret = new uint256[](2);
        ret[0] = token0_amt;
        ret[1] = userToken0Balance;
        return ret;
    }

    function getAllowance() public view returns(uint256[2] memory ret) {
        ret[0] = (token0.allowance(msg.sender, address(this)));
        ret[1] = (token1.allowance(msg.sender, address(this)));
        return ret;
    }
}