![image](https://github.com/0xnehasingh/Contracts/assets/67492324/80744e64-e8bd-4d2c-af3f-e3aa2e44ddb4)

# Cryptocurrency Round Trip Calculator

## Introduction
This repository contains a Solidity smart contract for calculating a viable round trip of cryptocurrency balances across multiple exchanges, considering the network fees for transfers. The contract is designed to determine whether a trader can start from one exchange and move funds through all other exchanges in a circular fashion without losing money due to network fees.

## Problem Statement
A trader has accounts on multiple cryptocurrency exchanges. Each exchange has a balance and there is a fixed network fee associated with transferring funds from one exchange to another. The task is to find if there exists a starting exchange such that the trader can transfer all funds through each exchange and back to the start without depleting any exchange's balance below zero after accounting for network fees.

## Prerequisites
To compile and deploy this contract, you will need:
- [Node.js](https://nodejs.org/)
- [Truffle Suite](https://www.trufflesuite.com/)
- [Ganache](https://www.trufflesuite.com/ganache) for a personal Ethereum blockchain

## Installation
Clone the repository to your local machine:
```bash
git clone https://github.com/your-github-username/cryptocurrency-roundtrip.git
cd cryptocurrency-roundtrip

git clone https://github.com/your-username/vowel-remover-solidity.git
cd vowel-remover-solidity
npm install
