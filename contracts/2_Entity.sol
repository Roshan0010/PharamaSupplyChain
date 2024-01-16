// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "./1_Ownable.sol";

/*
@dev
    Each entity in the supply chain follows the structure of this entity contract
    The entity contract contains a list of all the registered entites    
*/
contract EntityContract is Ownable{
    struct Entity{
        address entityAddress;
        string entityName;
        // @dev defines the role of the entity based on the enum role
        Role entityRole;
        bool isActive;
    }

    enum Role {OWNER, SUPPLIER, MANUFACTURER, DISTRIBUTOR, RETAILER}

    Entity[] entityList;

    function addEntity(address entityAddress, string memory entityName, Role role) public isOwner{
        Entity memory newEntity = Entity(entityAddress,entityName,role,true);
        entityList.push(newEntity);
        emit EntityAdded();
    }

    event EntityDisabled();
    event EntityAdded();

    /// @notice entity not found
    error EntityNotFound();

    function isPresent(address _entityAddress) view private returns(uint) {
        // @dev all the entities are added starting from the index 1
        for(uint i=1;i<entityList.length;i++)
        if(entityList[i].entityAddress == _entityAddress)
            return i;
        return 0;
    }

    function disableEntity(address _entityAddress) public isOwner{
        uint index = isPresent(_entityAddress);
        if(index != 0){
            entityList[index].isActive = false;
            emit EntityDisabled();
        }else{
            revert EntityNotFound();
        }
    }

    function getEntity(address _entityAddress) view public returns(Entity memory){
        uint index = isPresent(_entityAddress);
        if(index != 0)
            return entityList[index];
        revert EntityNotFound();
    }

    function getActivityStatus(address _entityAddress) view public returns(bool){
        uint index = isPresent(_entityAddress);
        if(index != 0)
            return entityList[index].isActive;
        revert EntityNotFound();
    }
}