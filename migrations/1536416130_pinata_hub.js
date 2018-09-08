const PinataHub = artifacts.require("./PinataHub.sol");
const ExampleContract = artifacts.require("./ExampleContract.sol");

module.exports = function(deployer) {
  deployer.deploy(PinataHub);
  deployer.deploy(ExampleContract);
};
