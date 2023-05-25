# etd-did
Define a new did method `etd-did` based on [W3C did protocol](https://www.w3.org/TR/did-core/).

* did identifier：`did:etd:<etd address>`

* did document (simple):

  ```css
  {
    '@context': [
        "https://www.w3.org/ns/did/v1",
        "https://w3cid.org/security/suites/secp256k1recovery-2020/v2"
    ]
    id: "did:etd:0x7c...",
    alsoKnownAs: "ETD Wallet",
    created: "2023-04-28T14:30:00.000Z",
    verificationMethod: [
      {
        id: 'did:etd:0x7c...#controller'
        type: 'EcdsaSecp256k1RecoveryMethod2020',
        controller: 'did:etd:0x7c...'
  	}  
    ]
    authenticationMethod: [
      'did:etd:0x7c...'
    ]
  }
  ```

## Contract
* `ETDDIDReg.sol`: It contains some basic operations of did, including creating, modifying property etc.
* `ENS.sol`: Etd Name Service.

### ETDDIDReg.sol

Contract Address: `0xDca6E0B44C662c4Ed093732cC8F5b0c0075FC25E`

#### Events
  * `AttributeChanged`
  * `OwnerChanged`
#### Methods
  * `createWeId()`：Create and register did.
      * `address identity`：It can receive either a wallet address or a locally created ETD address and use the wallet address as the controller of did.
      * `bytes memory alsoknownas`：Custom, such as "ETD Wallet"
      * `bytes memory created`：Create timestamp
      * `int updated`：Expiration time. 0 indicates permanent
  * `changeOwner ()`：Change the did Controller
    * `address identity`：did
    * `address newOwner`：New owner of did
  * `setAttribute()`：Update the property of did
    * `address identity`：did
    * `bytes32 name`：Attribute name
    * `bytes memory value`：Attribute value
    * `int updated`：Update



