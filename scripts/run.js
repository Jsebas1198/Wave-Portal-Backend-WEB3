const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await waveContract.deployed();
  console.log("Contract address:", waveContract.address);
  /*** 
  Check the balance of the contract
*/
  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  /*
   * Let's try two waves now
   */
  const waveTxn = await waveContract.wave("This is wave #1");
  await waveTxn.wait();

  // const waveTxn2 = await waveContract.wave("This is wave #2");
  // await waveTxn2.wait();

  const [_, randomPerson] = await hre.ethers.getSigners();
  const waveTxn2 = await waveContract
    .connect(randomPerson)
    .wave("Another message!");
  await waveTxn2.wait(); // Wait for the transaction to be mined

  /*** 
  Check the balance of the contract after the transaction
*/
  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    "contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let waveCount;
  waveCount = await waveContract.getTotalWaves();
  console.log("The total number of waves made are: ", waveCount.toNumber());

  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);

  // let getAdressWaves = await waveContract.getAdressWaves(_.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
