// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CustomToken is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 100000 * 10 ** 18);
    }
}

contract Uniswap {
    string[] public tokens = ["CoinA", "CoinB", "CoinC"];
    mapping(string => ERC20) public tokenInstancemap;
    uint ethValue = 100000000000000;

    constructor() {
        for (uint i = 0; i < tokens.length; i++) {
            CustomToken token = new CustomToken(tokens[i], tokens[i]);
            tokenInstancemap[tokens[i]] = token;
        }
    }

    function getBalance(
        string memory tokenName,
        address _address
    ) public view returns (uint) {
        return tokenInstancemap[tokenName].balanceOf(_address);
    }

    function getName(
        string memory tokenName
    ) public view returns (string memory) {
        return tokenInstancemap[tokenName].name();
    }

    function getTokenAddress(
        string memory tokenName
    ) public view returns (address) {
        return address(tokenInstancemap[tokenName]);
    }

    function SwapEthToken(
        string memory tokenName
    ) public payable returns (uint) {
        uint inputValue = msg.value;
        uint outputValue = (inputValue / ethValue) * 10 ** 18;
        require(tokenInstancemap[tokenName].transfer(msg.sender, outputValue));
        return outputValue;
    }

    function swapTokenToETH(
        string memory tokenName,
        uint _amount
    ) public returns (uint) {
        uint exactAmount = _amount / 10 ** 18;
        uint ethTOBeTransferred = exactAmount * ethValue;
        require(
            address(this).balance >= ethTOBeTransferred,
            "DEX is Running low on balance"
        );
        payable(msg.sender).transfer(ethTOBeTransferred);
        require(
            tokenInstancemap[tokenName].transferFrom(
                msg.sender,
                address(this),
                _amount
            )
        );
        return ethTOBeTransferred;
    }

    function CustomSwap(
        string memory srcTokenName,
        string memory destTokenName,
        uint _amount
    ) public {
        require(
            tokenInstancemap[srcTokenName].transferFrom(
                msg.sender,
                address(this),
                _amount
            )
        );
        require(tokenInstancemap[destTokenName].transfer(msg.sender, _amount));
    }

    function getEthBalance() public view returns (uint) {
        return address(this).balance;
    }
}
