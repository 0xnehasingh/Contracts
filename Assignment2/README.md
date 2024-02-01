![image](https://github.com/0xnehasingh/Contracts/assets/67492324/27d2c347-c8de-4af8-9e13-87247ab4d595)


# Cryptocurrency Round Trip Calculator

## Introduction
This repository contains a Solidity smart contract for calculating a viable round trip of cryptocurrency balances across multiple exchanges, considering the network fees for transfers. The contract is designed to determine whether a trader can start from one exchange and move funds through all other exchanges in a circular fashion without losing money due to network fees.

## Problem Statement
A trader has accounts on multiple cryptocurrency exchanges. Each exchange has a balance and there is a fixed network fee associated with transferring funds from one exchange to another. The task is to find if there exists a starting exchange such that the trader can transfer all funds through each exchange and back to the start without depleting any exchange's balance below zero after accounting for network fees.

## Features

Round Trip Evaluation: Determines if a round trip transaction is possible starting from any wallet, given the balances of the wallets and the network fees required for transactions between them.
Network Fee Accounting: Considers the network fees for each transaction to ensure the feasibility of the round trip.
Efficiency: Optimized for minimal gas consumption with pure functions that do not modify the contract state.
## Prerequisites

To interact with this contract, you will need:

  An Ethereum wallet with some ETH for deployment and transaction fees.
  A Solidity development environment such as Remix, Truffle, or Hardhat set up on your computer or browser.

## Installation

### 1. Clone the Repository:

<img width="593" alt="Screenshot 2024-02-01 at 4 03 18 PM" src="https://github.com/0xnehasingh/Contracts/assets/67492324/c2311f00-3e77-48a2-9796-4f8b3bb4fb9e">

### 2. Navigate to the Contract Directory:

<img width="596" alt="Screenshot 2024-02-01 at 4 04 14 PM" src="https://github.com/0xnehasingh/Contracts/assets/67492324/1288a731-ff64-4028-8768-17d43b90aafb">


### 3. Install Dependencies:

Make sure you have npm installed and run:

<img width="589" alt="Screenshot 2024-02-01 at 4 05 19 PM" src="https://github.com/0xnehasingh/Contracts/assets/67492324/4a293bb6-55fa-47e7-b076-384068c1142b">

This step is more relevant if you are using a project setup with Truffle or Hardhat that may have dependencies.

## Usage
To use the CryptocurrencyRoundTrip contract, follow these steps:

### Deploy the Contract:

Use your preferred Solidity development environment to compile and deploy the contract to an Ethereum testnet or mainnet.

### Interact with the Contract:

  roundTrip: Pass arrays of wallet balances and corresponding network fees to this function. It will return the index of the starting wallet 
  if a round trip is possible, or -1 if it is not.

Example call:

<img width="599" alt="Screenshot 2024-02-01 at 4 00 29 PM" src="https://github.com/0xnehasingh/Contracts/assets/67492324/418afb45-566e-4c0b-9254-5cc080b57605">
