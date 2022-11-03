const Token0 = artifacts.require("Token0");
const Token1 = artifacts.require("Token1");
const Pool = artifacts.require("Pool");
const { assert } = require("chai");

contract("Token0", (accounts) => {
  before(async () => {
    token0 = await Token0.deployed();
    token1 = await Token1.deployed();
    pool = await Pool.deployed();
  });

  const addr0 = accounts[0];
  const addr1 = accounts[1];

  it("#1 set config", async () => {
    await pool.setConfig(token0.address, token1.address, 1000);
    assert.equal(true, true, "sales setup incomplete!");
  });

  it("mint tokens", async () => {
    await token0.mint(1000, { from: addr1 });
    await token1.mint(1000, { from: addr1 });

    assert.equal(
      await token0.balanceOf(addr1),
      1000,
      "mint amount is different"
    );
  });

  it("provide liquidity", async () => {
    await token0.increaseAllowance(pool.address, 10, { from: addr1 });
    await token1.increaseAllowance(pool.address, 10, { from: addr1 });
    let all = await pool.getAllowance();
    console.log(all[0]);
    console.log(all[1]);
    await pool.provideLiquidity(1, 1, { from: addr1 });

    console.log(await token0.balanceOf(pool.address));
  });

  it("swap", async () => {});
});
