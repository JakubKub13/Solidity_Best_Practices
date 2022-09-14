//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// Code may fail on sending ETH

// Bad 
contract ComplexFallback {
    fallback() external payable {
        // complex code here
    }
}

// Recommended
contract SimpleFallback {
    fallback() external payable {
        // simple code here preferably only log
    }
}