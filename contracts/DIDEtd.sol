/* SPDX-License-Identifier: MIT */

pragma solidity ^0.8.6;
import "contracts/did_eth.sol";
import "contracts/did_etd_nm.sol";
import "contracts/did_etd_ss.sol";

contract DIDETDRegistery is EthereumDIDRegistry{

    address private _owner;

    modifier onlyETD(address owner) {
    require (owner == _owner, "bad_actor");
      _;
    }

    modifier onlyStorageOwner(address owner) {
      address identity = storageAuth[owner];
      if (identity==address(0x00)) {
          identity = owner;
      }
      require(owner == identity, "bad actor" );
      _;
    }

    event NameRegistry(
      address indexed identity,
      string name
    );

    event DIDStorageAuthChanged(
        address indexed identity,
        address owner,
        uint previousChange
    );

    //every identity has a bound storageKey for storageService_Auth
    mapping(address=>address) storageAuth;

    address  storageService;
    address nameService;
    string storageServiceEndpoint="";

    constructor(address _strService){
        storageService = _strService;
    }


    function registerName(address identity, string calldata name) public onlyETD(msg.sender) {
      NameMapping(nameService).setName(identity, name);
    }

    function changeStorageAuth(address identity, address newAuth) public onlyStorageOwner(identity){
      storageAuth[identity] = newAuth;
      emit DIDStorageAuthChanged(identity, newAuth, changed[identity]);
      changed[identity] = block.number;
    }

    function getSotrageAuth(address identity) public view returns(address){
      address ra = storageAuth[identity];
      if (ra == address(0x00)) {
        return identity;
      }
      return ra;
    }
}
