// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract DIDRegistry1 {
    mapping(bytes => bytes32) private didToName;
    mapping(bytes32 => bytes) private nameToDid;

    function register(bytes memory did, bytes32 name) public {
        require(didToName[did] == bytes32(0), "DID already registered");
        require(nameToDid[name].length == 0, "Name already registered");

        didToName[did] = name;
        nameToDid[name] = did;
    }

    function resolveName(bytes32 name) public view returns (bytes memory) {
        return nameToDid[name];
    }

    function resolveDID(bytes memory did) public view returns (bytes32) {
        return didToName[did];
    }
}
