pragma solidity ^0.4.15;

import './lib/Ownable.sol';

/**
 * @title Upgradable
 * @dev Contracts inheriting from Upgradeable can have their contract function calls routed to a new contract when required
 * Contracts inheriting Upgradable should separate contract logic from data and data update logic so that an
 * upgraded contract can still use and update the old data state of the contract
 * The new upgraded deployed logic contract must have the same interface, but can add new interfaces
 */
contract Upgradable is Ownable {

  address public upgraded;

  event upgraded(address oldContract, address newContract);

  function Upgradable() public {
    upgraded = address(this);
  }

  /**
   * @dev Modifier that will use route the function to the upgraded function if
   * the contract has been upgraded
   */
   modifier upgradeable () {

       if (upgraded != address(this)) {
           upgraded.delegatecall(msg.data); //TODO: ensure that gas and Ether are passed on as well
           // TODO: how well will this work if upgraded contracts use different compilers???
       } else {
           // Execute as normal
           _;
       }
   }

   /**
    * @dev Updates the pointer to the contract logic pointer to the new upgraed contract
    *
    */
   function upgrade(address _upgraded) onlyOwner internal {
     require(_upgraded != address(0));
     // TODO: check that _upgradedContract is a contract...
     upgraded(upgraded, _upgraded);
     upgraded = _upgraded;
   }
}
