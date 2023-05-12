// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title BlackCowToken
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract BlackCowToken is ERC20, Ownable {
    constructor() ERC20("BlackCow", "BLC") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
