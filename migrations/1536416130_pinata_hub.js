const PinataHub = artifacts.require("./PinataHub.sol");

module.exports = function(deployer) {
  deployer.deploy(PinataHub);
};
