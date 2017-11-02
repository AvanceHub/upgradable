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

  UpgradableNumberChanger_State public state;

  function UpgradableNumberChanger_Logic() public {
    state = new UpgradableNumberChanger_State();
  }

  function changeNumber() upgradeable public {
    state.setMyNumber(state.myNumber() + 1);
  }

  function getNumber() constant public returns (uint) {
      return state.myNumber();
  }

  function upgradeContract(address newOwner) onlyOwner public {
    require(newOwner != address(0));
    // TODO: check that newOwner is a contract...
    state.transferOwnership(newOwner);
    upgrade(newOwner);
  }
}

contract NewUpgradableNumberChanger_Logic is Upgradable {

  UpgradableNumberChanger_State public state;

  function NewUpgradableNumberChanger_Logic(address _state) public {
    state = UpgradableNumberChanger_State(_state);
  }

  function changeNumber() upgradeable public {
    state.setMyNumber(state.myNumber() + 2); // We have updated the logic of the contract
  }

  function getNumber() constant public returns (uint) {
      return state.myNumber();
  }

  function transferStateOwnership(address newOwner) onlyOwner public {
    require(newOwner != address(0));
    // TODO: check that newOwner is a contract...
    state.transferOwnership(newOwner);
    upgrade(newOwner);
  }
}

contract UpgradableNumberChanger_State is Ownable {

  // All state is in separate contract with setters and getters for ALL functions
  // All setter functions have onlyOwner modifier

  uint public myNumber;

  function setMyNumber(uint number) onlyOwner public {
    myNumber = number;
  }

  function kill() onlyOwner public {
    selfdestruct(owner);
  }

}
