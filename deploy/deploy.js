// scripts/deploy.js

const hre = require("hardhat");

async function main() {
  // Get the contract factory
  const TodoList = await hre.ethers.getContractFactory("TodoList");

  // Deploy the contract
  const todoList = await TodoList.deploy();

  // Wait for deployment to finish
  await todoList.waitForDeployment();
  const todoListAddress = await todoList.getAddress();

  console.log("todoList deployed to:", todoListAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Error deploying contract:", error);
    process.exit(1);
  });
