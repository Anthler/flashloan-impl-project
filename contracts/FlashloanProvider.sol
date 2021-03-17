pragma solidity 0.7.3;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./IFlashloanUser.sol";

contract FlashloanProvider is ReentrancyGuard {

    mapping(address => IERC20) public tokens;
    constructor(address[] memory _tokens){
        for(uint i = 0; i < _tokens.length; i++){
            tokens[_tokens[i]] = IERC20(_tokens[i]);
        }
    }

    function executeFlashloan(uint amount, address token, address callback,  bytes memory data) nonReentrant() external {
        IERC20 token = tokens[token];
        uint originalBalance = token.balanceOf(address(this));
        require(address(token) != address(0));
        require(originalBalance >= amount);
        token.transfer(callback, amount);
        IFlashloanUser(callback).flashloanCallback(callback, amount, data);
        require(
            token.balanceOf(address(this)) == originalBalance,
            "Loan not reimburesed"
        );
    }
}