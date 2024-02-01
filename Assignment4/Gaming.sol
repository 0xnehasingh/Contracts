// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockchainGaming {
    address public owner;
    uint256 public constant initialCredits = 1000;
    uint256 public assetPriceIncrement = 10; // 10%
    uint256 public assetSaleCommission = 10; // 10%

    struct Player {
        string username;
        uint256 balance;
        uint256 numAssets;
    }

    struct Game {
        string name;
        bool exists;
    }

    struct Asset {
        uint256 gameId;
        uint256 price;
    }

    mapping(address => Player) public players;
    mapping(uint256 => Game) public games;
    mapping(uint256 => Asset) public assets;

    uint256 public nextGameId = 1;
    uint256 public nextAssetId = 1;

    event GameCreated(uint256 gameId, string name);
    event PlayerRegistered(address playerAddress, string username);
    event AssetBought(uint256 assetId, address buyer, uint256 price);
    event AssetSold(uint256 assetId, address seller, uint256 price);
    event AssetTransferred(uint256 assetId, address from, address to);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerPlayer(string memory _username) public {
        require(bytes(_username).length >= 3, "Username must be at least 3 characters long.");
        require(players[msg.sender].balance == 0, "Player already registered.");

        players[msg.sender] = Player({
            username: _username,
            balance: initialCredits,
            numAssets: 0
        });

        emit PlayerRegistered(msg.sender, _username);
    }

    function createGame(string memory _name) public onlyOwner {
        games[nextGameId] = Game({name: _name, exists: true});
        emit GameCreated(nextGameId, _name);
        nextGameId++;
    }

    function removeGame(uint256 _gameId) public onlyOwner {
        require(games[_gameId].exists, "Game does not exist.");
        delete games[_gameId];
    }

    function buyAsset(uint256 _assetId) public {
        require(players[msg.sender].balance >= assets[_assetId].price, "Insufficient credits.");
        
        players[msg.sender].balance -= assets[_assetId].price;
        players[msg.sender].numAssets += 1;
        
        // Increase asset price by 10%
        assets[_assetId].price = assets[_assetId].price + (assets[_assetId].price * assetPriceIncrement / 100);

        emit AssetBought(_assetId, msg.sender, assets[_assetId].price);
    }

    function sellAsset(uint256 _assetId) public {
        require(players[msg.sender].numAssets > 0, "No assets to sell.");

        // Decrease asset price by 10% for commission
        uint256 salePrice = assets[_assetId].price - (assets[_assetId].price * assetSaleCommission / 100);

        players[msg.sender].balance += salePrice;
        players[msg.sender].numAssets -= 1;

        emit AssetSold(_assetId, msg.sender, salePrice);
    }

    function transferAsset(uint256 _assetId, address _to) public {
        require(players[msg.sender].numAssets > 0, "No assets to transfer.");
        require(players[_to].balance > 0, "Recipient must be a registered player.");

        players[msg.sender].numAssets -= 1;
        players[_to].numAssets += 1;

        emit AssetTransferred(_assetId, msg.sender, _to);
    }

    function viewProfile(address _playerAddress) public view returns (string memory username, uint256 balance, uint256 numAssets) {
        Player memory player = players[_playerAddress];
        return (player.username, player.balance, player.numAssets);
    }

    function viewAsset(uint256 _assetId) public view returns (uint256 gameId, uint256 price) {
        Asset memory asset = assets[_assetId];
        return (asset.gameId, asset.price);
    }
}
