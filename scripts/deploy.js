const hre = require("hardhat");
const fs = require('fs');

async function main() {
  // const NFTMarketplace = await hre.ethers.getContractFactory("NFTMarketplace");
  // const nftMarketplace = await NFTMarketplace.deploy();
  // await nftMarketplace.deployed();
  // console.log("nftMarketplace deployed to:", nftMarketplace.address);

  const Factory = await hre.ethers.getContractFactory("NFTFactory");
  const factoryDeployed = await Factory.deploy();
  await factoryDeployed.deployed();
  console.log("nftMarketplace deployed to:", factoryDeployed.address);
  factoryDeployed.on('contractCreated', res => console.log(res))
  fs.writeFileSync('./config.js', `
  export const marketplaceAddress = "${factoryDeployed.address}"
  `);

  async function createDAO() {
    const DAODetails = [
      { name: 'investors', percentage: 20},
      { name: 'contributors', percentage: 30},
      { name: 'founding team', percentage: 50},
    ];
    const DAOName = 'first DAO';
    const DAOSymbol = 'FDA'
    const result = await factoryDeployed.registerDAO(
      DAODetails,
      3,
      DAOName,
      DAOSymbol
    )

    console.log(await result.wait())



  }

  await createDAO();
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
