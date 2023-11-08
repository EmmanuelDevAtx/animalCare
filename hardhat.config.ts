import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";


const TEST_NET = "0xcb2cc4ea5737be8df9af158fe5085c5e90f9f33552adbbc84b95166ba94fd668";


const config: HardhatUserConfig = {
  solidity: "0.8.9",
  networks:{
    testing:{
      url:'http://127.0.0.1:8545/',
      accounts: [TEST_NET]
    },
    mumbai_testing:{
      url:'https://rpc-mumbai.maticvigil.com',
      accounts:[TEST_NET]
    },
    local:{
      url:'http://127.0.0.1:8545/',
      accounts:[TEST_NET]
    },
    ganache:{
      url:'http://192.168.1.181:7545',
      accounts:[TEST_NET]
    }
  }
};

export default config;
