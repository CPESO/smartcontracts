# CPESO SmartContracts

![GitHub](https://img.shields.io/github/license/CPESO/smartcontracts?color=green) 
![GitHub release (latest by date)](https://img.shields.io/github/v/release/CPESO/smartcontracts)
![GitHub Workflow Status (branch)](https://img.shields.io/github/actions/workflow/status/CPESO/smartcontracts/publish-release.yml)
![GitHub repo size](https://img.shields.io/github/repo-size/CPESO/smartcontracts)
![GitHub Release Date](https://img.shields.io/github/release-date/CPESO/smartcontracts)

----

<br><br>

<p align="center">
  <a href="https://cpeso.ph/cpeso_whitepaper_en_v1.0.pdf">
  <img src="CPESO.svg" width="100" title="CPESO LOGO">
  </a>
</p>

## Overview

CPESO is a legal tender-based stablecoin that holds the same value as the official
currency of the Philippines, the PESO. It operates on the [ERC-20 standard](https://eips.ethereum.org/EIPS/eip-20) protocol, which
encompasses the benefits of decentralization, distributed ledger, and smart
contracts. By leveraging these advantages, CPESO aims to address numerous
shortcomings of traditional monetary systems, providing people with a secure
and convenient means to access financial services. In doing so, CPESO is forging a
new financial ecosystem based on digital assets.

## Technical Requirement

 - Smart Contracts are written with Solidity language.
 - Smart Contracts mostly uses OpenZeppelin Contracts.
 - Smart Contracts follow the Natspec Format.
 - Smart Contracts must be written with full flexibility.
 - Solidity compiler version 0.8.18 is used.
 - Smart contracts are designed to be deployed to Etherium chain.

## Functionality Requirement

### Roles

 - Owner : Can pause Burnable,Mintting,Withdraw,Deposit features
 - Admin : Can change fee, Flow pool regulation, treasury address, revoke roles
 - Treasury : Must add reward CPESO to staking contract & also receives fees
 - User : Can deposit PESO and receive CPESO also withdraw their PESO by giving back their CPESO by the current rate

 ### Features

 - Withdraw Pausibility
 - Deposit Pausibility
 - Burnable Pausibility
 - Transmission Pauseability
 - Supply Upgrade Possibility

### Use Case

1. User deposits PESO and recieves CPESO by using the deposit functionality of contract.

## Getting Started

1. Onpen the <https://remix.ethereum.org>
2. Import from GitHub `https://raw.githubusercontent.com/CPESO/smartcontracts/main/CPESO.sol`
3. Solidity Compile version: `0.8.18+commit.87f61d96`
3. Compile the contracts
4. Solidity Unit tests
5. Deploy & RUN Tranactions

## Documentation

For a detailed understanding of the CPESO, please refer to the [whitepaper](https://cpeso.ph/cpeso_whitepaper_en_v1.0.pdf).

All functions of CPESO smart contracts are described in the [CPESO Smartcontract](https://github.com/CPESO/smartcontracts)

## License

CPESO Contracts is released under the [MIT License](./LICENSE).

<!-- 
----

 <div style="padding: 16px;">
   <a href="https://cpesho.ph/Audit_Report.pdf" target="_blank">
       <img src="https://hacken.io/wp-content/uploads/2023/01/SCAudit-badge.svg" alt="Proofed by Hacken - Smart contract audit" style="width: 200px;background:white">
   </a>
</div> 

----
--> 
