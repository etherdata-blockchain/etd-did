//Run in remix

(async () => {
    try {
        const contractName = 'EtdDIDReg'
        const artifactsPath = `browser/contracts/artifacts/${contractName}.json`
        const contractAddress = "0xDca6E0B44C662c4Ed093732cC8F5b0c0075FC25E";

        // ETD: 0xcB839E80E07CaF3cCe434198eeD262f1283db4Cb  
        // ETDv2: 0xDca6E0B44C662c4Ed093732cC8F5b0c0075FC25E

        const metadata = JSON.parse(await remix.call('fileManager', 'getFile', artifactsPath))

        await window.ethereum.enable()
        // controller account
        const accounts = await web3.eth.getAccounts()
        const defaultAccount = accounts[0]
        // generated account
        const acc = web3.eth.accounts.create().address;
        console.log("Generated address: " + String(acc));


        let contract = new web3.eth.Contract(metadata.abi)

        contract.options.address = contractAddress
        const result = await contract.methods.createId(
            acc,
            web3.utils.asciiToHex("ETD Wallet"),
            web3.utils.asciiToHex("2023-05-21T14:30:00.000Z"),
            0
        ).send({ from: defaultAccount })

        console.log(result)


    } catch (e) {
        console.log(e.message)
    }
  })()