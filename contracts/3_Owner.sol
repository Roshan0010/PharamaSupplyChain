// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "./1_Ownable.sol";
import "./2_Entity.sol";

/*
@dev
    The owner contains a list of all registered entities in the supply chain, rest all entites read from this list
    Only the onwer has the privilege of adding a new entity to the list of all entities
*/

contract Owner is EntityContract{
    // @dev this mapping contains the address of the contract deployed on the blockchain of each entity
    mapping(address => address) deployedContract;

    constructor(string memory _ownerName){
        // @dev the first entity added is the owner
        addEntity(ownerAddress, _ownerName, Role.OWNER);
    }
   
    function assignManufacturer(address _manufacturerAddress) public {
        // creates a new manufacturer contract and informs it about the details of the drug to be manufactured
    }

    function createDrug() public {

    }
    
}