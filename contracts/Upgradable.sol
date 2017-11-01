pragma solidity ^0.4.15;

import './lib/Ownable.sol';

/**
 * @title Upgradable
 * @dev Contracts inheriting from Upgradeable can have their contract function calls routed to a new contract
 * if the contract is upgraded
 */
contract Upgradable is Ownable {

  address public upgradedContract;

  function Upgradable() public {
    upgradedContract = address(this);
  }

  /**
   * Uses the current contract function if no upgrade has been set (through ENS)
   * If an upgrade has been set, send the call to the new function
   * The upgraded function must have the same interface
   * Once upgraded, only the upgraded contract can access the old contract's methods
   */
   modifier upgradeable () {

       if (upgradedContract != address(this)) {
           upgradedContract.delegatecall(msg.data); //TODO: ensure that gas and Ether are passed on as well
       } else {
           // Execute as normal
           _;
       }
   }

   function upgradeContract(address _upgradedContract) public {
     upgradedContract = _upgradedContract;
   }
}
