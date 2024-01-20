// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

/**
 * @title Ownable
 * @author Harshit Tathagat
 * @dev Set owner
 */

contract Ownable {
    address public ownerAddress;

    // @notice caller is not owner
    error NotOwner();

    // modifier to check if caller is owner
    modifier isOwner() {
        if(msg.sender != ownerAddress)
            revert NotOwner();
        _;
    }

    /**
     * @dev Set contract deployer as owner
     */
    constructor() {
        console.log("Owner contract deployed by:", msg.sender);
        ownerAddress = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
    }

    /**
     * @dev Change owner
     * @param newOwner address of new owner
     */
    // function changeOwner(address newOwner) public isOwner {
    //     emit OwnerSet(ownerAddress, newOwner);
    //     ownerAddress = newOwner;
    // }

    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view returns (address) {
        return ownerAddress;
    }
} 