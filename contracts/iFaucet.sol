 // SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

interface iFaucet{

    function addFunds() external payable;
    function withdraw(uint _withdrawAmount) external; 

}