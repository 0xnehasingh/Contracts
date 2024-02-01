// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptocurrencyRoundTrip {

    function roundTrip(int[] memory walletBalances, int[] memory networkFees) public pure returns (int) {
        uint n = walletBalances.length;
        for (uint i = 0; i < n; ++i) {
            if (isRoundTripPossible(walletBalances, networkFees, i)) {
                return int(i);
            }
        }
        return -1;
    }

    function isRoundTripPossible(int[] memory walletBalances, int[] memory networkFees, uint start) internal pure returns (bool) {
        int balance = 0;
        uint n = walletBalances.length;
        for (uint i = 0; i < n; ++i) {
            uint index = (start + i) % n;
            balance += walletBalances[index] - networkFees[index];
            if (balance < 0) {
                return false;
            }
        }
        return true;
    }
}
