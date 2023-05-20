# Decentralized Market Manager (DMM)

## Project Members
- Jaccob Mau
- Daniel Chelling

## Overview
Decentralized Market Manager (DMM) is an innovative decentralized exchange (DEX) platform that allows users to trade various digital assets directly from their wallets. The platform utilizes an Automated Market Maker (AMM) model to enable seamless swapping of tokens, and provides users with an opportunity to add liquidity to the platform in exchange for rewards. Additionally, the DMM has implemented a Treasury Contract to attract liquidity from investors, further enhancing the platform's liquidity.

## Features
- Decentralized and non-custodial trading of digital assets.
- Liquidity Provision: A separate treasury contract that interacts with the DEX, enabling the addition and removal of liquidity to ensure the platform is well-funded and functioning optimally.
- Price Oracle Integration: DMM integrates a price oracle to fetch real-world market prices for the traded assets, enabling better price discovery and reducing the risk of price manipulation.
- Flexible Asset Swapping: Users can trade a wide range of digital assets in a permissionless and non-custodial manner, without the need for a counterparty.

## Motivation and Background
(Provide information about the motivation and background of the project here)

## References
@openzeppelin/contracts
ChatGPT version 4

## Getting Started
1. Install MetaMask browser extension and connect to a supported Ethereum test network (e.g., Rinkeby, Ropsten, Kovan, or Goerli).
2. Obtain test Ether from a faucet corresponding to the selected test network.
3. Deploy the TestTokenA and TestTokenB smart contracts using Remix IDE or another deployment tool.
4. Add the deployed test tokens to MetaMask and ensure you have a sufficient balance.
5. Deploy a custom price oracle smart contract, if required, and note down its contract address.
6. Deploy the AMM DEX smart contract, providing the addresses of the test tokens and the price oracle.
7. Interact with the AMM DEX smart contract using Remix IDE, Etherscan, or a custom frontend user interface.

## Documentation
(Provide documentation of what works and what does not here)

## Future Work
(Provide information about future work here)

## Disclaimer
Goerli Network got deprecated mid-production which messed with our schedule and testing.

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Video
See attatched CPSC298Presentation.mp4
