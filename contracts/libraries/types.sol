// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/**
* @title Types
* @author Harshit Tathagat
* @dev contains all the custom defined structures and enums
*/

library Types{
    struct Entity{
        address entityAddress;
        string entityName;
        Role entityRole;
        bool isActive;
    }

    enum Role {
        OWNER, // 0
        MANUFACTURER, // 1
        DISTRIBUTOR, // 2
        RETAILER, // 3
        CUSTOMER // 4
    }

    struct EntityHistory{
        address id; // account id of the entity
        uint date; //  purchased date in epoch in UTC timezone
    }

    struct DrugHistory{
        EntityHistory manufacturer;
        EntityHistory distributor;
        EntityHistory retailer;
        EntityHistory[] customers;
    }

    // drug batch
    struct Drug{
        string drugName;
        string manufacturerName;
        uint manufactureDate;
        uint expirationDate;
        uint barcodeId;
        string[] compostion;
        uint drugCost;
        uint batchCount; // quantity in a single batch
        Stages stage;
    }

    enum Stages{
        MANUFACTURED, // 1
        DISTRIBUTED // 2
    }
}