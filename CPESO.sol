// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.18;

import "@openzeppelin/contracts-upgradeable@4.8.3/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.8.3/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.8.3/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.8.3/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.8.3/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.8.3/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable@4.8.3/proxy/utils/UUPSUpgradeable.sol";

/// @custom:security-contact security@cpeso.ph
contract CPESO is Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, PausableUpgradeable, OwnableUpgradeable, ERC20PermitUpgradeable, UUPSUpgradeable {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() initializer public {
        __ERC20_init("CPESO", "CPHP");
        __ERC20Burnable_init();
        __Pausable_init();
        __Ownable_init();
        __ERC20Permit_init("CPHP");
        __UUPSUpgradeable_init();

        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}
}
