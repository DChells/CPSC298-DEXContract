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
- The rise of decentralized finance (DeFi) has created a need for decentralized exchanges (DEXs) that allow users to trade digital assets directly from their wallets. This project was motivated by the desire to contribute to this growing field.
- Automated Market Makers (AMMs) have emerged as a popular model for DEXs due to their ability to provide liquidity and enable seamless token swapping. This project aims to implement an AMM model in the DMM platform.
- The integration of a price oracle is a critical feature for any DEX, as it allows the platform to fetch real-world market prices for traded assets. This enhances price discovery and reduces the risk of price manipulation.
- The project also aims to implement a treasury contract to attract liquidity from investors, further enhancing the platform's liquidity and functionality.

## References
@openzeppelin/contracts
ChatGPT version 3.5

## Getting Started
1. Install MetaMask browser extension and connect to a supported Ethereum test network (e.g., Rinkeby, Ropsten, Kovan, or Goerli).
2. Obtain test Ether from a faucet corresponding to the selected test network.
3. Deploy the TestTokenA and TestTokenB smart contracts using Remix IDE or another deployment tool.
4. Add the deployed test tokens to MetaMask and ensure you have a sufficient balance.
5. Deploy a custom price oracle smart contract, if required, and note down its contract address.
6. Deploy the AMM DEX smart contract, providing the addresses of the test tokens and the price oracle.
7. Interact with the AMM DEX smart contract using Remix IDE, Etherscan, or a custom frontend user interface.

## Future Work
- The current implementation of the DMM platform could be extended to support more digital assets, increasing its utility for users.
- The platform's integration with the price oracle could be improved to support more sophisticated price discovery mechanisms, such as time-weighted average prices (TWAPs).
- The treasury contract could be enhanced to support more complex financial incentives for liquidity providers, such as yield farming or liquidity mining.
- The platform could be integrated with other DeFi protocols to provide additional services to users, such as lending and borrowing.
- The user interface of the platform could be improved to enhance user experience and attract more users to the platform.
- The platform could implement a governance mechanism, allowing users to vote on key decisions and updates to the platform. This would make the platform more decentralized and democratic.
- The platform could also consider implementing Layer 2 solutions or cross-chain compatibility to improve scalability and reduce transaction costs

## Disclaimer
Goerli Network got deprecated mid-production which messed with our schedule and testing.

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Video
See attatched CPSC298Presentation.mp4
