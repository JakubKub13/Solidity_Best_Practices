//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// Prefer simple contracts over complex because of unintended bugs

// Bad 
contract ComplexContract {
    // Complex code
    // Calling many contracts and functions
    function callinManyFuncsAndContracts() external {
        // Call A.foo()
        // func1
        // func2
        // func3
        // Call B.baz()
        // func4
        //..
    }

    // Does many things
    function swapTokens() external {}
    function lend() external {}
    function borrow() external {}
    function liquidate() external {}

    // Has many view functions
    function getPrice() external view returns (uint256) {}
    function getHistoricalPrice() external view returns (uint256) {}
    function getAvaragePrice() external view returns (uint256 ){}
}

// Recommended 
contract SimpleContract {
    // Simple code 
    // Split protocol between multiple contracts 
    // In case of vuln we can create new contract and plug it into our protocol core and view 
}

contract CoreContract {}

contract ViewContract {}