// SPDX-License-Identifier: MIT
pragma solidity  >= 0.8.19 < 0.8.23;

import "./libraries/utils_library.sol";

contract ManufacturerContract{

    address payable public manufacturer;
    uint batchId;

    constructor(){
        batchId = Utils.generateId(manufacturer);
        manufacturer = payable(msg.sender);
    }

    receive() external payable { 
        updatePaymentStatus(Utils.PaymentStatus.PAYMENT_NOT_RECEIVED, batchId);
        emit Utils.receivePayment(msg.sender, msg.value);
    }

    modifier notOwner() {
        require(msg.sender != manufacturer, "Manufacturer is not allowed to access");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == manufacturer, "Only manufacturer can access");
        _;
    }

    enum DrugStatus { MANUFACTURING, MANUFACTURED }

    struct Drug{
        string drugName;
        uint cost;
        uint batchSize;
        uint batchId;
        uint shipmentDispatchDate;
        uint shipmentDispatchTime;
        string manufacturerName;
        string manufacturerAddress;
        string receiverName;
        uint shipmentReceivedDate;
        uint shipmentReceivedTime;
        DrugStatus batchStatus;
        Utils.PaymentStatus paymentStatus;
        uint drugId;
        uint expirationDate;
    }

    mapping(uint => Drug) drugHistory;
    uint drugCount = 0;
    uint[] drugIds;


    function createDrug(
        string memory _drugName,
        uint _cost,
        uint _payloadSize,
        uint _shipmentDispatchDate,
        uint _shipmentDispatchTime,
        string memory _receiverName,
        string memory _manufacturerName,
        string memory _manufacturerAddress,
        uint _shipmentReceivedDate,
        uint _shipmentReceivedTime,
        uint _expirationDate
    ) public payable {
    
        uint drugId = Utils.generateId(manufacturer);

        Drug memory newDrug = Drug(
            _drugName,
            _cost,
            _payloadSize,
            batchId,
            _shipmentDispatchDate,
            _shipmentDispatchTime,
            _manufacturerName,
            _manufacturerAddress,
            _receiverName,
            _shipmentReceivedDate,
            _shipmentReceivedTime,
            DrugStatus.MANUFACTURING,
            Utils.PaymentStatus.PAYMENT_NOT_RECEIVED,
            drugId,
            _expirationDate
        );

        drugHistory[batchId] = newDrug;
        drugIds.push(batchId);
        drugCount++;

        Utils.returnExcess(_cost, msg.value, msg.sender);

        emit createNewBatch(manufacturer, drugId, newDrug, _expirationDate);
    }

    function getBalance() onlyOwner view public returns(uint){
        return address(this).balance;
    }

    function updateDeliveryStatus(DrugStatus _newDrugStatus, uint _batchId) onlyOwner public {
        drugHistory[_batchId].batchStatus = _newDrugStatus;
        emit updatedDeliveryStatus(_newDrugStatus, _batchId);
    }

    function updatePaymentStatus(Utils.PaymentStatus _newPaymentStatus, uint _batchId) private {
        drugHistory[_batchId].paymentStatus = _newPaymentStatus;
        emit Utils.updatedPaymentStatus(_newPaymentStatus, _batchId);
    }

    event createNewBatch(address indexed _creationAccount, uint indexed _drugId, Drug _drug, uint _expirationDate);
    event batchTransfer(string _from, string _to, DrugStatus _deliveryStatus);
    event updatedDeliveryStatus(DrugStatus _updatedDeliveryStatus, uint _batchId);
}