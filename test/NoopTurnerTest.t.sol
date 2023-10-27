// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.2 <0.9.0;

import "forge-std/Test.sol";
import "../src/timetravel/CallBreaker.sol";
import "../test/examples/NoopTurner.sol";

contract NoopTurnerTest is Test {
    // Counter public counter;

    CallBreaker public callbreaker;
    NoopTurner public noopturner;

    function setUp() public {
        callbreaker = new CallBreaker();
        noopturner = new NoopTurner(address(callbreaker));
    }

    function test_loop() public {
        // check vanilla call, just for fun...
        (bool success, bytes memory ret) =
            address(noopturner).call{gas: 1000000, value: 0}(abi.encodeWithSignature("vanilla(uint16)", uint16(42)));

        require(success, "vanilla call failed");
        assertEq(abi.decode(ret, (uint16)), uint16(52), "vanilla call returned wrong value");

        // build the call stack
        CallObject[] memory callObjs = new CallObject[](1);
        callObjs[0] = CallObject({
            amount: 0,
            addr: address(noopturner),
            gas: 1000000,
            callvalue: abi.encodeWithSignature("const_loop(uint16)", uint16(42))
        });

        ReturnObject[] memory returnObjs = new ReturnObject[](1);
        // note it always returns 52
        returnObjs[0] = ReturnObject({returnvalue: abi.encode(uint16(52))});

        bytes memory callObjsBytes = abi.encode(callObjs);
        bytes memory returnObjsBytes = abi.encode(returnObjs);

        // Constructing something that'll decode happily
        bytes32[] memory keys = new bytes32[](0);
        //keys[0] = keccak256(abi.encodePacked("key"));
        bytes[] memory values = new bytes[](0);
        //values[0] = abi.encode("value");
        bytes memory encodedData = abi.encode(keys, values);

        // call verify
        callbreaker.verify(callObjsBytes, returnObjsBytes, encodedData);
    }
}
