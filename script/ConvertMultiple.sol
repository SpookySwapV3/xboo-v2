// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {BrewBooV3} from "../src/BrewBoo.sol";


contract CounterScript is Script {
    BrewBooV3 brewboo = BrewBooV3(0x79710D58c3600401fe21E799ff97f37100C8b179);

    function setUp() public {}

    function run() public {
        vm.createSelectFork(vm.rpcUrl("https://rpc.soniclabs.com"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY_SONIC"));

        address[] memory tokens0 = new address[](1);
        tokens0[0] = 0x039e2fB66102314Ce7b64Ce5Ce3E5183bc94aD38;
        address[] memory tokens1 = new address[](1);
        tokens1[0] = 0x1D80eb918b19D291DeF4264e707A8D5CfDD1AcB6;
        uint256[] memory empty;

        brewboo.convertMultiple(tokens0, tokens1, empty);

        vm.stopBroadcast();
    }
}
