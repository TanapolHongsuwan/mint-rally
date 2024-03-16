// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Base64.sol";
import {ERC1155Upgradeable, ERC1155SupplyUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155SupplyUpgradeable.sol";
import {IMintPoint} from "./IMintPoint.sol";

contract MintPoint is ERC1155SupplyUpgradeable, IMintPoint {
    uint256 public tokenIds;
    string public name;
    string public symbol;
    mapping(address => uint256[]) public accountTokenIds;
    mapping(address => mapping(uint256 => uint256)) public accountTokenIdsIndex;

    constructor() {
    _disableInitializers();
    }

    function initialize() public initializer {
        __ERC1155_init("");
        __ERC1155Supply_init();

        name = "MintPoint";
        symbol = "MNT";
    }

    function supportsInterface(
    bytes4 interfaceId
    ) public view override(IMintPoint, ERC1155Upgradeable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function isApprovedForAll(address account, address operator) public view override(ERC1155Upgradeable) returns (bool) {
        return super.isApprovedForAll(account, operator);
    }

    function mint(address to, uint256 tokenId) external {
        require(tokenId < tokenIds, "MintPoint: tokenId is not registered.");
        require(balanceOf(to, tokenId) < 1, "MintPoint: already minted.");
        _mint(to, tokenId, 1, "");

        emit Mint(to, tokenId);
    }

    function register() external {
        uint256 tokenId = tokenIds;

        tokenIds++;

        emit Register(_msgSender(), tokenId);
    }

    function burn(uint256 tokenId) external {
        require(tokenId < tokenIds, "MintPoint: tokenId is not registered.");
        require(balanceOf(_msgSender(), tokenId) >= 1, "MintPoint: not minted.");
        _burn(_msgSender(), tokenId, 1);
    }
}