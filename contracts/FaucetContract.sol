 // SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./Owned.sol";
import "./Logger.sol";
import "./iFaucet.sol";

contract Faucet is Owned, Logger, iFaucet{
 uint public numOfFunders;
  mapping(address => bool) private funders;
  mapping(uint => address) private lutFunders;

  receive() external payable {}

  function emitLog() public override pure returns(bytes32){
    return "Hello world";
  }

  function addFunds() override external payable {
    address funder = msg.sender;

    if (!funders[funder]) {
      numOfFunders++;
      uint index = numOfFunders++;
      funders[funder] = true;
      lutFunders[index] = funder;
    }
  }

function withdraw(uint _withdrawAmount) override external onlyOwner {
  require(_withdrawAmount == 1 ether, "please, try with 1 ether or less");
  payable(msg.sender).transfer(_withdrawAmount);
  }



  function getAllFunders() external view returns (address[] memory) {
    address[] memory _funders = new address[](numOfFunders);

    for (uint i = 0; i < numOfFunders; i++) {
      _funders[i] = lutFunders[i];
    }

    return _funders;
  }

  function getFunderAtIndex(uint8 index) external view returns(address) {
    return lutFunders[index];
  }



     
}

//const instance = await Faucet.deployed()
// instance.addFunds({from: accounts[0], value: "2000000000000000000"})
// instance.withdraw("500000000000000000", {from: accounts[1]})
// instance.getFunderAtIndex(0)
// instance.getAllFunders()