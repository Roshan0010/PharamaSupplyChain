// SPDX-License-Identifier: MIT
pragma solidity  >= 0.8.19 < 0.8.23;

import "./libraries/utils_library.sol";

contract LogisticsContract{
    
    address payable public logistics;
    uint cargoId;

    constructor(){
        cargoId = Utils.generateId(logistics);
        logistics = payable(msg.sender);
    }

    receive() external payable { 
        updatePaymentStatus(Utils.PaymentStatus.PAYMENT_RECEIVED, cargoId);
        emit Utils.receivePayment(msg.sender,msg.value);
    }

    modifier notOwner() {
        require(msg.sender != logistics, "Logistic is not allowed to access");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == logistics, "Only logistic can access");
        _;
    }

    enum CargoType { LIQUID, BULK, GENERAL, CONDITION, HAZARDOUS, VALUABLE }

    enum CargoStatus { PACKING, OUT_FOR_DELIVERY, DELIVERED }

    struct Cargo{
        uint cost; // cost of delivery
        string cargoName;
        uint numOfUnits;
        Utils.PaymentStatus paymentStatus;
        string senderName;
        string senderAddress;
        string receiverName;
        string receiverAddress;
        uint cargoId;
        CargoType cargoType;
        uint dispatchDate;
        uint dispatchTime;
        CargoStatus cargoStatus;
    }

    mapping (uint => Cargo) cargoHistory;
    uint cargoCount = 0;
    uint[] cargoIds;

    function createCargo(
        uint _cost,
        string memory _cargoName,
        uint _numOfUnits,
        string memory _senderName,
        string memory _senderAddress,
        string memory _receiverName,
        string memory _receiverAddress,
        uint _dispatchDate,
        uint _dispatchTime
    ) public payable {
        
        Cargo memory newCargo = Cargo(
            _cost,
            _cargoName,
            _numOfUnits,
            Utils.PaymentStatus.PAYMENT_NOT_RECEIVED,
            _senderName,
            _senderAddress,
            _receiverName,
            _receiverAddress,
            cargoId,
            CargoType.CONDITION,
            _dispatchDate,
            _dispatchTime,
            CargoStatus.PACKING
        );

        cargoHistory[cargoId] = newCargo;
        cargoIds.push(cargoId);
        cargoCount++;

        Utils.returnExcess(_cost, msg.value, msg.sender);

        emit createNewCargo(_cargoName, _senderName, _receiverName, newCargo);
    }

    function getBatch(uint _cargoId) public view returns(Cargo memory) {
        return cargoHistory[_cargoId];
    }

    function getNumberOfCargoSent() public view returns(uint) {
        return cargoCount;
    }

    function updatePaymentStatus(Utils.PaymentStatus _updatedStatus, uint _cargoId) private {
        cargoHistory[_cargoId].paymentStatus = _updatedStatus;
        emit Utils.updatedPaymentStatus(_updatedStatus,_cargoId);
    }

    function updateDeliveryStatus(CargoStatus _updatedStatus, uint _cargoId) public onlyOwner {
        cargoHistory[_cargoId].cargoStatus = _updatedStatus;
        emit updatedCargoStatus(_updatedStatus,_cargoId);
    }

    function getBalance() onlyOwner view public returns(uint){
        return address(this).balance;
    }

    event createNewCargo(string _cargoName, string _senderName, string _receiverName, Cargo _cargo);
    event updatedCargoStatus(CargoStatus _updatedStatus, uint _cargoId);
    event cargoDispatch(address _from, address _to, CargoStatus _updatedStatus);
}