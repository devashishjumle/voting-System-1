const hre = require("hardhat");

async function main() {
  const VotingSystem = await hre.ethers.getContractFactory("VotingSystem");
  const candidates = ["Alice", "Bob", "Charlie"]; // Initial candidate names
  const voting = await VotingSystem.deploy(candidates);

  await voting.deployed();

  console.log("VotingSystem deployed to:", voting.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
