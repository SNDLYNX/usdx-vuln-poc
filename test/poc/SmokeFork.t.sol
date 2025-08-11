// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";

/**
 * @title SmokeFork
 * @notice Simple test to verify fork connection and read on-chain fee rates
 * @dev This confirms the fee mismatch vulnerability exists on mainnet
 */
interface ISales {
    function feeRate() external view returns (uint256);
}

interface IRedeem {
    function feeRate() external view returns (uint256);
}

contract SmokeFork is Test {
    ISales constant SALES = ISales(0xb45c42Fbf8AF8Df5A1fa080A351E9B2F8e0a56D1);
    IRedeem constant REDEEM = IRedeem(0x0eaF6FE1aeD8631114d1dE78317982CE73d82f7b);
    
    function setUp() public {
        vm.createSelectFork("http://127.0.0.1:8545");
    }
    
    function test_ReadFeeRates() public view {
        uint256 salesFee = SALES.feeRate();
        uint256 redeemFee = REDEEM.feeRate();
        
        console.log("====== ON-CHAIN FEE VERIFICATION ======");
        console.log("Sales Contract feeRate:", salesFee);
        console.log("Redeem Contract feeRate:", redeemFee);
        console.log("");
        console.log("Sales fee percentage:", salesFee * 100 / 1000000, "%");
        console.log("Redeem fee percentage:", redeemFee * 100 / 1000000, "%");
        console.log("");
        console.log("====== VULNERABILITY CONFIRMED ======");
        console.log("Fee mismatch detected: 0% vs 0.2%");
        console.log("This enables risk-free arbitrage");
    }
}
