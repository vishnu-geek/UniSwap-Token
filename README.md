# Uniswap Clone

This project is a decentralized exchange (DEX) implementation inspired by Uniswap, allowing users to swap tokens and manage their custom ERC20 tokens on the Ethereum blockchain.

## Features

- Deploys custom ERC20 tokens.
- Allows users to swap Ether for tokens and vice versa.
- Supports custom token swaps.
- Balance checks for both Ether and tokens.
- Easy integration with web applications.

## Smart Contracts

### CustomToken.sol

- A basic ERC20 token contract that mints a specified amount of tokens to the deployer's address.

### Uniswap.sol

- Main contract that manages the token swap functionalities.
- Supports the creation and management of custom tokens.
- Provides methods for swapping Ether with tokens and vice versa.

## Getting Started

### Prerequisites

- Node.js (v14.x or higher)
- npm (Node Package Manager)
- Hardhat

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/uniswap-clone.git
   cd uniswap-clone
