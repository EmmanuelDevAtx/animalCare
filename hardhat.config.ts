import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";


const SEPOLIA_PRIVATE_KEY = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"


const config: HardhatUserConfig = {
  solidity: "0.8.9",
  networks:{
    testing:{
      url:'http://127.0.0.1:8545/',
      accounts: [SEPOLIA_PRIVATE_KEY]
    }
  }
};

export default config;
