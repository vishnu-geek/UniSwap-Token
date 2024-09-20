const { ethers } = require("hardhat");

async function main() {
    // Deploy CustomToken first (as it is instantiated in Uniswap)
    const CustomToken = await ethers.getContractFactory("CustomToken");
    const tokens = ['CoinA', 'CoinB', 'CoinC'];
    const tokenInstances = [];

    for (const tokenName of tokens) {
        const token = await CustomToken.deploy(tokenName, tokenName);
        await token.deployed();
        tokenInstances.push(token.address);
        console.log(`${tokenName} deployed to: ${token.address}`);
    }

    // Now deploy Uniswap
    const Uniswap = await ethers.getContractFactory("Uniswap");
    const uniswap = await Uniswap.deploy();
    await uniswap.deployed();

    console.log(`Uniswap deployed to: ${uniswap.address}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
