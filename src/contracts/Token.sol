// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    address public minter;

    event MinterChanged(address indexed from, address to);

    constructor() public payable ERC20("Moeda Gotinho", "MGT") {
        minter = msg.sender;
    }

    function passMinterRole(address dBank) public returns (bool) {
        require(msg.sender == minter, "Erro apenas o dono pode mudar o minter");
        minter = dBank;

        emit MinterChanged(msg.sender, dBank);
        return true;
    }

    function mint(address account, uint256 amount) public {
        //check if msg.sender have minter role
        require(
            msg.sender == minter,
            "Erro, msg.sender n\xC3\xA3o t\xC3\xAAm permiss\xC3\xA3o de minter"
        );
        _mint(account, amount);
    }
}
