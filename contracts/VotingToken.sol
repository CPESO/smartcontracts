// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract VotingToken is ERC20, Ownable {
    struct Vote {
        string[] options;
        uint256 startTime;
        uint256 endTime;
        bool isActive;
        bool isPaused; // 투표 일시 중지 상태 추가
        uint256 rewardAmount;  // 투표에 대한 보상 CPV 개수
        mapping(string => uint256) optionVotes;
        mapping(address => bool) hasVoted;
    }

    uint256 public voteCounter; // 투표 ID 생성용 카운터
    mapping(uint256 => Vote) public votes; // 여러 투표를 관리하는 매핑
    mapping(address => bool) public voterAdmins; // 투표 생성 권한을 가진 관리자 목록

    // 트러스트된 포워더 주소 (수수료를 대신 지불할 주소)
    address public trustedForwarder;
    uint256 public maxRewardAmount = 1000 * 10 ** decimals(); // 최대 보상 한도 설정

    // 생성자에서 기본 오너를 설정하고 초기 공급량을 분배합니다.
    constructor(address initialOwner) ERC20("CPESO VOTE", "CPV") Ownable(initialOwner) {
        uint256 initialSupply = 1_000_000_000 * 10 ** decimals(); // 초기 발행량: 10억 개
        _mint(initialOwner, initialSupply); // 초기 발행
        voterAdmins[initialOwner] = true; // 오너를 기본 관리자에 포함
    }

    // 포워더 설정 (오직 오너만 가능)
    function setTrustedForwarder(address _forwarder) external onlyOwner {
        require(_forwarder != address(0), "Invalid forwarder address"); // 유효한 주소인지 확인
        trustedForwarder = _forwarder;
    }

    // 관리자 추가 함수 (오직 오너만 가능)
    function addVoterAdmin(address _admin) external onlyOwner {
        voterAdmins[_admin] = true;
    }

    // 관리자 삭제 함수 (오직 오너만 가능)
    function removeVoterAdmin(address _admin) external onlyOwner {
        require(_admin != owner(), "Owner cannot be removed from admins.");
        voterAdmins[_admin] = false;
    }

    // 새로운 투표 생성 (관리자만 가능)
    function createVote(string[] memory _options, uint256 _duration, uint256 _rewardAmount) external {
        require(voterAdmins[_msgSender()], "Only admins can create a vote.");
        require(_rewardAmount <= maxRewardAmount, "Reward amount exceeds maximum allowed."); // 보상 한도 검사

        voteCounter++; // 새로운 투표 ID 생성
        Vote storage newVote = votes[voteCounter];
        newVote.options = _options;
        newVote.startTime = block.timestamp;
        newVote.endTime = block.timestamp + _duration;
        newVote.isActive = true;
        newVote.isPaused = false; // 초기 상태는 일시 중지되지 않음
        newVote.rewardAmount = _rewardAmount;
    }

    // 특정 투표에 참여 (메타 트랜잭션 사용 가능)
    function vote(uint256 _voteId, string memory _option) external {
        Vote storage selectedVote = votes[_voteId];
        require(selectedVote.isActive, "This vote is not active.");
        require(!selectedVote.isPaused, "This vote is paused."); // 투표가 일시 중지된 경우 확인
        require(block.timestamp < selectedVote.endTime, "Voting period has ended.");
        require(!selectedVote.hasVoted[_msgSender()], "You have already voted in this poll.");

        bool validOption = false;
        for (uint i = 0; i < selectedVote.options.length; i++) {
            if (keccak256(abi.encodePacked(selectedVote.options[i])) == keccak256(abi.encodePacked(_option))) {
                validOption = true;
                break;
            }
        }
        require(validOption, "Invalid voting option.");

        // 투표 완료 처리
        selectedVote.optionVotes[_option]++;
        selectedVote.hasVoted[_msgSender()] = true;

        // 보상 지급
        _mint(_msgSender(), selectedVote.rewardAmount);
    }

    // 트러스트된 포워더로부터 호출을 처리
    function _msgSender() internal view override returns (address sender) {
        if (msg.sender == trustedForwarder) {
            assembly {
                sender := shr(96, calldataload(sub(calldatasize(), 20)))
            }
        } else {
            sender = msg.sender;
        }
    }

    // 특정 투표 종료 (오직 오너만 가능)
    function endVote(uint256 _voteId) external onlyOwner {
        Vote storage selectedVote = votes[_voteId];
        require(selectedVote.isActive, "This vote is not active.");
        require(block.timestamp >= selectedVote.endTime, "Voting period is not over yet.");

        selectedVote.isActive = false;
    }

    // 특정 투표 일시 중지 (오직 오너만 가능)
    function pauseVote(uint256 _voteId) external onlyOwner {
        Vote storage selectedVote = votes[_voteId];
        require(selectedVote.isActive, "This vote is not active.");
        selectedVote.isPaused = true; // 투표를 일시 중지
    }

    // 특정 투표 재개 (오직 오너만 가능)
    function resumeVote(uint256 _voteId) external onlyOwner {
        Vote storage selectedVote = votes[_voteId];
        require(selectedVote.isActive, "This vote is not active.");
        selectedVote.isPaused = false; // 투표를 재개
    }

    // 특정 투표 결과 조회
    function getVoteResults(uint256 _voteId, string memory _option) external view returns (uint256) {
        require(!votes[_voteId].isActive, "Vote is still ongoing.");
        return votes[_voteId].optionVotes[_option];
    }
}
