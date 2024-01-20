// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "./Ownable.sol";
import "./libraries/types.sol";

/**
* @title EntityContract
* @author Harshit Tathagat
* @dev
*   - Each entity in the supply chain follows the structure of this entity contract
*   - The entity contract contains a list of all the registered entites    
*   - The owner cannot be inactive
*   - An entity once added in the chain cannot be removed only disabled
*/

contract EntityContract is Ownable{

    mapping (address => Types.Entity) manufacturerList;
    mapping (address => Types.Entity) distributorList;
    mapping (address => Types.Entity) retailerList;

    function addEntity(address entityAddress, string memory entityName, Types.Role role) public isOwner{
        if(role == Types.Role.OWNER)
            revert OnwerCannotBeAdded();
        require(entityAddress != address(0));
        Types.Entity memory newEntity = Types.Entity(entityAddress,entityName,role,true);
        
        if(role == Types.Role.MANUFACTURER){
            manufacturerList[entityAddress] = newEntity;
        }else if(role == Types.Role.DISTRIBUTOR){
            distributorList[entityAddress] = newEntity;
        }else if(role == Types.Role.RETAILER){
            retailerList[entityAddress] = newEntity;
        }

        emit EntityAdded(role, entityAddress);
    }

    event EntityDisabled(Types.Role _role, address _entityAddress);
    event EntityAdded(Types.Role _role, address _entityAddress);

    /// @notice entity not found
    error EntityNotFound();

    /// @notice owner already registered, new owner cannot be added
    error OnwerCannotBeAdded();

    function disableEntity(address _entityAddress, Types.Role _role) public isOwner{
        if(_role == Types.Role.MANUFACTURER){
            manufacturerList[_entityAddress].isActive = false;
        }else if(_role == Types.Role.DISTRIBUTOR){
            distributorList[_entityAddress].isActive = false;
        }else if(_role == Types.Role.RETAILER){
            retailerList[_entityAddress].isActive = false;
        }else{
            revert EntityNotFound();
        }
    }

    function getEntity(address _entityAddress, Types.Role _role) view public returns(Types.Entity memory){
        if(_role == Types.Role.MANUFACTURER){
            return manufacturerList[_entityAddress];
        }else if(_role == Types.Role.DISTRIBUTOR){
            return distributorList[_entityAddress];
        }else if(_role == Types.Role.RETAILER){
            return retailerList[_entityAddress];
        }else{
            revert EntityNotFound();
        }
    }

    function getActivityStatus(address _entityAddress, Types.Role _role) view public returns(bool){
        if(_role == Types.Role.MANUFACTURER){
            return manufacturerList[_entityAddress].isActive;
        }else if(_role == Types.Role.DISTRIBUTOR){
            return distributorList[_entityAddress].isActive;
        }else if(_role == Types.Role.RETAILER){
            return retailerList[_entityAddress].isActive;
        }else if(_role == Types.Role.OWNER){
            return true;
        }else{
            revert EntityNotFound();
        }
    }

    /// @notice only manufacturers can add
    error NotManufacturer();

    modifier onlyManufacturer() {
        require(msg.sender != address(0), "Sender address is empty");
        require(manufacturerList[msg.sender].entityAddress != address(0), "Manufacturer list empty");
        if(Types.Role(manufacturerList[msg.sender].entityRole) != Types.Role.MANUFACTURER)
            revert NotManufacturer();
        _;
    }
}