//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
// When writing a Contract it's best to lock compiler version
// Reasons are: 
// 1. Slow to identify potentional bugs in compiler versions
// 2. Difficulty verifying contract on Etherscan
// 3. Use recent stable version of compiler not the latest version

// Bad way ------> pragma solidity >=0.8.0 < 9 or pragma solidity ^0.8.0
// Recommended way pragma solidity 0.8.13;

contract LockVersionCompiler{}