pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import 'zeppelin-solidity/contracts/token/StandardToken.sol';

contract GoldMineCoin is StandardToken, Ownable {	
    
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  uint public constant INITIAL_SUPPLY = 2500000000000;

  uint public constant BOUNTY_TOKENS_LIMIT = 125000000000;

  string public constant name = "GoldMineCoin";
   
  string public constant symbol = "GMC";
    
  uint32 public constant decimals = 6;

  uint public bountyTokensTransferred;

  address public saleAgent;
  
  bool public isCrowdsaleFinished;

  uint public remainingLockDate;
  
  mapping(address => uint) public locks;

  modifier notLocked(address from) {
    require(isCrowdsaleFinished || (locks[from] !=0 && now >= locks[from]));
    _;
  }

  function GoldMineCoin() public {
    totalSupply = INITIAL_SUPPLY;
    balances[this] = totalSupply;
  }
  
  function addRestricedAccount(address restricedAccount, uint unlockedDate) public {
    require(!isCrowdsaleFinished);    
    require(msg.sender == saleAgent || msg.sender == owner);
    locks[restricedAccount] = unlockedDate;
  }

  function transferFrom(address _from, address _to, uint256 _value) public notLocked(_from) returns (bool) {
    super.transferFrom(_from, _to, _value);
  }

  function transfer(address _to, uint256 _value) public notLocked(msg.sender) returns (bool) {
    super.transfer(_to, _value);
  }

  function crowdsaleTransfer(address to, uint amount) public {
    require(msg.sender == saleAgent || msg.sender == owner);
    require(!isCrowdsaleFinished || now >= remainingLockDate);
    require(amount <= balances[this]);
    balances[this] = balances[this].sub(amount);
    balances[to] = balances[to].add(amount);
    Transfer(this, to, amount);
  }

  function addBountyTransferredTokens(uint amount) public {
    require(!isCrowdsaleFinished);
    require(msg.sender == saleAgent);
    bountyTokensTransferred = bountyTokensTransferred.add(amount);
  }

  function setSaleAgent(address newSaleAgent) public {
    require(!isCrowdsaleFinished);
    require(msg.sender == owner|| msg.sender == saleAgent);
    require(newSaleAgent != address(0));
    saleAgent = newSaleAgent;
  }
  
  function setRemainingLockDate(uint newRemainingLockDate) public {
    require(!isCrowdsaleFinished && msg.sender == saleAgent); 
    remainingLockDate = newRemainingLockDate;
  }

  function finishCrowdsale() public {
    require(msg.sender == saleAgent || msg.sender == owner);
    isCrowdsaleFinished = true;
  }

}

