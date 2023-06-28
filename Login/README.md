## Metamask签名登陆流程

1. 流程
   1. 用户在前端网页上点击登录按钮，并且前端代码与 MetaMask 进行连接。
   2. 前端代码通过调用 `window.ethereum.request({ method: 'eth_requestAccounts' })` 来请求用户连接到 MetaMask。
   3. 后端通过Metamask的masterAccount以及DApp的信息，通过DID Contract查询到相应的用来登陆DID
   4. 前端向后端发送请求以获取与用户钱包地址关联的随机数（nonce）。
   5. 前端调用 `web3.personal.sign(nonce, web3.eth.coinbase, callback)` 来提示 MetaMask 显示签名确认弹窗，其中随机数会显示在弹窗中。
   6. 用户在 MetaMask 中确认签名，并通过回调函数将带有签名的消息（signature）传递给前端。
   7. 前端将签名消息与用户钱包地址一起发送到后端的身份验证接口。
   8. 后端根据用户钱包地址获取对应的随机数（nonce），并使用签名验证算法来验证签名的有效性。
   9. 如果签名验证成功，后端可以进行用户身份认证，并返回给前端一个身份标识符（如 JWT）以进行后续的授权访问。
   10. 为了防止重放攻击，后端会改变下次用户登录时所需的随机数（nonce）。

2. 流程图

![](https://raw.githubusercontent.com/X-i-e/picbed/main/metamask%E7%99%BB%E5%BD%95%E6%B5%81%E7%A8%8B.svg)

3. js代码

```js
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
```

