# USDX Zero-Fee Arbitrage Vulnerability PoC

## Executive Summary

A critical economic vulnerability exists in the USDX protocol due to a fee configuration mismatch between the Sales and Redeem contracts. The Sales contract charges **0% fee** while the Redeem contract charges **0.2% fee**, enabling risk-free arbitrage that can drain protocol reserves.

**Severity:** CRITICAL  
**Potential Loss:** $2,000 per $1M cycle  
**Status:** ACTIVE on Ethereum Mainnet

## Affected Contracts

- **USDXSales:** `0xb45c42Fbf8AF8Df5A1fa080A351E9B2F8e0a56D1` (0% fee)
- **USDXRedeem:** `0x0eaF6FE1aeD8631114d1dE78317982CE73d82f7b` (0.2% fee)

## Evidence

See `/evidence` folder for:
- On-chain fee verification via cast calls
- Forge test outputs proving the vulnerability

## Running the Tests

```bash
forge test --mc SmokeFork -vvv
forge test --mc NetFlow_BuyRedeem -vvv
forge test --mc NetFlow_MintRedeem -vvv
