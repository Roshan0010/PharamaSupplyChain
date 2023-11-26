// SPDX-License-Identifier: MIT
pragma solidity  >= 0.8.19 < 0.8.23;

library Utils{
    // utility function to generate a random hash id
    function generateId(address _address) public view returns(uint){
         return uint(keccak256(abi.encodePacked(_address,block.timestamp)));   
    }

    function returnExcess(uint _cost, uint _amountSent, address _to) public {
        // returning the excess money
        if(_amountSent > _cost){
            payable(_to).transfer(_amountSent - _cost);
        }
    }

    enum PaymentStatus{
        PAYMENT_NOT_RECEIVED,
        PAYMENT_RECEIVED
    }

    event receivePayment(address _from, uint _amount);
    event updatedPaymentStatus(Utils.PaymentStatus _updatedPaymentStatus, uint _id);
}