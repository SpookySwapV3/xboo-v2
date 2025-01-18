// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {BrewBooV3} from "../src/BrewBoo.sol";


contract CounterScript is Script {

    function setUp() public {}

    function run() public {
        vm.createSelectFork(vm.rpcUrl("https://rpc.soniclabs.com"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY_SONIC"));

        address _factory = 0xEE4bC42157cf65291Ba2FE839AE127e3Cc76f741;
        address _xboo = 0xa95eA1cfaBcCf0E9eb94b646CeFe9eD71ff5D605;
        address _boo = 0x7A0C53F7eb34C5BC8B01691723669adA9D6CB384;
        address _wftm = 0x039e2fB66102314Ce7b64Ce5Ce3E5183bc94aD38;
        address route1 = 0x29219dd400f2Bf60E5a23d13Be72B486D4038894;
        address route2 = 0x50c42dEAcD8Fc9773493ED674b675bE577f2634b;

        BrewBooV3 brewboo = new BrewBooV3(_factory, _xboo, _boo, _wftm, route1, route2);
        brewboo.setBridgeRoute(3, 0x59524D5667B299c0813Ba3c99a11C038a3908fBC);

        vm.stopBroadcast();
    }
}
