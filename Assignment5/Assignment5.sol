// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StockProfit {
    
    // Function to calculate the maximum profit
    function maxProfit(uint256[] memory prices) public pure returns (uint256) {
        // If there are less than 2 prices, then no profit can be made
        if (prices.length < 2) {
            return 0;
        }

        uint256 minPrice = prices[0];
        uint256 maxProfitValue = 0;

        // Start from the second element since we cannot sell on the first day
        for (uint i = 1; i < prices.length; i++) {
            // If we find a new minimum, update minPrice
            if (prices[i] < minPrice) {
                minPrice = prices[i];
            } else {
                // Otherwise, check if selling on this day is more profitable
                uint256 potentialProfit = prices[i] - minPrice;
                if (potentialProfit > maxProfitValue) {
                    maxProfitValue = potentialProfit;
                }
            }
        }

        return maxProfitValue;
    }
}
