// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract EtdDIDReg{

    bytes32 constant private KEY_CREATED = "created";
    bytes32 constant private KEY_ALSO_KNOWN_AS = "alsoKnownAs";

    mapping(address => address) public owners;  // owner = owners[did]
    mapping(address => uint) public changed;

    modifier onlyOwner(address identity, address actor) {
    require (actor == identityOwner(identity), "bad_actor");
    _;
  }


    event AttributeChanged(
        address indexed identity,
        bytes32 name,
        bytes value,
        uint previousBlock,
        int updated
    );

    event OwnerChanged(
        address indexed identity,
        address owner,
        uint previousBlock
    );

    function createId(
        address identity,
        bytes memory alsoknownas,
        bytes memory created,
        int updated
    )
        public
    {
        emit AttributeChanged(identity, KEY_CREATED, created, changed[identity], updated);
        emit AttributeChanged(identity, KEY_ALSO_KNOWN_AS, alsoknownas, changed[identity], updated);
        changed[identity] = block.number;
    }

    function changeOwner(address identity, address newOwner) public onlyOwner(identity, msg.sender) {
        owners[identity] = newOwner;
        emit OwnerChanged(identity, newOwner, changed[identity]);
        changed[identity] = block.number;
    }

    function setAttribute(address identity, bytes32 name, bytes memory value, int updated ) public onlyOwner(identity, msg.sender) {
        emit AttributeChanged(identity, name, value, changed[identity], updated);
        changed[identity] = block.number;
    }

    function identityOwner(address identity) public view returns(address) {
        address owner = owners[identity];
        if (owner != address(0x00)) {
            return owner;
        }
    return identity;
    }

}
