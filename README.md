# etd-did

## DID

Define a new did method `etd-did` based on [W3C did protocol](https://www.w3.org/TR/did-core/).

* did identifier：`did:etd:<etd address>`
* [design](https://www.figma.com/file/eq2DxnqSFtNzxffzMr5k3h/DID%2CStorage%2CNFT%2B%2B?type=whiteboard&t=ry6Egb1A9mOsoBJt-0)

## DID Document

### DID Document properties

| Properties         | Required | Value constraints                       |
| ------------------ | -------- | --------------------------------------- |
| id                 | yes      | A string of etd-did                     |
| controller         | no       | A string or a set of strings of etd-did |
| verificationMethod | no       | A set of Verification Method maps       |
| authentication     | no       | A representation of Verification Method |
| proxyWallet        | no       | A representation of Verification Method |
| service            | no       | A set of Service Endpoint maps          |

#### authentication

Used for the verification of [storj](https://www.storj.io) storage service based on DID.

#### proxywallet

To ensure the security of the DID and its associated assets, we assign certain transferable DIDs to corresponding contract addresses, similar to the role of a proxy wallet, in order to safeguard the security of the assets associated with the DID during asset transfers.

### service

* id

  * the unique identifier of service

* type

  *  *SHOULD* be registered in the DID Specification Registries

  <img src="https://raw.githubusercontent.com/X-i-e/picbed/main/image-20230719222245443.png" alt="image-20230719222245443" style="zoom:80%;" />

* service Endpoint

### Example 1 of DID document

```css
{
  "@context": [
      "https://www.w3.org/ns/did/v1",
      "https://w3cid.org/security/suites/secp256k1recovery-2020/v2"
  ],
  "id": "did:etd:0x7c...",
  "controller": "did:etd:0x7c...",
  "verificationMethod": [
    {
        "id": "did:etd:0x7c...#storj",
        "type": "EcdsaSecp256k1VerificationKey",
        "controller": "did:etd:0x7c...",
        "publicKeyMultibase": "0x7c..."
	},{
        "id": "did:etd:123456789abcdefghi#proxywallet-1",
        "type": "Ed25519VerificationKey2020",
        "controller": "did:example:123456789abcdefghi",
        "ethereumAddress": "0xF3beAC30C498D9E26865F34fCAa57dBB935b0D74"
    }
  ],
  "authentication": [
    "did:etd:0x7...#storj",
    {
      "id": "did:etd:0x7...#storj-auth",
      "type": "Ed25519VerificationKey2020",
      "controller": "did:etd:0x7...",
      "publicKeyMultibase": "0x89..."
    }
  ],
  "proxywallet": [
    "did:etd:123456789abcdefghi#proxywallet",
    {
      "id": "did:etd:123456789abcdefghi#proxywallet-1",
      "type": "Ed25519VerificationKey2020",
      "controller": "did:example:123456789abcdefghi",
      "ethereumAddress": "0xF3beAC30C498D9E26865F34fCAa57dBB935b0D74"
    }
  ]
}
```

### Example 2 of DID document

```json
// the example of the service provider - storj
{
  "@context": [
      "https://www.w3.org/ns/did/v1",
      "https://w3cid.org/security/suites/secp256k1recovery-2020/v2"
  ],
  "id": "did:etd:0x69...",
  "controller": "did:etd:0x69...",
  "verificationMethod": [
    {
        "id": "did:etd:0x69...#key-1",
        "type": "EcdsaSecp256k1VerificationKey",
        "controller": "did:etd:0x69...",
        "publicKeyMultibase": "0x69..."
	}],
  "service": [
    {
      "id":"did:etd:0x69...#storj",
      "type": "LinkedDomains",
      "serviceEndpoint": {
        "upload": "https://www.etd.storj.io/upload",
          ...
      }
    }
]
}
```



## Contract

* `ETDDIDReg.sol`: It contains some basic operations of did, including creating, modifying property etc.
* `ENS.sol`: Etd Name Service.

### ETDDIDReg.sol

Contract Address: `0x78A78Ea68BBBc11a196D576E9564b9B95A23B801`

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

### DIDNameReg.sol

Contract Address: `0x0eFCC08cD9831CE3d72c362A5b92011AAD26B23e`

