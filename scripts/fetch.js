const path = require('path');
const fs = require('fs-extra');
const Web3 = require('web3');

import {GANACHE_URL, INFURA_URL} from 'constants.js';

const contractJsonPath = path.resolve(__dirname, '../', 'contracts', 'Owner_Contract.json');
const contractJson = JSON.parse(fs.readFileSync(contractJsonPath));
const contractAbi = contractJson.abi;

// pass GANACHE_URL as host
async function getSupplier(host, deployedContractAddress, deployedContractAbi) {
    const web3 = new Web3(host);
    const contractInstance = new web3.eth.Contract(deployedContractAbi, deployedContractAddress);

    contractInstance.methods.assignSupplier().call().then(result => {
        console.log("Result: ", result);
    }).catch(error => {
        console.log("Error: ", error);
    });
}

async function main(){

}