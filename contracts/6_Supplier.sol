// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import "./2_Entity.sol";
import "./5_Manufacturer.sol";

contract Supplier is EntityContract{
    address public supplierAddress;
    string public supplierName;

    struct Supply{
        string drugName;
        address to;
        uint quantity;
    }

    Supply[] supplyHistory;

    //@notice you are not the supplier
    error NotSupplier();

    modifier onlySupplier(){
        if(msg.sender != supplierAddress)
            revert NotSupplier();
        _;
    }

    event NewSupply(string[5] composition);

    function initiateSupply(string memory _drugName, uint _batchSize) public {
        Supply memory newSupply = Supply(_drugName,msg.sender,_batchSize);
        supplyHistory.push(newSupply);
    }

    // @dev get the list of items supplied
    function createSupply(string memory item1, string memory item2, string memory item3, string memory item4, string memory item5) onlySupplier private {
        string[5] memory contents;
        
        contents[0] = item1;
        contents[1] = item2;
        contents[2] = item3;
        contents[3] = item4;
        contents[4] = item5;

        // @dev the constituents are emitted to the front end and are read
        emit NewSupply(contents);
    }

}