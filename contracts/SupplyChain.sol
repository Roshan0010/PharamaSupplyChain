// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Drug.sol";
import "./Entity.sol";

/**
* @title SupplyChain
* @author Harshit Tathagat
* @dev implements supply chain
*       inherits from the entity and drug contracts
*/

contract SupplyChain is EntityContract, DrugContract{
    function getAllDrugs() public view returns(Types.Drug[] memory){
        return drugs;
    }

    function getMyDrug() public view returns(Types.Drug[] memory){
        return getEntityDrugs();
    }

    function getASingleDrug(uint barcodeId) public view returns(Types.Drug memory,Types.DrugHistory memory){
        return getSpecificDrug(barcodeId);
    }

    function addDrug(Types.Drug memory drug,uint currentTime) public onlyManufacturer{
        //addADrug(drug,currentTime);
    }

    function sellDrug(address partyId, uint barcodeId, uint currentTime) public {
        
    }

    function addParty(Types.Entity memory entity) public {
        
    }

    function getEntityDetails(address entityId, Types.Role role) view public returns(Types.Entity memory){
        return getEntity(entityId, role);
    }

}