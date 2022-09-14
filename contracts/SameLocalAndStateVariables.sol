//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract SameLocalAndStateVariables {
    uint256 public totalSupply;

    function bad() external {
        uint256 totalSupply = 123;

        // More code here....

        // We want to update state variable but instead we upgrade local variable
        totalSupply = 333;
    }

    function recommended() external {
        uint256 _totalSupply = 123;
        //.... more code
        totalSupply = 888;
    }

    // Pure functions do not read state variables so there is no possibility of mixing up local and state variables
    function PureFunc(uint256 x, uint256 y) external pure returns (uint256) {
        uint256 totalSupply = y + x;
        return totalSupply;
    }
}