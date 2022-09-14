//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract securityOverGas {
    // Sum nums save Gas
    function bad(uint256[] calldata nums) external pure returns (uint256 total) {
        uint256 len = nums.length;

        for(uint256 i = 0; i < len;) {
            total += nums[i];
            unchecked {
                ++i;
            }
        }
    }

    // Prioritize code readability and security over gas cost
    function recommended(uint256[] calldata nums) external pure returns (uint256 total) {
        uint256 len = nums.length;

        for (uint256 i = 0; i < len; ++i) {
            total += nums[i];
        }
    }
}