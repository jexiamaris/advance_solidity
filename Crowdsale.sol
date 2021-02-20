pragma solidity ^0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// @TODO: Inherit the crowdsale contracts
contract PupperCoinSale is  Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {

    constructor(
        // @TODO: Fill in the constructor parameters!
        uint rate,
        address payable wallet,
        PupperCoin token,
        uint goal,
        uint open,
        uint close
        ) 
        Crowdsale(rate, wallet, token)
        CappedCrowdsale(goal)
        TimedCrowdsale(open, close)
        RefundableCrowdsale(goal)
    
        // @TODO: Pass the constructor parameters to the crowdsale contracts.
        public {
        // constructor can stay empty
        }
}

contract PupperCoinSaleDeployer {

    address public tokenSaleAddress;
    address public tokenAddress;
    
    uint fakenow = now;

        function fastforward() public {
        fakenow += 100 days;
        }
    
    constructor(
        // @TODO: Fill in the constructor parameters!
        string memory name,
        string memory symbol,
        address payable wallet,
        uint goal
        ) 
        
        
        public{
        // @TODO: create the PupperCoin and keep its address handy
            PupperCoin token = new PupperCoin(name, symbol, 0);
            tokenAddress = address(token);
            
        // @TODO: create the PupperCoinSale and tell it about the token, set the goal, and set the open and close times to now and now + 24 weeks.
            
            PupperCoinSale tokenSale = new PupperCoinSale(1, wallet, token, goal, fakenow, fakenow + 5 minutes);
            tokenSaleAddress = address(tokenSale);
            
        // make the PupperCoinSale contract a minter, then have the PupperCoinSaleDeployer renounce its minter role
            token.addMinter(tokenSaleAddress);
            token.renounceMinter();
    }
}
