const {ethers} = require('ethers');

 async function main(){
    //const [deployer] = await ethers.getDefaultProvider();

    const contractInstance = await ethers.getContractFactory("Owner_Contract.sol");
    const ownerContract = await contractInstance.deploy();
    console.log("Contract address: ", ownerContract.address);

 }

 main().then(() => process.exit(0))
.catch((error) => {
    console.log(error);
    process.exit(1);
});