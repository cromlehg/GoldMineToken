pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import './GoldMineCoin.sol';

contract CommonCrowdsale is Ownable {

  using SafeMath for uint256;

  uint public price = 75000000;

  uint public constant MIN_INVESTED_ETH = 100000000000000000;

  uint public constant PERCENT_RATE = 100000000;
                                     
  uint public constant BOUNTY_PERCENT = 1666667;

  uint public constant REFERER_PERCENT = 500000;

  address public bountyWallet;

  address public wallet;

  uint public start;

  uint public period;

  uint public tokensSold;
  
  bool isBountyRestriced;

  GoldMineCoin public token;

  modifier saleIsOn() {
    require(now >= start && now < end() && msg.value >= MIN_INVESTED_ETH);
    require(tokensSold < tokensSoldLimit());
    _;
  }
  
  function tokensSoldLimit() public constant returns(uint);

  function end() public constant returns(uint) {
    return start + period * 1 days;
  }

  function setBountyWallet(address newBountyWallet) public onlyOwner {
    bountyWallet = newBountyWallet;
  }

  function setPrice(uint newPrice) public onlyOwner {
    price = newPrice;
  }

  function setToken(address newToken) public onlyOwner {
    token = GoldMineCoin(newToken);
  }

  function setStart(uint newStart) public onlyOwner {
    start = newStart;
  }

  function setPeriod(uint newPeriod) public onlyOwner {
    require(bountyWallet != address(0));
    period = newPeriod;
    if(isBountyRestriced) {
      token.addRestricedAccount(bountyWallet, end());
    }
  }

  function setWallet(address newWallet) public onlyOwner {
    wallet = newWallet;
  }

  function priceWithBonus() public constant returns(uint);
  
  function buyTokens() public payable saleIsOn {

    wallet.transfer(msg.value);

    uint tokens = msg.value.mul(priceWithBonus()).div(1 ether);
    
    token.crowdsaleTransfer(msg.sender, tokens);
    tokensSold = tokensSold.add(tokens);

    // referer tokens
    if(msg.data.length == 20) {
      address referer = bytesToAddres(bytes(msg.data));
      require(referer != address(token) && referer != msg.sender);
      uint refererTokens = tokens.mul(REFERER_PERCENT).div(PERCENT_RATE);
      token.crowdsaleTransfer(referer, refererTokens);
      tokens.add(refererTokens);
      tokensSold = tokensSold.add(refererTokens);
    }

    // bounty tokens
    if(token.bountyTokensTransferred() < token.BOUNTY_TOKENS_LIMIT()) {
      uint bountyTokens = tokens.mul(BOUNTY_PERCENT).div(PERCENT_RATE);
      uint diff = token.BOUNTY_TOKENS_LIMIT().sub(token.bountyTokensTransferred());
      if(bountyTokens > diff) {
        bountyTokens = diff;
      }      
      if(!isBountyRestriced) {
        token.addRestricedAccount(bountyWallet, end());  
        isBountyRestriced = true;
      }
      token.crowdsaleTransfer(bountyWallet, bountyTokens);
    }
  }

  function bytesToAddres(bytes source) internal pure returns(address) {
    uint result;
    uint mul = 1;
    for(uint i = 20; i > 0; i--) {
      result += uint8(source[i-1])*mul;
      mul = mul*256;
    }
    return address(result);
  }

  function retrieveTokens(address anotherToken) public onlyOwner {
    ERC20 alienToken = ERC20(anotherToken);
    alienToken.transfer(wallet, token.balanceOf(this));
  }

  function() external payable {
    buyTokens();
  }

}

