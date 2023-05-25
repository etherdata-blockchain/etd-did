(async () => {
    try {
        // const Web3 = require('web3');
        // const web3 = new Web3(new Web3.providers.HttpProvider('https://goerli.infura.io/v3/2c19e69b16e7440ea07fc3aeb8478d85'))
        // const web3 = new Web3(new Web3.eth.currentProvider)
        const contractName = 'EtdDIDReg'
        const artifactsPath = `browser/contracts/artifacts/${contractName}.json`
        const contractAddress = "0xDca6E0B44C662c4Ed093732cC8F5b0c0075FC25E";

        const metadata = JSON.parse(await remix.call('fileManager', 'getFile', artifactsPath))
        await window.ethereum.enable()

        let contract = new web3.eth.Contract(metadata.abi)
        // const contract = new ethers.Contract(contractAddress, metadata.abi);

        contract.options.address = contractAddress

        const eventName = 'AttributeChanged';
        // const startBlock = 8901654; // 起始区块号

        contract.getPastEvents(eventName, {
            fromBlock: 0,
            toBlock: 'latest'
        }, (error, events) => {
            if (error) console.error(error);
            console.log(events);
        });
    } catch (e) {
        console.log(e.message)
    }
  })()




