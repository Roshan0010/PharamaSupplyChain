// SPDX-License-Identifier: MIT
pragma solidity  >= 0.8.19 < 0.8.23;

import "./libraries/utils_library.sol";

contract SupplierContract{

    address payable public supplier;
    uint payloadId;

    constructor(address _supplier) payable {
        payloadId = Utils.generateId(supplier);
        supplier = payable(_supplier);
    }

    receive() external payable {
        updatePaymentStatus(Utils.PaymentStatus.PAYMENT_RECEIVED, payloadId);
        emit Utils.receivePayment(msg.sender, msg.value);
    }

    modifier notOwner() {
        require(msg.sender != supplier, "Supplier is not allowed to access");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == supplier, "Only supplier can access");
        _;
    }

    // stores the payloadId mapped to the chemical
    mapping(uint => Chemical) supplyHistory;
    // stores the number of payloads sent
    uint payloadCount = 0;
    // array of payload ids of chemicals supplied
    uint[] payloadIds;

    enum ChemicalDeliveryStatus {
        SOURCING, // getting the minerals from the ores or factories
        PROCESSING, 
        SHIPPED  // package is out for delivery
    }

    struct Chemical{
        string chemicalName;
        uint cost; // approx cost of the chemical manufacturing
        Utils.PaymentStatus paymentStatus;
        string[5] raw_materials; // list of top 5 raw materials used to create this product
        ChemicalDeliveryStatus deliveryStatus;
        uint payloadSize;
        uint shipmentDateAndTime; // the date on which the payload was sent out for delivery
        uint payloadId;
        uint paymentDateAndTime;
        string supplierName;
        string supplierAddress;
        string receiverName;
        string receiverAddress;
        uint expirationDate;
        uint chemicalId;
    }

    function createShipment (
        uint _cost, 
        string memory _chemicalName, 
        uint _payloadSize, 
        string[5] memory _rawMaterialList, 
        string memory _supplierName, 
        string memory _supplierAddress, 
        string memory _receiverName,
        string memory _receiverAddress,
        uint _expirationDate
        ) public payable notOwner {
        
        require(msg.value >= _cost, "The amount sent is less than the cost of the chemical");
        require(_payloadSize > 0, "No payload sent");
        
        uint chemicalId = Utils.generateId(supplier);

        Chemical memory newShipment = Chemical(
            _chemicalName,
            _cost,
            Utils.PaymentStatus.PAYMENT_NOT_RECEIVED,
            _rawMaterialList,
            ChemicalDeliveryStatus.SOURCING,
            _payloadSize,
            block.timestamp,
            payloadId,
            block.timestamp,
            _supplierName,
            _supplierAddress,
            _receiverName,
            _receiverAddress,
            _expirationDate,
            chemicalId
        );

        supplyHistory[payloadId] = newShipment;
        payloadIds.push(payloadId);
        payloadCount++;

        Utils.returnExcess(_cost, msg.value, msg.sender);

        emit createNewPayload(supplier, payloadId ,_chemicalName, newShipment, _supplierName, _expirationDate);
    }

    function getNumberOfPayloadsSent() onlyOwner public view returns(uint){
        return payloadCount;
    }

    function getChemical(uint _payloadId) public view returns(Chemical memory){
        return supplyHistory[_payloadId];
    }

    function updateDeliveryStatus(ChemicalDeliveryStatus _updatedStatus, uint _payloadId) onlyOwner public {
        supplyHistory[_payloadId].deliveryStatus = _updatedStatus;
        if(_updatedStatus == ChemicalDeliveryStatus.PROCESSING)
            emit updatedDeliveryStatus(_updatedStatus,_payloadId);
        // else if(_updatedStatus == ChemicalDeliveryStatus.SHIPPED)
        // emit payloadTransfer(supplier, , _updatedStatus);
    }
    
    function updatePaymentStatus(Utils.PaymentStatus _newPaymentStatus,  uint _payloadId) private {
        supplyHistory[_payloadId].paymentStatus = _newPaymentStatus;
        emit Utils.updatedPaymentStatus(_newPaymentStatus,_payloadId);
    }

    function getBalance() onlyOwner view public returns(uint){
        return address(this).balance;
    }

    // events
    event createNewPayload(address indexed _creationAccount, uint indexed _payloadId, string _chemicalName, Chemical _chemical, string _supplierName, uint _expirationDate);
    event payloadTransfer(address _from, address _to, ChemicalDeliveryStatus _deliveryStatus);
    event updatedDeliveryStatus(ChemicalDeliveryStatus _updatedStatus, uint _payloadId);
}