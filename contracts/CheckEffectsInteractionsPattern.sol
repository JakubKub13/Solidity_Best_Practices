//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

// 1. Check input
// 2. Update state variable
// 3. Interact with other account / contract

// This will reduce the chance of writing a Contract that is vulnerable to Reentrancy attack

contract ChecksEffectsInteractionsPattern {
    mapping(address => uint256) public balanceOf;

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

// This function is vulnerable to Reentrancy because it 1st interact and sends ether and than updates
// it's internal mapping 
    function withdrawBadWay(uint256 amount) external {
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "TX failed");
        balanceOf[msg.sender] -= amount; 
    }

    function withdrawGoodWay(uint256 amount) external {
        // Check
        require(amount > 0, "Not enough funds to send");
        // Effect
        balanceOf[msg.sender] -= amount;
        // Interaction
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "TX failed");
    }
}