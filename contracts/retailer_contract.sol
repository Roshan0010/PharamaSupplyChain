// SPDX-License-Identifier: MIT
pragma solidity  >= 0.8.19 < 0.8.23;

import "./libraries/utils_library.sol";

contract RetailerContract{
    
    address payable public retailer;
    uint productId;

    constructor(address _retailer){
        productId = Utils.generateId(retailer);
        retailer = payable(_retailer);
    }

    receive() external payable {      
        updatePaymentStatus(Utils.PaymentStatus.PAYMENT_NOT_RECEIVED, productId);
        emit Utils.receivePayment(msg.sender, msg.value);
    }

    modifier notOwner() {
        require(msg.sender != retailer, "Retailer is not allowed to access");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == retailer, "Only retailer can access");
        _;
    }

    enum ProductStatus {IN_STOCK, SOLD, EXPIRED}

    struct Product{
        uint cost;
        string productName;
        uint expirationDate;
        string retailerName;
        string retailerAddress;
        uint productReceivedDate;
        uint productReceivedTime;
        uint productSoldDate;
        uint productSoldTime;
        uint productId;
        Utils.PaymentStatus paymentStatus;
        ProductStatus productStatus;
    }

    mapping (uint => Product) retailHistory;
    uint productCount = 0;
    uint[] productIds;

    function sellProduct(
        uint _cost, 
        string memory _productName, 
        uint _expirationDate, 
        string memory _retailerName, 
        string memory _retailerAddress,
        uint _productReceivedDate,
        uint _productReceivedTime,
        uint _productSoldDate,
        uint _productSoldTime) public payable {

        Product memory newProduct = Product(_cost,
            _productName,
            _expirationDate,
            _retailerName,
            _retailerAddress,
            _productReceivedDate,
            _productReceivedTime,
            _productSoldDate,
            _productSoldTime,
            productId, 
            Utils.PaymentStatus.PAYMENT_NOT_RECEIVED, 
            ProductStatus.IN_STOCK
        );

        retailHistory[productId] = newProduct;
        productCount++;
        productIds.push(productId);

        Utils.returnExcess(_cost, msg.value, msg.sender);

        emit soldProduct(retailer, _productName, _expirationDate, _cost, newProduct);
    }

    function getBalance() onlyOwner view public returns(uint){
        return address(this).balance;
    }

    function updatePaymentStatus(Utils.PaymentStatus _updatedStatus, uint _productId) private {
        retailHistory[_productId].paymentStatus = _updatedStatus;
        emit Utils.updatedPaymentStatus(_updatedStatus, _productId);
    }

    function updateProductStatus(ProductStatus _updatedStatus, uint _productId) public {
        retailHistory[_productId].productStatus = _updatedStatus;
        emit updatedProductStatus(_updatedStatus, _productId);
    }

    event soldProduct(address _retailerAccount, string _productName, uint _expirationDate, uint _cost, Product _product);
    event updatedProductStatus(ProductStatus _updatedStatus, uint _productId);
}