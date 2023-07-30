// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

contract NameResolver{

    mapping(bytes32 => string) names;
    // mapping(bytes32 => uint64) public recordVersions;
    /**
     * Sets the name associated with an ENS node, for reverse records.
     * May only be called by the owner of that node in the ENS registry.
     * @param node The node to update.
     */

    event NameChanged(bytes32 indexed node, string name);


    function setName(
        bytes32 node,
        string calldata newName
    ) external {
        names[node] = newName;
        emit NameChanged(node, newName);
    }

    /**
     * Returns the name associated with an ENS node, for reverse records.
     * Defined in EIP181.
     * @param node The ENS node to query.
     * @return The associated name.
     */
    function getName(
        bytes32 node
    ) external view returns (string memory) {
        return names[node];
    }

}