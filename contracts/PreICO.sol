pragma solidity ^0.4.18;

import './CrowdsaleWithNextSaleAgent.sol';
import './StaggedCrowdale.sol';

contract PreICO is StaggedCrowdale, CrowdsaleWithNextSaleAgent {

  uint public constant MAX_PRICE_SALE = 55000000;

  uint public constant MIN_PRICE_SALE = 40000000;

  uint public constant TOKENS_SOLD_LIMIT = 625000000000;

  function tokensSoldLimit() public constant returns(uint) {
    return TOKENS_SOLD_LIMIT;
  }
  
  function getMinPriceSale() public constant returns(uint) {
    return MIN_PRICE_SALE;
  }
  
  function getMaxPriceSale() public constant returns(uint) {
    return MAX_PRICE_SALE;
  }

}
