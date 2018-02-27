<p align="center">
  <h1> Gold Mine Coin</h1>
  <img src="./logo.png">
</p>


* _Standart_        : ERC20
* _Name_            : GoldMineCoin
* _Ticket_          : GMC
* _Decimals_        : 6
* _Emission_        : Fixed
* _Unsold tokens_   : Not burn. Locked for 250 days
* _Total tokens_    : 2500000
* _Crowdsales_      : 3
* _Fiat dependency_ : No
* _Tokens locked_   : Yes

## Smart-contracts description

Contract transfer bounty during each stage. 
Contract transfer escrow, foduners after last stage. 
Crowdsale contracts have special function to retrieve transferred in errors tokens.
Bounty wallets unlocked after each crowdsale finished.

### Contracts contains
1. _GoldMineCoin_ 
2. _Presale_
3. _PreICO_
4. _ICO_
5. _Configurator_ - contract with main configuration for production

### How to manage contract
To start working with contract you should follow next steps:
1. Compile Configurator contract in Remix with enable optimization flag and compiler 0.4.18
2. Deploy bytecode with MyEtherWallet. 
3. Call 'deploy' function on addres from (3).

All coins from all stages transferred to special eth wallet, which specified in presale configuration.

After each crowdsale stage contract manager must call finishMinting. 

Manager can change price by calling setPrice in corresponding crowdsale stage contract.

### How to invest
To purchase tokens investor should send ETH (more than minimum 0.1 EHT) to corresponding crowdsale contract.
Recommended GAS: 250000, GAS PRICE - 21 Gwei.

### Wallets with ERC20 support
1. MyEtherWallet - https://www.myetherwallet.com/
2. Parity 
3. Mist/Ethereum wallet

EXODUS not support ERC20, but have way to export key into MyEtherWallet - http://support.exodus.io/article/128-how-do-i-receive-unsupported-erc20-tokens

Investor must not use other wallets, coinmarkets or stocks. Can lose money.

## Main network configuration

* _Base price_                 : 75 GMC per ETH
* _Minimal insvested limit_    : 0.1 ETH

### Links
* _Token_ - https://etherscan.io/token/0x8c4fee70f1bf190af52cc05f0a76a1ee035eec18#readContract
* _Presale_ - https://etherscan.io/address/0x21847ee0c0518f21f15bbaccb38c40c6399c9b09#readContract
* _Pre-ICO_ - https://etherscan.io/address/0x425591f4b6c775cc741bfb2d003c2fa736ba25c3#readContract
* _ICO_ - https://etherscan.io/address/0xba0bb748f4fa26cf95e5c74369b558c0a236f466#readContract

### Crowdsale stages

#### Presale
* _Hardcap_                    : 125000 GMC
* _Bounty_                     : 5/3% ~ 1666667% of total tokens
* _Start_                      : Thu, 01 Mar 2018 00:00:00 GMT 
* _Period_                     : 20 days
* _Bounty tokens wallet_       : 0x6FB77f2878A33ef21aadde868E84Ba66105a3E9c
* _Contract manager_           : 0xE8910a2C39Ef0405A9960eC4bD8CBA3211e3C796
* _ETH Wallets_                : 0x2d664D31f3AF6aD256A62fdb72E704ab0De42619

_Milestones_

1. all                         : 60% off price

#### PreICO
* _Hardcap_                    : 625000 GMC
* _Bounty_                     : 5/3% ~ 1666667% of total tokens
* _Start_                      : Tue, 20 Mar 2018 00:00:00 GMT
* _Period_                     : 40 days
* _Bounty tokens wallet_       : 0x4ca3a7788A61590722A7AAb3b79E8b4DfDDf9559
* _Contract manager_           : 0xE8910a2C39Ef0405A9960eC4bD8CBA3211e3C796
* _ETH Wallets_                : 0x2d664D31f3AF6aD256A62fdb72E704ab0De42619

_Milestones_

1. 5 days                      : 55% off price
2. 5 days                      : 50% off price
3. 5 days                      : 45% off price
4. other                       : 40% off price

#### ICO
* _Hardcap_                    : 1250000 GMC
* _Bounty_                     : 5/3% ~ 1666667% of total tokens
* _Founders_                   : 10% of total tokens
* _Escrow_                     : 5% of total tokens
* _Start_                      : Tue, 01 May 2018 00:00:00 GMT
* _Period_                     : 60 days
* _Bounty tokens wallet_       : 0x7cfe25bdd334cdB46Ae0c4996E7D34F95DFFfdD1
* _Foduners tokens wallet_     : 0x54540fC0e7cCc29d1c93AD7501761d6b232d5b03
* _Escrow tokens wallet_       : 0x24D225818a19c75694FCB35297cA2f23E0bd8F82
* _Contract manager_           : 0xE8910a2C39Ef0405A9960eC4bD8CBA3211e3C796
* _ETH Wallets_                : 0x2d664D31f3AF6aD256A62fdb72E704ab0De42619

_Milestones_

1. 5 days                      : 40% off price
2. 5 days                      : 35% off price
3. 5 days                      : 30% off price
3. 5 days                      : 25% off price
4. other                       : 20% off price



