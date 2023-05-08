// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "tokens.sol";


// Interface for the price oracle contract
interface IPriceOracle {
    function getPrice(address token) external view returns (uint256);
}

contract AmmDexWithOracle {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    IERC20 public tokenA;
    IERC20 public tokenB;
    uint256 public reserveA;
    uint256 public reserveB;
    IPriceOracle public priceOracle;

    constructor(address _tokenA, address _tokenB, address _priceOracle) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        priceOracle = IPriceOracle(_priceOracle);
    }

    function addLiquidity(uint256 amountA, uint256 amountB) external {
        tokenA.safeTransferFrom(msg.sender, address(this), amountA);
        tokenB.safeTransferFrom(msg.sender, address(this), amountB);
        reserveA = reserveA.add(amountA);
        reserveB = reserveB.add(amountB);
    }

    function removeLiquidity(uint256 amountA, uint256 amountB) external {
        require(reserveA >= amountA, "Not enough reserveA");
        require(reserveB >= amountB, "Not enough reserveB");
        tokenA.safeTransfer(msg.sender, amountA);
        tokenB.safeTransfer(msg.sender, amountB);
        reserveA = reserveA.sub(amountA);
        reserveB = reserveB.sub(amountB);
    }

    function getAmountOut(uint256 amountIn, uint256 reserveIn, uint256 reserveOut) public pure returns (uint256) {
        require(amountIn > 0, "Invalid input amount");
        require(reserveIn > 0 && reserveOut > 0, "Invalid reserves");
        uint256 amountInWithFee = amountIn.mul(997);
        uint256 numerator = amountInWithFee.mul(reserveOut);
        uint256 denominator = reserveIn.mul(1000).add(amountInWithFee);
        uint256 amountOut = numerator / denominator;
        return amountOut;
    }

    function swap(uint256 amountAIn, uint256 amountBIn) external {
        uint256 amountAOut = getAmountOut(amountAIn, reserveA, reserveB);
        uint256 amountBOut = getAmountOut(amountBIn, reserveB, reserveA);
        tokenA.safeTransferFrom(msg.sender, address(this), amountAIn);
        tokenB.safeTransferFrom(msg.sender, address(this), amountBIn);
        tokenA.safeTransfer(msg.sender, amountAOut);
        tokenB.safeTransfer(msg.sender, amountBOut);
        reserveA = reserveA.add(amountAIn).sub(amountAOut);
        reserveB = reserveB.add(amountBIn).sub(amountBOut);
    }

    function getTokenPrices() public view returns (uint256 priceA, uint256 priceB) {
        priceA = priceOracle.getPrice(address(tokenA));
        priceB = priceOracle.getPrice(address(tokenB));
    }

    // Add this function to the AmmDexWithOracle contract

    function adjustReservesBasedOnPrice() external {
        (uint256 priceA, uint256 priceB) = getTokenPrices();
        
        require(priceA > 0 && priceB > 0, "Invalid token prices");
        
        uint256 valueOfReserveA = reserveA.mul(priceA);
        uint256 valueOfReserveB = reserveB.mul(priceB);

        if (valueOfReserveA > valueOfReserveB) {
            uint256 excessValue = valueOfReserveA.sub(valueOfReserveB);
            uint256 tokensToTransfer = excessValue.div(priceB);
            reserveA = reserveA.sub(tokensToTransfer);
            reserveB = reserveB.add(tokensToTransfer);
            tokenA.safeTransfer(msg.sender, tokensToTransfer);
            tokenB.safeTransferFrom(msg.sender, address(this), tokensToTransfer);
        } else if (valueOfReserveB > valueOfReserveA) {
            uint256 excessValue = valueOfReserveB.sub(valueOfReserveA);
            uint256 tokensToTransfer = excessValue.div(priceA);
            reserveB = reserveB.sub(tokensToTransfer);
            reserveA = reserveA.add(tokensToTransfer);
            tokenB.safeTransfer(msg.sender, tokensToTransfer);
            tokenA.safeTransferFrom(msg.sender, address(this), tokensToTransfer);
        }
    }

}