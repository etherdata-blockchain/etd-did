1 pragma solidity ^0.5.0;
 2 
 3 import "./ENS.sol";
 4 
 5 contract ENSRegistry is ENS {
 6     struct Record {
 7         address owner;
 8         address resolver;
 9         uint64 ttl;
10     }
11 
12     mapping (bytes32 => Record) records;
13 
14     modifier only_owner(bytes32 node) {
15         require(records[node].owner == msg.sender);
16         _;
17     }
18 
19     constructor() public {
20         records[0x0].owner = msg.sender;
21     }
22 
23     function setOwner(bytes32 node, address owner) external only_owner(node) {
24         emit Transfer(node, owner);
25         records[node].owner = owner;
26     }
27 
28     function setSubnodeOwner(bytes32 node, bytes32 label, address owner) external only_owner(node) {
29         bytes32 subnode = keccak256(abi.encodePacked(node, label));
30         emit NewOwner(node, label, owner);
31         records[subnode].owner = owner;
32     }
33 
34     function setResolver(bytes32 node, address resolver) external only_owner(node) {
35         emit NewResolver(node, resolver);   
36         records[node].resolver = resolver;
37     }
38 
39     function setTTL(bytes32 node, uint64 ttl) external only_owner(node) {
40         emit NewTTL(node, ttl);
41         records[node].ttl = ttl;
42     }
43 
44     function owner(bytes32 node) external view returns (address) {
45         return records[node].owner;
46     }
47 
48     function resolver(bytes32 node) external view returns (address) {
49         return records[node].resolver;
50     }
51 
52     function ttl(bytes32 node) external view returns (uint64) {
53         return records[node].ttl;
54     }
55 
56 }

ENSRegistry.sol