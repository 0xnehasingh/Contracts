// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VowelRemover {

    function removeVowels(string memory input) public pure returns (string memory) {
        bytes memory stringBytes = bytes(input);
        bytes memory resultBytes = new bytes(stringBytes.length);
        uint j = 0;
        for (uint i = 0; i < stringBytes.length; i++) {
            // Check if the character is not a vowel
            bytes1 char = stringBytes[i];
            if (char != 'a' && char != 'e' && char != 'i' && char != 'o' && char != 'u' &&
                char != 'A' && char != 'E' && char != 'I' && char != 'O' && char != 'U') {
                resultBytes[j] = char;
                j++;
            }
        }
        // Resize the result bytes array to fit the result
        bytes memory resizedResult = new bytes(j);
        for (uint i = 0; i < j; i++) {
            resizedResult[i] = resultBytes[i];
        }
        return string(resizedResult);
    }
}
