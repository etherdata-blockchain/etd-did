(async () => {
    try {

        await window.ethereum.enable()
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        const accounts = await provider.send("eth_requestAccounts", []);
        const defaultAccount = accounts[0]
        console.log(`default account: ${defaultAccount}`)
        //签名
        const signer = await provider.getSigner()
        const msg = web3.utils.asciiToHex("Hello Did!")
        const signature = await signer.signMessage(msg)
        console.log(signature)
        //验证
        const signStatus = verify(defaultAccount, signature, msg);
        console.log(`signStatus: ${signStatus}`)

    } catch (e) {
        console.log(e.message)
    }
  })()

  function verify(address, signature, msg) {
    let signValid = false
    console.log(`address: ${address}`)
    const decodedAddress = ethers.utils.verifyMessage(msg, signature)
    console.log(`decodedAddress: ${decodedAddress}`)
    if (address.toLowerCase() === decodedAddress.toLowerCase()) {
        signValid = true
    }
    return signValid
}