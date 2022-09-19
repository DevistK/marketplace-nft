require("@nomiclabs/hardhat-waffle");

const projectId = "ce31d4fe8e9a4da7883995a74d92e6df";
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  network: {
    hardhat: {
      chainId: 1337,
    },
    mumbai: {
      url: `https://polygon-mumbai.infura.io/v3/${projectId}`,
      account: [],
    },
    mainnet: {
      url: `https://polygon-mainnet.infura.io/v3/${projectId}`,
      accouint: [],
    },
  },
  solidity: "0.8.17",
};
