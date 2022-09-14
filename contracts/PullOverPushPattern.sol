//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import './IERC20.sol';

// Push -> send ETH or token from contract to some address
// Pull -> allow caller to withdraw ETH or token 
// This prevents potential Reentrancy attacks and accidentialy sending ETH or token to wrong address

// Bad way
contract Push {
    function sendEth(address payable to, uint256 amount) external {
        (bool success, ) = to.call{value: amount}("");
        require(success, "Tx failed");
    }

    function sendEthMany(address[] calldata receivers, uint256 amount) external {
        for (uint256 i; i < receivers.length; ++i) {
            (bool success, ) = receivers[i].call{value: amount}("");
            require(success, "Tx failed");
        }
    }

    function sendToken(address token, address to, uint256 amount) external {
        IERC20(token).transfer(to, amount);
    }
}

// Recommended way
contract Pull {
    mapping(address => uint256) public ethBalances;
    mapping(address => mapping(address => uint256)) public tokenBalances;

    function giveEth(address to, uint256 amount) external {
        ethBalances[to] += amount;
    }

    function withdrawEth(uint256 amount) external {
        ethBalances[msg.sender] -= amount;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Tx failed");
    }

    function giveToken(address token, address to, uint256 amount) external {
        tokenBalances[token][to] += amount;
    }

    function withdrawToken(address token, uint256 amount) external {
        tokenBalances[token][msg.sender] -= amount;
        IERC20(token).transfer(msg.sender, amount);
    }
}