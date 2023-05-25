// SPDX-License-Identifier: MIT
// Modifying...
pragma solidity ^0.8.6;

contract DIDRegistry {
    mapping(bytes32 => bytes32) private didToName;
    mapping(bytes32 => bytes32) private nameToDid;

    function register(bytes32 did, bytes32 name) public {
        require(didToName[did] == bytes32(0), "DID already registered");
        require(nameToDid[name] == bytes32(0), "Name already registered");

        didToName[did] = name;
        nameToDid[name] = did;
    }

    function resolveName(bytes32 name) public view returns (bytes32) {
        return nameToDid[name];
    }

    function resolveDID(bytes32 did) public view returns (bytes32) {
        return didToName[did];
    }
}
