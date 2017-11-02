pragma solidity ^0.4.18;

import './StaggedCrowdale.sol';

contract ICO is StaggedCrowdale {

  uint public constant MAX_PRICE_SALE = 40000000;

  uint public constant MIN_PRICE_SALE = 20000000;

  uint public constant ESCROW_TOKENS_PERCENT = 5000000;

  uint public constant FOUNDERS_TOKENS_PERCENT = 10000000;

  uint public lockPeriod = 250;

  address public foundersTokensWallet;

  address public escrowTokensWallet;

  uint public constant TOKENS_SOLD_LIMIT = 1250000000000;

  function tokensSoldLimit() public constant returns(uint) {
    return TOKENS_SOLD_LIMIT;
  }

  function setLockPeriod(uint newLockPeriod) public onlyOwner {
    lockPeriod = newLockPeriod;
  }

  function setFoundersTokensWallet(address newFoundersTokensWallet) public onlyOwner {
    foundersTokensWallet = newFoundersTokensWallet;
  }

  function setEscrowTokensWallet(address newEscrowTokensWallet) public onlyOwner {
    escrowTokensWallet = newEscrowTokensWallet;
  }

  function finishCrowdsale() public onlyOwner { 
    uint totalSupply = token.totalSupply();
    uint commonPercent = FOUNDERS_TOKENS_PERCENT + ESCROW_TOKENS_PERCENT;
    uint commonExtraTokens = totalSupply.mul(commonPercent).div(PERCENT_RATE.sub(commonPercent));
    if(commonExtraTokens > token.balanceOf(token)) {
      commonExtraTokens = token.balanceOf(token);
    }
    uint escrowTokens = commonExtraTokens.mul(FOUNDERS_TOKENS_PERCENT).div(PERCENT_RATE);
    token.crowdsaleTransfer(foundersTokensWallet, foundersTokens);

    uint foundersTokens = commonExtraTokens - escrowTokens;
    token.crowdsaleTransfer(escrowTokensWallet, escrowTokens);

    token.setRemainingLockDate(now + lockPeriod * 1 days);
    token.finishCrowdsale();
  }
  
  function getMinPriceSale() public constant returns(uint) {
    return MIN_PRICE_SALE;
  }
  
  function getMaxPriceSale() public constant returns(uint) {
    return MAX_PRICE_SALE;
  }

}
