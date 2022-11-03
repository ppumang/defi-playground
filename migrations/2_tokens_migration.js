var Token0 = artifacts.require("Token0");
var Token1 = artifacts.require("Token1");
module.exports = function (deployer) {
  deployer.deploy(Token0, 100);
  deployer.deploy(Token1, 100);
};
