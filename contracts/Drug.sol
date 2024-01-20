// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "./libraries/types.sol";

/**
* @title DrugContract
* @author Harshit Tathagat
* @dev contains all the details regarding drugs in the supply chain
*/
contract DrugContract{
    // list of all the drugs
    Types.Drug[] internal drugs;
    // barcodeId => DrugHistory
    mapping(uint => Types.DrugHistory) internal drugHistory;
    // list of all the drugs linked to the barcodeId
    mapping(address => uint[]) internal entityLinkedDrugs;
    // barcodeId => Drug struct
    mapping(uint => Types.Drug) internal drug;

    event DrugOwnershipTransfer(string drugName,string manufacturerName,uint barcodeId);

    event NewProduct(string name,string manufacturerName,uint barcodeId,uint manufactureDate, uint expirationDate);

    /**
     * @dev To get all the drugss linked a particular user
     * @return drugsList All the products that were linked to current logged-in user
     */
    function getEntityDrugs() public view returns(Types.Drug[] memory){
        uint[] memory id = entityLinkedDrugs[msg.sender];
        Types.Drug[] memory _drugs = new Types.Drug[](id.length);
        for(uint i=0;i<id.length;i++)
            _drugs[i] = drug[id[i]];
        return _drugs;
    }

    /**
     * @dev Get single product
     * @param _barcodeId Unique ID of the product
     * @return details of the drug & it's timeline
     * @return drug history lifecycle, who purchased when
     */
    function getSpecificDrug(uint _barcodeId) internal view returns(Types.Drug memory, Types.DrugHistory memory){
        return (drug[_barcodeId],drugHistory[_barcodeId]);
    }

    /**
     * @dev To check if product does not exists
     * @param id = drug barcode ID
     */
    modifier drugNotExist(uint id){
        require(drug[id].barcodeId == 0);
        _;
    }

    /**
     * @dev To check if product does exist
     * @param id = drug barcode ID
     */
    modifier drugExist(uint id){
        require(drug[id].barcodeId != 0);
        _;
    }

    /// @notice not valid operation
    error NotValidOperation();

    /**
    * @dev sell is used to sell the drug to the next member in the supply chain
    */
    function sell(address partyId, uint barcodeId, Types.Entity memory party, uint currentTime) internal drugExist(barcodeId){
        Types.Drug memory _drug = drug[barcodeId];

        // updating drug history
        Types.EntityHistory memory entityHistory = Types.EntityHistory({id: party.entityAddress, date: currentTime});

        if(Types.Role(party.entityRole) == Types.Role.MANUFACTURER){
            drugHistory[barcodeId].manufacturer = entityHistory;
        }else if(Types.Role(party.entityRole) == Types.Role.DISTRIBUTOR){
            drugHistory[barcodeId].distributor = entityHistory;
        }else if(Types.Role(party.entityRole) == Types.Role.RETAILER){
            drugHistory[barcodeId].retailer = entityHistory;
        }else if(Types.Role(party.entityRole) == Types.Role.CUSTOMER){
            drugHistory[barcodeId].customers.push(entityHistory);
        }else{
            revert NotValidOperation();
        }   

        transferOwnership(msg.sender, partyId, barcodeId);

        emit DrugOwnershipTransfer(_drug.drugName, _drug.manufacturerName, _drug.barcodeId);
    }

    
    function transferOwnership(address seller, address buyer, uint drugId) internal {
        // add the drugId to the list of the buyer
        entityLinkedDrugs[buyer].push(drugId);
        // get all the drugs sold by the seller
        uint[] memory sellerDrugs = entityLinkedDrugs[seller];
        uint matchIndex = sellerDrugs.length - 1;
        
        for(uint i=0;i<sellerDrugs.length;i++){
            if(sellerDrugs[i] == drugId){
                matchIndex = i;
                break;
            }
        }
        // check if the index in the valid range
        assert(matchIndex < sellerDrugs.length);

        if(sellerDrugs.length == 1){
            delete entityLinkedDrugs[seller];
        }else {
            entityLinkedDrugs[seller][matchIndex] = entityLinkedDrugs[seller][sellerDrugs.length - 1];
            delete entityLinkedDrugs[seller][sellerDrugs.length - 1];
            entityLinkedDrugs[seller].pop();
        }
    }

}