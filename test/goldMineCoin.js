
import ether from './helpers/ether'
import {advanceBlock} from './helpers/advanceToBlock'
import {increaseTimeTo, duration} from './helpers/increaseTime'
import latestTime from './helpers/latestTime'
import EVMThrow from './helpers/EVMThrow'

const BigNumber = web3.BigNumber

const should = require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(BigNumber))
  .should()

const GoldMineCoin = artifacts.require('GoldMineCoin')

contract('GoldMineCoin', function(wallets) {

  const notOwner = wallets[1]
  
  const newAddr = wallets[2]
  
  before(async function() {
    //Advance to the next block to correctly read time in the solidity "now" function interpreted by testrpc
    await advanceBlock()
  })
  
  beforeEach(async function () {
    this.goldMineCoin = await GoldMineCoin.new()
  })	 
  
  describe('not owner reject tests', function () {

      it('addRestricedAccount reject if not owner', async function () {
        await this.goldMineCoin.addRestricedAccount(newAddr, 1, {from: notOwner}).should.be.rejectedWith(EVMThrow)
      })

      it('transferFrom reject if not owner', async function () {
        await this.goldMineCoin.transferFrom(newAddr, newAddr, 1, {from: notOwner}).should.be.rejectedWith(EVMThrow)
      })

      it('transfer reject if not owner', async function () {
        await this.goldMineCoin.transfer(newAddr, 1, {from: notOwner}).should.be.rejectedWith(EVMThrow)
      })

      it('crowdsaleTransfer reject if not owner', async function () {
        await this.goldMineCoin.crowdsaleTransfer(newAddr, 1, {from: notOwner}).should.be.rejectedWith(EVMThrow)
      })

      it('addBountyTransferredTokens reject if not owner', async function () {
        await this.goldMineCoin.addBountyTransferredTokens(1, {from: notOwner}).should.be.rejectedWith(EVMThrow)
      })

      it('setSaleAgent reject if not owner', async function () {
        await this.goldMineCoin.setSaleAgent(newAddr, {from: notOwner}).should.be.rejectedWith(EVMThrow)
      })

      it('setRemainingLockDate reject if not owner', async function () {
        await this.goldMineCoin.setRemainingLockDate(1, {from: notOwner}).should.be.rejectedWith(EVMThrow)
      })

      it('finishCrowdsale reject if not owner', async function () {
        await this.goldMineCoin.finishCrowdsale({from: notOwner}).should.be.rejectedWith(EVMThrow)
      })

  })

})
