// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract VotingSystem {
    struct Candidate {
        string name;
        uint voteCount;
    }

    address public owner;
    bool public votingEnded;
    mapping(address => bool) public hasVoted;
    Candidate[] public candidates;

    event Voted(address indexed voter, uint indexed candidateIndex);
    event VotingEnded();

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier votingActive() {
        require(!votingEnded, "Voting has ended");
        _;
    }

    constructor(string[] memory candidateNames) {
        owner = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate(candidateNames[i], 0));
        }
    }

    function vote(uint candidateIndex) external votingActive {
        require(!hasVoted[msg.sender], "Already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount++;

        emit Voted(msg.sender, candidateIndex);
    }

    function endVoting() external onlyOwner votingActive {
        votingEnded = true;         
        emit VotingEnded();
    }

    function getCandidates() external view returns (Candidate[] memory) {
        return candidates;
    }
}
