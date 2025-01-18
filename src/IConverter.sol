pragma solidity 0.8.13;


interface IConverter {
    event LogConvert(
        address indexed server,
        address indexed token0,
        uint256 amount0,
        uint256 amountBOO
    );
}