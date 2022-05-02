// my cryptocurrency ICO

//version of compiler
pragma solidity ^0.8.7;

contract cryptocurrency_ico {
    // The maximum number of cryptocurrency available for sale
    uint256 public max_cryptocurrency = 1000000;

    // Introducing the USD to cryptocurrency conversion rate
    uint256 public usd_to_cryptocurrency = 1000;

    // Introducing the total number of cryptocurrency that have been bougth by the investors
    uint256 public total_cryptocurrency_bougth = 0;

    // Mapping from the investor address to its equity in cryptocurrency and USD
    mapping(address => uint256) equity_cryptocurrency;
    mapping(address => uint256) equity_usd;

    // Checking if an investor can buy cryptocurrency
    modifier can_buy_criptocurrency(uint256 usd_invested) {
        require(
            usd_invested *
                usd_to_cryptocurrency +
                total_cryptocurrency_bougth <=
                max_cryptocurrency
        );
        _;
    }

    // Getting the equity in of an investor
    function equity_in_cryptocurrency(address investor)
        external
        returns (uint256)
    {
        return equity_cryptocurrency[investor];
    }

    // Getting the equity in of an investor
    function equity_in_usd(address investor) external returns (uint256) {
        return equity_usd[investor];
    }

    // Buying cryptocurrency
    function buy_cryptocurrency(address investor, uint256 usd_invested)
        external
        can_buy_criptocurrency(usd_invested)
    {
        uint256 cryptocurrency_bought = usd_invested * usd_to_cryptocurrency;
        equity_cryptocurrency[investor] += cryptocurrency_bought;
        equity_usd[investor] = equity_cryptocurrency[investor] / 1000;
        total_cryptocurrency_bougth += cryptocurrency_bought;
    }

    // Selling cryptocurrency
    function sell_cryptocurrency(address investor, uint256 cryptocurrency_sold)
        external
    {
        equity_cryptocurrency[investor] -= cryptocurrency_sold;
        equity_usd[investor] = equity_cryptocurrency[investor] / 1000;
        total_cryptocurrency_bougth -= cryptocurrency_sold;
    }
}
