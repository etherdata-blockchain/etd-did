/* SPDX-License-Identifier: MIT */

pragma solidity ^0.8.6;

contract NameMapping {

    mapping(string=>address) nameDID;
    mapping(address=>string) DIDName;

    address etd;

    constructor (address etdOwner) {
        etd = etdOwner;
    }

    modifier onlyETD(address owner){
        require(owner==etd, "invalid");
        _;
    }

    function setName(address identity, string calldata name) onlyETD(msg.sender) external {
        require(nameDID[name]==address(0), "name has been taken");
        nameDID[name] = identity;
        DIDName[identity] = name;
    }

    // revoke a did's ownership of its current name
    // change name's owner
    // update did's name to a new string
    // TODO: 1.expiration, 2.fee_management
}
