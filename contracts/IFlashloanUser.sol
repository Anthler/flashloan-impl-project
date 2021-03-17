pragma solidity 0.7.3;

interface IFlashloanUser {
    function flashloanCallback(address token, uint amount, bytes memory data) external;
}