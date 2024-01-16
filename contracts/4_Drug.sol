// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "./1_Ownable.sol";

contract DrugContract{
    struct Drug{
        string drugName;
        uint expirationDate;
        uint manufacturingDate;
        uint drugPrice;
        string[5] composition;
    }

    struct DrugBatch{
        uint batchSize;
        uint batchId;
        Drug drug;
        Stage batchStage;
    }

    event BatchStatus(uint batchId, Stage batchStage);

    // @notice batch not found
    error BatchNotFound();

    // @dev list of all manufactured drugs for the owner to read from
    DrugBatch[] public manufacturedDrugs;

    enum Stage {SUPPLYING, MANUFACTURING, DISTRIBUTING}

    function isPresent(uint _batchId) private view returns(uint){
        for(uint i=0;i<manufacturedDrugs.length;i++)
            if(manufacturedDrugs[i].batchId == _batchId)
                return i;
        return 0;
    }

    function getDrugBatch(uint _batchId) public view returns(DrugBatch memory){
        uint index = isPresent(_batchId);
        if(index != 0)
            return manufacturedDrugs[index];
        else    
            revert BatchNotFound();
    }

    function updateBatchStatus(uint _batchId, Stage _batchStage) public {
        uint index = isPresent(_batchId);
        if(index != 0){
            manufacturedDrugs[index].batchStage = _batchStage;
            emit BatchStatus(_batchId, _batchStage);
        }else   
            revert BatchNotFound();
    }
}