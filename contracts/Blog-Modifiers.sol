// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Blog {

    address public owner = msg.sender;
    uint8 constant MAX_TITLE_LENGTH = 128;
    uint16 public MAX_CONTENT_LENGTH = 6000;

    struct Post {
        address author;
        string title;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Post[]) private posts; 

    modifier onlyOwner {
        require(owner == msg.sender, "Must be contract owner for this action");
        _;
    }

    function changeContentLength(uint16 _newContentLength) public onlyOwner {
        MAX_CONTENT_LENGTH = _newContentLength;
    }

    function createPost(string memory _title, string memory _content) public {
        require(bytes(_title).length <= MAX_TITLE_LENGTH, "Title too long");
        require(bytes(_content).length <= MAX_CONTENT_LENGTH, "Content too long");
        Post memory newPost = Post({
            author: msg.sender,
            title: _title,
            content: _content,
            timestamp: block.timestamp,
            likes: 0
        });

        posts[msg.sender].push(newPost);
    }

    function getPost(uint _i) public view returns (Post memory) {
        return posts[msg.sender][_i];
    }

    function getAllPosts(address _owner) public view returns (Post[] memory) {
        return posts[_owner];
    } 
}