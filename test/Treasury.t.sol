// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "contracts/Treasury.sol";


contract TreasuryTest is Test {
    Treasury private treasury;
    address public owner;
    address public contractAddress;


    function setUp() public {
        owner = address(7);
        vm.startPrank(owner);


        treasury = new Treasury();
        contractAddress = address(treasury);


        vm.stopPrank();
    }


    function testInitializeOwner() public {
        assertEq(treasury.owner(), owner);
    }


    function testOwnerTransferOwnership() public {
        vm.prank(owner);
        treasury.transferOwnership(address(1));
        assertEq(address(1), treasury.owner());
    }


    function testNotOwnerTransferOwnership() public {
        vm.prank(address(1));
        vm.expectRevert("Ownable: caller is not the owner");
        treasury.transferOwnership(address(1));
        assertEq(owner, treasury.owner());
    }


    function testSuccessfulDeposit() public {
        vm.deal(address(1), 0.5 ether);
        vm.prank(address(1));
        treasury.deposit{value: 0.2 ether}();
        assertEq(contractAddress.balance, 0.2 ether);
        assertEq(address(1).balance, 0.3 ether);
    }


    function testInvalidDepositAmount() public {
        vm.deal(address(1), 0.5 ether);
        vm.prank(address(1));
        vm.expectRevert("Treasury: Deposit amount should be greater than zero");
        treasury.deposit{value: 0 ether}();
    }


    function testSuccessfulWithdraw() public {
        // supply contract with ether
        vm.deal(address(1), 0.5 ether);
               vm.prank(address(1));
        treasury.deposit{value: 0.5 ether}();


        vm.prank(owner);
        treasury.withdraw(0.4 ether, address(2));
        assertEq(contractAddress.balance, 0.1 ether);
        assertEq(address(2).balance, 0.4 ether);
    }


    function testNotOwnerWithdraw() public {
        vm.prank(address(1));
        vm.expectRevert("Ownable: caller is not the owner");
        treasury.withdraw(0.5 ether, address(2));
    }


    function testWithdrawReceiverZeroAddress() public {
        vm.prank(owner);
        vm.expectRevert("Treasury: receiver is zero address");
        treasury.withdraw(0.5 ether, address(0));
    }


    function testWithdrawInvalidAmount() public {
        vm.prank(owner);
        vm.expectRevert("Treasury: Not enough balance to withdraw");
        treasury.withdraw(0.15 ether, address(1));
    }


    function testSuccessfulWithdrawAll() public {
        // supply contract with ether
        vm.deal(address(1), 0.8 ether);
        vm.prank(address(1));
        treasury.deposit{value: 0.8 ether}();
        assertEq(contractAddress.balance, 0.8 ether);


        vm.prank(owner);
        treasury.withdrawAll();
        assertEq(contractAddress.balance, 0 ether);
        assertEq(owner.balance, 0.8 ether);
    }

   function testNotOwnerWithdrawAll() public {
        vm.prank(address(1));
        vm.expectRevert("Ownable: caller is not the owner");
        treasury.withdrawAll();
    }


    function testWithdrawAllNoBalance() public {
        vm.prank(owner);
        vm.expectRevert("Treasury: No balance to withdraw");
        treasury.withdrawAll();
    }


    function testGetBalance() public {
        // supply contract with ether
        vm.deal(address(1), 0.8 ether);
        vm.prank(address(1));
        treasury.deposit{value: 0.8 ether}();


        assertEq(treasury.getBalance(), 0.8 ether);
    }

    
    function testSetDex() public {
        vm.prank(treasury.owner());
        treasury.setDex(address(dex));
        assertEq(address(treasury.dex()), address(dex));
    }
    
    function testAddLiquidity() public {
        // Set Dex
        treasury.transferOwnership(owner);
        treasury.setDex(address(dex));

        // Fund contract with ether and tokens
        vm.deal(contractAddress, 0.5 ether);
        ERC20_YOUR_TOKEN_1_HERE.transfer(contractAddress, 1000);

        // Call addLiquidity
        vm.prank(owner);
        treasury.addLiquidity(100);

        // Check updated reserves
        assertEq(dex.reserve0(), 0.5 ether);
        assertEq(dex.reserve1(), 100);
    }

    function testRemoveLiquidity() public {
        // Set Dex
        treasury.transferOwnership(owner);
        treasury.setDex(address(dex));

        // Fund contract with ether and tokens
        vm.deal(contractAddress, 0.5 ether);
        ERC20_YOUR_TOKEN_1_HERE.transfer(contractAddress, 1000);

        // Add liquidity before testing removal
        vm.prank(owner);
        treasury.addLiquidity(100);        

        // Call removeLiquidity with owner
        vm.prank(owner);
        treasury.removeLiquidity(20);

        // Check updated reserves
        assertEq(dex.reserve0(), 0.5 ether - 0.5 ether);
        assertEq(dex.reserve1(), 100 - 20);
    }
}
