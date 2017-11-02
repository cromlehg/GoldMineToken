pragma solidity ^0.4.18;

import './CrowdsaleWithNextSaleAgent.sol';

contract Presale is CrowdsaleWithNextSaleAgent {

  uint public constant PRICE_SALE = 60000000;

  uint public constant TOKENS_SOLD_LIMIT = 125000000000;

  function tokensSoldLimit() public constant returns(uint) {
    return TOKENS_SOLD_LIMIT;
  }
  
  function priceWithBonus() public constant returns(uint) {
    return price.mul(PERCENT_RATE).div(PERCENT_RATE.sub(PRICE_SALE));
  }

}
