// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./AMMDEX.sol";

/*
  By default, the owner of an Ownable contract is the account that deployed it.
*/
contract Treasury is Ownable {
    // Function to deposit Ether into the contract
    function deposit() external payable {
        require(
            msg.value > 0,
            "Treasury: Deposit amount should be greater than zero"
        );


        // The balance of the contract is automatically updated
    }

    // Function to withdraw Ether from the contract to specified address
    function withdraw(uint256 amount, address receiver) external onlyOwner {
        require(
            address(receiver) != address(0),
            "Treasury: receiver is zero address"
        );
        require(
            address(this).balance >= amount,
            "Treasury: Not enough balance to withdraw"
        );


        (bool send, ) = receiver.call{value: amount}("");
        require(send, "To receiver: Failed to send Ether");
    }

    // Function to allow the owner to withdraw the entire balance
    function withdrawAll() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "Treasury: No balance to withdraw");


        (bool send, ) = msg.sender.call{value: balance}("");
        require(send, "To owner: Failed to send Ether");
    }


    // Function to get the contract balance
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // new code
    AMMDEX public dex;


    function setDex(address dexContract) external onlyOwner {
        require(dexContract != address(0), "Treasury: Invalid dex address");
        dex = AMMDEX(dexContract);
    }

    function addLiquidity(uint256 tokenAmount) external onlyOwner {
        require(address(this).balance > 0, "Treasury: No ether balance");
        require(IERC20(dex.token1()).balanceOf(address(this)) >= tokenAmount, "Treasury: Not enough tokens");
        IERC20(dex.token1()).transfer(address(dex), tokenAmount);
        dex.reserve0() += address(this).balance;
        dex.reserve1() += tokenAmount;
    }
    function removeLiquidity(uint256 tokenAmount) external onlyOwner {
        require(dex.reserve0() > 0 && dex.reserve1() > tokenAmount, "Treasury: Not enough liquidity");
        dex.reserve0() -= address(this).balance;
        dex.reserve1() -= tokenAmount;
        (bool send, ) = address(this).call{value: address(this).balance}("");
        require(send, "To treasury: Failed to send Ether");
        IERC20(dex.token1()).transfer(address(this), tokenAmount);
    }
}
