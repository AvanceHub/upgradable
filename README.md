# Upgradeable contract

Separates the logic of a contract from the data of the contact into two separate contracts:
* The Logic contract has the logic of the contract and a pointer to the latest version of the contract logic which is set to itself when the contract is constructed
* The State contract contains all the state variables and setters and getters of those variables and nothing else, the Logic contract is set as the owner and is the only contract that is able to update the state.

When upgrading the contract:
1. Deploy a new Logic contract
2. Deploy a new State contract if new state data or changed state structure is wanted (optional)
3. Point old Logic contracts to the latest Logic contract
4. Point old State contracts to the latest Logic contract

See graphical representation of upgradable mechanism: [Google Slides](https://docs.google.com/presentation/d/1veuPxAQD88z5holb-6SjWLhyDABuzNeVPZpZvzemJ3A/edit?usp=sharing)

----

Drawbacks:
* Complexity
* Logic contract cannot change ABI and be backwards compatible
* Gas costs of state read costs are increased significantly while state writes are increased mildly

TODO:
* Investigate the mechanisms ability to handle upgrades of events
* Investigate the use of a pointer to reduce gas costs

This upgradable mechanism is under development and has not been properly tested.
