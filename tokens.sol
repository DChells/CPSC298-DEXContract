// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestTokenA is ERC20 {
    constructor() ERC20("Test Token A", "TTA") {
        uint256 initialSupply = 1000000 * (10 ** decimals());
        _mint(msg.sender, initialSupply);
    }
}

contract TestTokenB is ERC20 {
    constructor() ERC20("Test Token B", "TTB") {
        uint256 initialSupply = 1000000 * (10 ** decimals());
        _mint(msg.sender, initialSupply);
    }
}

