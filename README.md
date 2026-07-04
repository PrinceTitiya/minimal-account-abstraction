# Minimal Account Abstraction (ERC-4337)

A minimal implementation of an ERC-4337 smart contract account, built with [Foundry](https://book.getfoundry.sh/).

## About

1. Create a basic account abstraction (AA) wallet on Ethereum
2. Maybe create a basic AA wallet on zkSync
3. Deploy, and send a `UserOperation`/transaction through them

## Overview

ERC-4337 introduces smart contract wallets without protocol-level changes. Instead of EOAs, users have smart accounts that validate and execute transactions via a shared `EntryPoint` contract:

1. A user signs a `UserOperation` (a pseudo-transaction struct)
2. A **bundler** collects `UserOperation`s and submits them to `EntryPoint`
3. `EntryPoint` calls `validateUserOp` on the smart account to check the signature/nonce
4. `EntryPoint` then calls the account to execute the operation

## Project Structure

| Path | Purpose |
|---|---|
| `src/MinimalAccount.sol` | The smart account implementation — implements `IAccount`, inherits `Ownable` |
| `script/deployMinimal.s.sol` | Deployment script for `MinimalAccount` |
| `script/HelperConfig.s.sol` | Network configuration helper |
| `script/SendPackedUserOp.s.sol` | Script to build/send a `PackedUserOperation` |
| `test/MinimalAccountTest.t.sol` | Tests for `MinimalAccount` |
| `lib/account-abstraction/` | [eth-infinitism](https://github.com/eth-infinitism/account-abstraction) — provides `IAccount`, `PackedUserOperation`, and the `EntryPoint` |
| `lib/openzeppelin-contracts/` | Provides `Ownable` and other utilities |
| `lib/forge-std/` | Foundry test helpers (`Test`, `console`, etc.) |

## Usage

### Install dependencies

```bash
forge install
```

### Build

```bash
forge build --sizes
```

### Test

```bash
# Run all tests, verbose
forge test -vvv

# Run a single test
forge test --match-test <testFunctionName> -vvv
```

### Format

```bash
# Check formatting (CI enforces this)
forge fmt --check

# Auto-format
forge fmt
```

## CI

GitHub Actions runs `forge fmt --check`, `forge build --sizes`, and `forge test -vvv` on every push and pull request (`.github/workflows/test.yml`).
