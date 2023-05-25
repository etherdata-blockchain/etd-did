
(async () => {
    try {
        const Web3 = require('web3');
        const web3 = new Web3(new Web3.providers.HttpProvider('https://goerli.infura.io/v3/2c19e69b16e7440ea07fc3aeb8478d85'))
        let hexString = '0x63726561746564';
        let hexString2 = '0x323032332d30352d32315431343a33303a30302e3030305a';
        console.log(String(web3.utils.hexToAscii(hexString))+':'+String(web3.utils.hexToAscii(hexString2)));
        hexString = '0x616c736f4b6e6f776e4173';
        hexString2 = '0x4554442057616c6c6574';
        console.log(String(web3.utils.hexToAscii(hexString))+':'+String(web3.utils.hexToAscii(hexString2)));

    } catch (e) {
        console.log(e.message)
    }
  })()
