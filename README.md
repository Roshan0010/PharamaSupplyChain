# Pharma-supply-chain
It's the full stack project for managing pharma supply chain using Ethereum blockchain (Solidity) in the back-end and React.js in the front-end.

### Entities:

 - Owner
 - Manufacturer
 - Distributor
 - Retailer
 - Customer

### Details:

 #### Owner:
    - Responsible for adding all the other entites to the supply chain
    - Chooses a Manufacturer to manufacture the drug: specifies the drug name and quantity

 #### Manufacturer:
    - Manufactures the drug
    - Chooses a Distributor to distributed to distribute the drug batch
    - Sends the drug to the chosen distributor

 #### Distributor:
    - Chooses retailers
    - Creates smaller batches of the drug and sends them off to the chosen retailers

 #### Retailer:
    - Stores the drugs in the inventory and sells it to the customer
    - Can discard a drug if expired
 
 #### Customer:
    - Buys drugs from a retailer

### Assumptions:

- The retailer cannot choose to refuse to receive a drug batch
- The manufacturer has all the required materials in sufficient quantity to manufacture the drug
- No partial payments are accepted
- Payment must be done at the time of order/selling in advance
- All entites in the supply chain must have a wallet(Metamask) id
- The owner of thec chain cannot be changed once set
- Only the owner is allowed to add entites in the supply chain
- An entity can choose not to participate in the supply chain by setting its 'isActive' variable to false
- The owner cannot be inactive
- An entity once added in the supply chain cannot be removed only disabled

### Contract details:

1. Ownable contact: 
    - Stores the address of the owner (company) of the drug who has placed the order
    - Contains public getter function to get the address of the owner

2. Entity contract:
    - Defines the struture of a 
    - Stores all entites in the supply chain

### Contributors:
 - Roshan Kumar Sinha 
 - Harshit Tathagat
 
 https://github.com/GeekyAnts/sample-supply-chain-ethereum/blob/main