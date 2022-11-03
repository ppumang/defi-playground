var Pool = artifacts.require("Pool");
var User = artifacts.require("User");
module.exports = function (deployer) {
  deployer.deploy(Pool);
  deployer.deploy(User);
};
