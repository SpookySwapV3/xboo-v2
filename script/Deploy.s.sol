// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {BooMirrorWorld} from "../src/BooMirrorWorld.sol";


contract CounterScript is Script {

    function setUp() public {}

    function run() public {
        vm.createSelectFork(vm.rpcUrl("https://rpc.soniclabs.com"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY_SONIC"));

        new BooMirrorWorld(0x7A0C53F7eb34C5BC8B01691723669adA9D6CB384);

        vm.stopBroadcast();
    }
}
