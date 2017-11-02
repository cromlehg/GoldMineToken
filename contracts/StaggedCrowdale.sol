pragma solidity ^0.4.18;

import './CommonCrowdsale.sol';

contract StaggedCrowdale is CommonCrowdsale {

  uint public constant SALE_STEP = 5000000;

  uint public timeStep = 5 * 1 days;

  function setTimeStep(uint newTimeStep) public onlyOwner {
    timeStep = newTimeStep * 1 days;
  }

  function priceWithBonus() public constant returns(uint) {
    uint saleStage = now.sub(start).div(timeStep);
    uint saleSub = saleStage.mul(SALE_STEP);
    uint minSale = getMinPriceSale();
    uint maxSale = getMaxPriceSale();
    uint priceSale = maxSale;
    if(saleSub >= maxSale.sub(minSale)) {
      priceSale = minSale;
    } else {
      priceSale = maxSale.sub(saleSub);
    }
    return price.mul(PERCENT_RATE).div(PERCENT_RATE.sub(priceSale));
  }
  
  function getMinPriceSale() public constant returns(uint);
  
  function getMaxPriceSale() public constant returns(uint);

}
