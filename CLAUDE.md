# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Build
forge build --sizes

# Test (all tests, verbose)
forge test -vvv

# Run a single test
forge test --match-test <testFunctionName> -vvv

# Format check (CI enforces this)
forge fmt --check

# Auto-format
forge fmt
```

## Architecture

This is a [Foundry](https://book.getfoundry.sh/) project implementing **ERC-4337 Account Abstraction** on Ethereum (and potentially zkSync).

### ERC-4337 Overview

ERC-4337 introduces a smart contract wallet model without protocol-level changes. Instead of EOAs, users have smart accounts that validate and execute transactions via a shared `EntryPoint` contract. The flow is:

1. User signs a `UserOperation` (a pseudo-transaction struct)
2. A **bundler** collects UserOperations and submits them to `EntryPoint`
3. `EntryPoint` calls `validateUserOp` on the smart account to check the signature/nonce
4. `EntryPoint` then calls the account to execute the operation

### Key Contracts & Dependencies

| Path | Purpose |
|---|---|
| `src/MinimalAccount.sol` | The smart account implementation — implements `IAccount`, inherits `Ownable` |
| `lib/account-abstraction/` | [eth-infinitism](https://github.com/eth-infinitism/account-abstraction) — provides `IAccount`, `PackedUserOperation`, and the `EntryPoint` |
| `lib/openzeppelin-contracts/` | Provides `Ownable` and other utilities |
| `lib/forge-std/` | Foundry test helpers (`Test`, `console`, etc.) |

**Import alias:** `@openzeppelin/contracts` → `lib/openzeppelin-contracts` (set in `foundry.toml`).

### `MinimalAccount` Design

`MinimalAccount` implements `IAccount`, meaning it must define:

- `validateUserOp(PackedUserOperation calldata, bytes32 userOpHash, uint256 missingAccountFunds) returns (uint256 validationData)` — the sole required method. Validation should verify the signature is from the contract owner and pay the `EntryPoint` the `missingAccountFunds`.

The intended validation rule: **only the contract owner's signature is valid** (enforced via `Ownable`).

### Project Goals

1. Implement a minimal ERC-4337 account on Ethereum
2. Potentially port to zkSync (zkSync has native AA at the protocol level — different interfaces apply)
3. Deploy and send a real `UserOperation` through the `EntryPoint`
