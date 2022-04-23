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

  /**
   * Here a  wave is send to see if the contract sends the ether of the function
   */
  let waveTxn = await waveContract.wave("A message!");
  await waveTxn.wait(); // Wait for the transaction to be mined

  // const [_, randomPerson] = await hre.ethers.getSigners();
  // waveTxn = await waveContract.connect(randomPerson).wave("Another message!");
  // await waveTxn.wait(); // Wait for the transaction to be mined

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
