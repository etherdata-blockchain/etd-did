/* SPDX-License-Identifier: MIT */

pragma solidity ^0.8.6;

import "contracts/did_etd.sol";

// should be a service deployed by StorageService which sould including the authentification check when doning the `appendItem`
contract StorageService{

/**
    define a table format (basic k-v)
    write new iterm/record as event
    sum the hash for compare from storjService
    table_schools{name, time_start, time_end, type， grade, ..., author_did, blockNumber}
    e.g.: {school_name, 2020-01-12, 2023-01-01, xx, xx, did_of_the_presedent/school, 99710}
**/
    struct table {
        string name;
        string[] keys;//including {append_author, blockNumber}
        uint count;
        bytes32 hash;//sum hash for compare online with storj
    }

    //event just send the author address which could conducting the DID of the author of this item
    //since this is the contract deployed by the storageservie itself, so the veirification doing here when appendItem should be trust by the storageservice
    event AppendItem(string table, string valuesJSON, address sIdentity);

    mapping(address=>mapping(string=>table)) tables;
    mapping(address => uint) public nonce;
    DIDETDRegistery didETD;
    address owner;

    constructor(address _owner, address etd) {
            owner = _owner;
            didETD = DIDETDRegistery(etd);
    }

    //define k-v format
    function defineTable()public {}
    //write item and emit event for monitor to write into storj_service
    //the emit including signature for storj to verify the authentification
    //content: {V1,V2,...,Vn, author_key, timestamp, expire, signature},
    // the storage service only accept the correct format
    // events could be verified, yes the owner of corresponding storage could invoke this appendItem with illegal content and emit the fake event
    // but the fake event is easy to be verified to be invalid
    // the only thing would be messed is the `hash` value(yes that's a bad thing, TODO...)
    function appendItem(bytes calldata content, string calldata tableName, uint count) public {
        address sIdentity = didETD.getSotrageAuth(msg.sender);
        table storage t = tables[sIdentity][tableName];

        require(t.keys.length > 0, "trying to write into table not initialized");

        t.count += count;

        bytes memory hn = bytes.concat(t.hash, content);
        t.hash = keccak256(hn);

        emit AppendItem(tableName, string(content), sIdentity);//storj just decode the content and write into the table under sIdentity, need no more verification
    }

    function checkSignature(address identity, uint8 sigV, bytes32 sigR, bytes32 sigS, bytes32 hash) internal returns(address) {
        address signer = ecrecover(hash, sigV, sigR, sigS);
        require(signer == identity, "bad_signature");
        nonce[signer]++;
        return signer;
  }
}
