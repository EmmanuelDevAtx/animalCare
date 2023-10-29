import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";


const SEPOLIA_PRIVATE_KEY = " yopur secret key"


const config: HardhatUserConfig = {
  solidity: "0.8.9",
  networks:{
    testing:{
      url:'http://127.0.0.1:8545/',
      accounts: [SEPOLIA_PRIVATE_KEY]
    },
    mumbai_testing:{
      url:'https://rpc-mumbai.maticvigil.com',
      accounts:[SEPOLIA_PRIVATE_KEY]
    }
  }
};

export default config;
