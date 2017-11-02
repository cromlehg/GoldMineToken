pragma solidity ^0.4.18;

import './CommonCrowdsale.sol';

contract CrowdsaleWithNextSaleAgent is CommonCrowdsale {

  address public nextSaleAgent;

  function setNextSaleAgent(address newNextSaleAgent) public onlyOwner {
    nextSaleAgent = newNextSaleAgent;
  }

  function finishCrowdsale() public onlyOwner { 
    token.setSaleAgent(nextSaleAgent);
  }

}
