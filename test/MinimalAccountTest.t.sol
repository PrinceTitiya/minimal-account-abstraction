//SPDX-License-Identfier: MIT

pragma solidity ^0.8.24;
import {Test} from "forge-std/Test.sol";
import {MinimalAccount} from "../src/MinimalAccount.sol";
import {DeployMinimal} from "../script/deployMinimal.s.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";

contract MinimalAccountTest is Test {
    function setUp() public {
        HelperConfig helperConfig;
        MinimalAccount minimalAccount;

        DeployMinimal deployMinimal = new DeployMinimal();
        (helperConfig, minimalAccount) = deployMinimal.deployMinimalAccount();
    }

    // USDC Approval

    //msg.sender -> Minimal Account
    // approve some amount
    // USDC contract
    // come from the entrypoint
}
