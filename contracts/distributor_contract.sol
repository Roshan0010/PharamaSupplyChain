// SPDX-License-Identifier: MIT
pragma solidity  >= 0.8.19 < 0.8.23;

import "./libraries/utils_library.sol";

contract DistributorContract{
    
    address payable public distributor;
    uint shipmentId;

    constructor(address _distributor) {
        shipmentId = Utils.generateId(distributor);
        distributor = payable(_distributor);
    }

    receive() external payable {
        updatePaymentStatus(Utils.PaymentStatus.PAYMENT_RECEIVED, shipmentId);
        emit Utils.receivePayment(msg.sender, msg.value);
     }

     
    modifier notOwner() {
        require(msg.sender != distributor, "Distributor is not allowed to access");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == distributor, "Only distributor can access");
        _;
    }

    enum DistributionDeliveryStatus{
        NOT_RECEIVED,
        DISTRIBUTED
    }

    struct Shipment{
        uint cost;
        string productName;
        uint shipmentId;
        uint shipmentDate;
        uint shipmentTime;
        string distributorName;
        string retailerName;
        uint shipmentSize;
        Utils.PaymentStatus paymentStatus;
        DistributionDeliveryStatus deliveryStatus;
    }

    mapping(uint => Shipment) shipmentHistory;
    uint shipmentCount = 0;
    uint[] shipmentIds;

    function createShipment(
        uint _cost,
        string memory _productName,
        uint _shipmentDate,
        uint _shipmentTime,
        string memory _distributorName,
        string memory _retailerName,
        uint _shipmentSize) public payable {

        Shipment memory newShipment = Shipment(
            _cost,
            _productName,
            shipmentId,
            _shipmentDate,
            _shipmentTime,
            _distributorName,
            _retailerName,
            _shipmentSize,
            Utils.PaymentStatus.PAYMENT_NOT_RECEIVED,
            DistributionDeliveryStatus.NOT_RECEIVED
        );

        shipmentHistory[shipmentId] = newShipment;
        shipmentCount++;
        shipmentIds.push(shipmentId);

        Utils.returnExcess(_cost,msg.value,msg.sender);

        emit createNewShipment(distributor, shipmentId, newShipment);
    }

    function updatePaymentStatus(Utils.PaymentStatus _newPaymentStatus,  uint _shipmentId) private {
        shipmentHistory[_shipmentId].paymentStatus = _newPaymentStatus;
        emit Utils.updatedPaymentStatus(_newPaymentStatus,_shipmentId);
    }
    
    function getBalance() onlyOwner view public returns(uint){
        return address(this).balance;
    }

    event createNewShipment(address _creationAccount, uint _shipmentId, Shipment _newShipment);
    event updatedDeliveryStatus(DistributionDeliveryStatus _updatedStatus, uint _batchId);
}