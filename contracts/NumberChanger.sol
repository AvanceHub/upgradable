pragma solidity ^0.4.15;

import './Upgradable.sol';
import './lib/Ownable.sol';

contract NumberChanger {

  uint public myNumber;

  function changeNumber() public {
    myNumber += 1;
  }
}

contract UpgradableNumberChanger_Logic is Upgradable {

  // No state information here at all

  UpgradableNumberChanger_State public state;

  function UpgradableNumberChanger_Logic() {
    state = new UpgradableNumberChanger_State();
  }

  function changeNumber() public {
    state.setMyNumber(state.myNumber() + 1);
  }

  function transferStateOwnership(address newOwner) onlyOwner public {
    require(newOwner != address(0));
    state.transferOwnership(newOwner);
  }
}

contract UpgradableNumberChanger_State is Ownable {

  // All state is in separate contract with setters and getters for ALL functions

  uint public myNumber;

  function setMyNumber(uint number) onlyOwner public {
    myNumber = number;
  }

  function kill() onlyOwner public {
    suicide(owner);
  }

}
