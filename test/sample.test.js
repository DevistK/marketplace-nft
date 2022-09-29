const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFTMarket", function () {
  it("Should create and execute market sale", async function () {
    const Market = await ethers.getContractFactory("NFTMarket");
    const market = await Market.deploy();
    await market.deployed();
    const marketAddress = market.address;

    const NFT = await ethers.getContractFactory("NFT");
    const nft = await NFT.deploy(marketAddress);
    await nft.deployed();
    const nftContractAddress = nft.address;

    let listingPrice = await market.getListingPrice();
    listingPrice = listingPrice.toString();

    const actionPrice = ethers.utils.parseUnits("100", "ether");

    await nft.createToken("https://mytoken.com");
    await nft.createToken("https://mytoken2.com");

    await market.createMarketItem(nftContractAddress, 1, actionPrice, {
      value: listingPrice,
    });
    await market.createMarketItem(nftContractAddress, 2, actionPrice, {
      value: listingPrice,
    });

    const [_, buyerAddress] = await ethers.getSigners();
    await market.connect(buyerAddress).createMarketSale(nftContractAddress, 1);

    const items = await market.fetchMarketItems();
    console.log("items :", items);
  });
});
