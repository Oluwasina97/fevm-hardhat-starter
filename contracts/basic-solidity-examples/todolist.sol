// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TodoList {
    address public owner;
    uint public taskCount = 0;
    uint public constant MAX_TASKS = 5;

    struct Task {
        uint id;
        string content;
        bool completed;
    }

    mapping(uint => Task) public tasks;

    constructor() {
        owner = msg.sender;
    }

    function createTask(string memory _content) public {
        require(msg.sender == owner, "Only owner can add tasks");
        require(taskCount < MAX_TASKS, "Max task limit reached");

        taskCount++;
        tasks[taskCount] = Task(taskCount, _content, false);
    }

    function toggleTask(uint _id) public {
        require(msg.sender == owner, "Only owner can toggle tasks");
        require(_id > 0 && _id <= taskCount, "Invalid task ID");

        Task storage task = tasks[_id];
        task.completed = !task.completed;
    }

    function getTask(uint _id) public view returns (string memory, bool) {
        require(_id > 0 && _id <= taskCount, "Invalid task ID");
        Task memory task = tasks[_id];
        return (task.content, task.completed);
    }

    function getAllTasks() public view returns (Task[] memory) {
        Task[] memory allTasks = new Task[](taskCount);
        for (uint i = 1; i <= taskCount; i++) {
            allTasks[i - 1] = tasks[i];
        }
        return allTasks;
    }
}