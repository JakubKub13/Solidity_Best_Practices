//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// No upper limits to number of loops
// There is a limit on amount of gas that can be used in block
// Loops without upper limit can consume more gas than is allowed per block gas limit

contract InfiniteLoops {
    address[] public accounts;
    mapping(address => uint256) public balances;

    function join() external {
        accounts.push(msg.sender);
    }

    function badLoop() external {
        // Increment all accounts balance
        for (uint256 i; i < accounts.length; i++) {
            balances[accounts[i]] += 1;
        }
    }

    function recommendedLoop(uint256 start, uint256 end) external {
        for(uint256 i = start; i < end; i++) {
            balances[accounts[i]] += 10;
        }
    }

    function test() external {
        test2(accounts);
    }

    function test2(address[] memory) public {
        // more code here
    }
}