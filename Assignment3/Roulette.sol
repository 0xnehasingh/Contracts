// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";


contract RouletteGame {
    using EnumerableSet for EnumerableSet.AddressSet;

    
    IERC20 public token;
    address public owner;
    uint public spinWheelResult;
    mapping(address => uint) public balance;
    mapping(uint => address[]) public betsOnNumber;
    mapping(uint => uint[]) public amountsOnNumber;
    EnumerableSet.AddressSet private betAmountOnEven;
    EnumerableSet.AddressSet private betAmountOnOdd;
  

    event TokensPurchased(address indexed buyer, uint amount);
    event BetPlacedOnNumber(address indexed better, uint number, uint amount);
    event BetPlacedOnEven(address indexed better, uint amount);
    event BetPlacedOnOdd(address indexed better, uint amount);
    event SpinWheelResult(uint result);
    event WinningsTransferred(address indexed winner, uint amount);

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function buyTokens() external payable {
        require(msg.value > 0, "Send ETH to buy tokens");
        uint tokensToBuy = msg.value; // Assuming 1 ETH = 1 Token for simplicity
        token.transfer(msg.sender, tokensToBuy);
        emit TokensPurchased(msg.sender, tokensToBuy);
    }

    function placeBetOnNumber(uint betAmount, uint number) external {
        require(number >= 0 && number <= 36, "Invalid number");
        require(token.balanceOf(msg.sender) >= betAmount, "Insufficient tokens");
        token.transferFrom(msg.sender, address(this), betAmount);
        betsOnNumber[number].push(msg.sender);
        amountsOnNumber[number].push(betAmount);
        emit BetPlacedOnNumber(msg.sender, number, betAmount);
    }

    function placeBetOnEven(uint betAmount) external {
    require(token.balanceOf(msg.sender) >= betAmount, "Insufficient tokens");
    token.transferFrom(msg.sender, address(this), betAmount);
    betAmountOnEven.add(msg.sender);
    emit BetPlacedOnEven(msg.sender, betAmount);
}

function placeBetOnOdd(uint betAmount) external {
    require(token.balanceOf(msg.sender) >= betAmount, "Insufficient tokens");
    token.transferFrom(msg.sender, address(this), betAmount);
    // Access _set directly and call add
    betAmountOnOdd.add(msg.sender);(msg.sender);
    emit BetPlacedOnOdd(msg.sender, betAmount);
}
    function spinWheel() external onlyOwner {
        spinWheelResult = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % 37;
        emit SpinWheelResult(spinWheelResult);
    }

    function setSpinWheelResult(uint _result) external onlyOwner {
        spinWheelResult = _result;
    }

    function transferWinnings() external {
        uint winningNumber = spinWheelResult;

        // Iterate through bets on numbers and distribute winnings
        for (uint i = 0; i < betsOnNumber[winningNumber].length; i++) {
            address winner = betsOnNumber[winningNumber][i];
            uint winningAmount = amountsOnNumber[winningNumber][i] * 35; // Payout 35x for winning number
            token.transfer(winner, winningAmount);
            emit WinningsTransferred(winner, winningAmount);
        }

        // Distribute winnings for even bets
 if (winningNumber % 2 == 0) {
    for (uint256 i = 0; i < betAmountOnEven.length(); i++) {
        address winner = betAmountOnEven.at(i);
        require(betAmountOnEven.contains(winner), "Winner address not found");

        uint winningAmount = token.balanceOf(winner) * 2; // Payout 2x for even bets
        token.transfer(winner, winningAmount);
        emit WinningsTransferred(winner, winningAmount);

        betAmountOnEven.remove(winner); // Remove the winner from the set
    }
}

// Distribute winnings for odd bets
if (winningNumber % 2 != 0) {
    for (uint256 i = 0; i < betAmountOnOdd.length(); i++) {
        address winner = betAmountOnOdd.at(i);
        require(betAmountOnOdd.contains(winner), "Winner address not found");

        uint winningAmount = token.balanceOf(winner) * 2; // Payout 2x for odd bets
        token.transfer(winner, winningAmount);
        emit WinningsTransferred(winner, winningAmount);

        betAmountOnOdd.remove(winner); // Remove the winner from the set
    }
}

        // Reset bet amounts for the next round
        for (uint i = 0; i < 37; i++) {
            delete betsOnNumber[i];
            delete amountsOnNumber[i];
        }
       
    }

    // View functions to check balances and bets
    function checkBalance() external view returns (uint) {
        return token.balanceOf(msg.sender);
    }

    function checkWinningNumber() external view returns (uint) {
        return spinWheelResult;
    }

   
    // Destroy contract and reclaim leftover funds
    function kill() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}