pragma solidity 0.7.3;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./IFlashloanUser.sol";
import "./FlashloanProvider.sol";

contract FlashloanUser is IFlashloanUser{

    function startFlashloan(address flashloan, uint amount, address token) external {
        FlashloanProvider(flashloan).executeFlashloan(amount, address(this), token, bytes(''));

    }

    function flashloanCallback(address token, uint amount, bytes memory data) override external{
        //reimbure loan
        IERC20(token).transfer(msg.sender, amount);
    }

}