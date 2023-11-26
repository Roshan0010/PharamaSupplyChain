// SPDX-License-Identifier: MIT
pragma solidity  >= 0.8.19 < 0.8.23;

import "./libraries/utils_library.sol";
import "./Supplier_Contract.sol";
import "./Manufacturer_Contract.sol";
import "./Logistics_Contract.sol";
import "./Distributor_Contract.sol";
import "./Retailer_Contract.sol";

contract OwnerContract{
    address public owner; // owner address
    string public ownerName;

    constructor(string memory _ownerName){
        owner = msg.sender;
        ownerName = _ownerName;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You're not the smart contract owner!");
        _;
    }

/**********************************************************************************************************************/

    uint supCount = 0;

    struct Supplier{
        address supplierAddress;
        string supplierName;
        string supplierLocation;
        uint supplierId;
    }

    mapping(uint => Supplier) suppliers;

    function addSupplier(address _address, string memory _name, string memory _place) public onlyOwner{
        supCount++;
        suppliers[supCount] = Supplier(_address,_name,_place,supCount);
    }

    function findSupplier(address _address) private view returns (uint) {
        require(supCount > 0);
        for(uint i=1;i<=supCount;i++){
            if(suppliers[i].supplierAddress == _address)
                return suppliers[i].supplierId;
        }
        return 0;
    }

    address[] supplierContracts;

    function assignSupplier(address _address) public payable onlyOwner returns(address){
        // TODO: change
        require(msg.value == 0.0);
        // address of newly created contract
        address newSupplier = address(new SupplierContract{value: msg.value}(_address));
        supplierContracts.push(newSupplier);
        return newSupplier;
    }

    function createSupplierShipment(string memory _chemicalName, uint _payloadSize, string memory _receiverName, string memory _receiverAddress) public onlyOwner{

    }

/**********************************************************************************************************************/

    uint manuCount = 0;

    struct Manufacturer{
        address manufacturerAddress;
        string manufacturerName;
        string manufacturerLocation;
        uint manufacturerId;
    }

    mapping(uint => Manufacturer) manufacturers;

    function addManufacturer(address _address, string memory _name, string memory _place) public onlyOwner{
        manuCount++;
        manufacturers[manuCount] = Manufacturer(_address, _name, _place, manuCount);
    }

    function findManufacturer(address _address) private view returns (uint) {
        require(manuCount > 0);
        for(uint i=1;i<=manuCount;i++){
            if(manufacturers[i].manufacturerAddress == _address)
                return manufacturers[i].manufacturerId;
        }
        return 0;
    }

/**********************************************************************************************************************/

    uint distriCount = 0;

    struct Distributor{
        address distributorAddress;
        string distributorName;
        string distributorLocation;
        uint distributorId;
    }

    mapping(uint => Distributor) distributors;

    function addDistributor(address _address, string memory _name, string memory _place) public onlyOwner{
        distriCount++;
        distributors[distriCount] = Distributor(_address,_name,_place,distriCount);
    }

    function findDistributor(address _address) private view returns (uint) {
        require(distriCount > 0);
        for(uint i=1;i<=distriCount;i++){
            if(distributors[i].distributorAddress == _address)
                return distributors[i].distributorId;
        }
        return 0;
    }

/**********************************************************************************************************************/

    uint retailerCount = 0;

    struct Retailer{
        address retailerAddress;
        string retailerName;
        string retailerLocation;
        uint retailerId;
    }

    mapping(uint => Retailer) retailers;

    function addRetailer(address _address, string memory _name, string memory _place) public  onlyOwner{
        retailerCount++;
        retailers[retailerCount] = Retailer(_address,_name,_place,retailerCount);
    }

    function findRetailer(address _address) private view returns (uint) {
        require(retailerCount > 0);
        for(uint i=1;i<=retailerCount;i++){
            if(retailers[i].retailerAddress == _address)
                return retailers[i].retailerId;
        }
        return 0;
    }
    
/**********************************************************************************************************************/

    uint logisticsCount = 0;

    struct Logistic{
        address logisticAddress;
        string logisticName;
        string logisticLocation;
        uint logisticId;
    }

    mapping (uint => Logistic) logistics;

    function addLogistics(address _address, string memory _name, string memory _place) public onlyOwner{
        logisticsCount++;
        logistics[logisticsCount] = Logistic(_address,_name,_place,logisticsCount);
    }

    function findLogistics(address _address) private view returns (uint) {
        require(logisticsCount > 0);
        for(uint i=1;i<=logisticsCount;i++){
            if(logistics[i].logisticAddress == _address)
                return logistics[i].logisticId;
        }
        return 0;
    }
}