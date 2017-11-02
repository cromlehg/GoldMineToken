pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import './GoldMineCoin.sol';
import './Presale.sol';
import './PreICO.sol';
import './ICO.sol';

contract Configurator is Ownable {

  GoldMineCoin public token;

  Presale public presale;
  
  PreICO public preICO;
  
  ICO public ico;

  function deploy() public onlyOwner {
    token = new GoldMineCoin();

    presale = new Presale();
    presale.setToken(token);
    token.setSaleAgent(presale);
    
    // fix
    presale.setBountyWallet(0x6FB77f2878A33ef21aadde868E84Ba66105a3E9c);
    presale.setWallet(0x2d664D31f3AF6aD256A62fdb72E704ab0De42619);
    presale.setStart(1508850000);
    presale.setPeriod(35);

    preICO = new PreICO();
    preICO.setToken(token);
    presale.setNextSaleAgent(preICO);
    
    // fix
    preICO.setTimeStep(5);
    preICO.setBountyWallet(0x4ca3a7788A61590722A7AAb3b79E8b4DfDDf9559);
    preICO.setWallet(0x2d664D31f3AF6aD256A62fdb72E704ab0De42619);
    preICO.setStart(1511182800);
    preICO.setPeriod(24);
    
    ico = new ICO();
    ico.setToken(token);
    preICO.setNextSaleAgent(ico);
    
    // fix
    ico.setTimeStep(5);
    ico.setLockPeriod(250);
    ico.setBountyWallet(0x7cfe25bdd334cdB46Ae0c4996E7D34F95DFFfdD1);
    ico.setEscrowTokensWallet(0x24D225818a19c75694FCB35297cA2f23E0bd8F82);
    ico.setFoundersTokensWallet(0x54540fC0e7cCc29d1c93AD7501761d6b232d5b03);
    ico.setWallet(0x2d664D31f3AF6aD256A62fdb72E704ab0De42619);
    ico.setStart(1513515600);
    ico.setPeriod(32);

    token.transferOwnership(0xE8910a2C39Ef0405A9960eC4bD8CBA3211e3C796);
    presale.transferOwnership(0xE8910a2C39Ef0405A9960eC4bD8CBA3211e3C796);
    preICO.transferOwnership(0xE8910a2C39Ef0405A9960eC4bD8CBA3211e3C796);
    ico.transferOwnership(0xE8910a2C39Ef0405A9960eC4bD8CBA3211e3C796);
  }

}
