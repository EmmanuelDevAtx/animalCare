import { ethers } from "hardhat";


async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const ethHandle = await ethers.deployContract("ethReciver");
;
  console.log(' ethHandle address :', await ethHandle.getAddress())
  const payments = await ethers.deployContract("AnimalsPayable", [await ethHandle.getAddress()]);

  console.log(" Animals payable address : ", await payments.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
