//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// Bad way x * (90 / 100)
// Recommended way (x * 90) / 100
// Reason ----> Solidity does not support floating numbers which leads to rouding errors

contract MultiplyBeforeDivide {
    // Return 90% of x
    function bad(uint256 x, uint256 y, uint256 z) external pure returns (uint256) {
        // x * (90 / 100) always returns 0
        return x * (y / z);
    }

    function good(uint256 x, uint256 y, uint256 z) external pure returns (uint256) {
        return x * y / z;
    }
}

// Another example 
contract Pool {
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    uint256 private constant MULTIPLIER = 1e18;

    constructor() {
        totalSupply = 1000 * 1e18;
        balanceOf[msg.sender] = 90 * 1e18;
    }

    function calculateSharesRatio(address account) external view returns (uint256) {
        if (totalSupply > 0) {
            // Bad always returns 0
            // return balanceOf[account] * MULTIPIER / totalSupply
            return balanceOf[account] * MULTIPLIER / totalSupply;
        }
        return 0;
    }
}