//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./IERC20.sol";

// User can execute a malicious contract inside your contract

contract userInput {
    // Recommended - whitelist user inputs if possible
    function deposit(address token, uint256 amount) external {
        IERC20(token).transferFrom(msg.sender, address(this), amount); // More code....
    }
}

contract MalContract {
    event Log(string message);

    function transferFrom(address, address, uint256) external returns (bool) {
        // Malicious code here 
        emit Log("Hacked !!!!!");
        return true;
    }
}