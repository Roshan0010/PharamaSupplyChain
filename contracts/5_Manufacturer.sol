// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "./1_Ownable.sol";
import "./2_Entity.sol";
import "./4_Drug.sol";
import "./6_Supplier.sol";
import "./libraries/utils_library.sol";

contract Manufacturer is EntityContract, DrugContract, Supplier{
    address public manufacturerAddress;
    string public manufacturerName;

    DrugBatch[] batchesManufactured;

    event NewBatchCreated(uint batchId);

    /// @notice you are not the manufacturer
    error NotManufacturer();

    modifier onlyManufacturer(){ 
        if(msg.sender != manufacturerAddress)
            revert NotManufacturer();
        _;
    }

    function createDrugs(string memory _drugName, uint _manufacturingDate, uint _expirationDate,string [5] memory _composition, uint _drugPrice) pure private returns(Drug memory){
        Drug memory newDrug = Drug(_drugName,_expirationDate,_manufacturingDate,_drugPrice,_composition);
        return newDrug;
    }

    function createDrugBatch(string memory _drugName, uint _batchSize, uint _manufacturingDate, uint _expirationDate,string [5] memory _composition, uint _drugPrice) public {
        Drug memory drug = createDrugs(_drugName, _manufacturingDate, _expirationDate, _composition, _drugPrice);
        uint batchId = Utils.generateId(manufacturerAddress);
        DrugBatch memory newDrugBatch = DrugBatch(_batchSize, batchId, drug, Stage.MANUFACTURING);
        updateBatchStatus(batchId, Stage.MANUFACTURING);
        batchesManufactured.push(newDrugBatch);
        manufacturedDrugs.push(newDrugBatch);
        emit NewBatchCreated(batchId);
    }

    function assignRetailer(string memory _drugName, uint _batchSize) public {
        initiateSupply(_drugName,_batchSize);
    }

    function sendToDistributor() public {}
}