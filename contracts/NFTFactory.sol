//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
                   ShellFactory V1
        ███████╗██╗  ██╗███████╗██╗     ██╗
        ██╔════╝██║  ██║██╔════╝██║     ██║
        ███████╗███████║█████╗  ██║     ██║
        ╚════██║██╔══██║██╔══╝  ██║     ██║
        ███████║██║  ██║███████╗███████╗███████╗
        ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
           An open product framework for NFTs
            Dreamt up & built at Playgrounds
               https://heyshell.xyz
              https://playgrounds.wtf
*/

import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./LiquidDAONFT.sol";
import "@openzeppelin/contracts/utils/Create2.sol";
import "hardhat/console.sol";

contract NFTFactory is Ownable {
    mapping(string => DAODetails) public DAOs;

    struct DAODetails {
      uint256 percentage;
      string name;
    }

    constructor() {
        _transferOwnership(msg.sender);
    }

    event contractCreated (bool created, address NFTContractAddress);

    function registerDAO(
        DAODetails[] memory _DAODetails,
        uint numberOfTypes,
        string memory DAOName,
        string memory DAOSymbol
    ) external returns (address) {

        for (uint i  = 0; i < numberOfTypes; i++) {
          DAOs[_DAODetails[i].name].name = _DAODetails[i].name;
          DAOs[_DAODetails[i].name].percentage = _DAODetails[i].percentage;
        }

        LiquidDAONFT LiquidNFT = new LiquidDAONFT(DAOName, DAOSymbol);
        console.log(address(LiquidNFT));
        emit contractCreated(true, address(LiquidNFT));
        return address(LiquidNFT);
    }

}