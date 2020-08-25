pragma solidity ^0.5.0;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol';
import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';
import './Strings.sol';

contract Loopbomb is Ownable, ERC721Full {
    event LoopbombCreated(uint id, address author);

    string public name = "Loopbomb";
    string public symbol = "LOOP";
    string baseTokenUri = "https://loopbomb.com/assets/api/v1/loop/1/";
    uint256 mintPrice = 5000000000000000;

    struct Loopbomb {
        address author;
        uint256 date;
    }

    Loopbomb[] public loopbombs;

    constructor() ERC721Full(name, symbol) public { }

    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        return Strings.strConcat(
            baseTokenURI(),
            Strings.uint2str(_tokenId)
        );
    }

    // Management methods
    function create() public payable returns (uint) {
        require(msg.value >= mintPrice, "Not enough ether to mint this token!");

        if (msg.value > mintPrice) {
            msg.sender.transfer(msg.value - mintPrice);
        }

        uint id = loopbombs.push(Loopbomb(msg.sender, block.timestamp)) - 1;
        _mint(msg.sender, id);
        emit LoopbombCreated(id, msg.sender);
        return id;
    }

    function retrieve(uint256 _id) public view  returns (address, uint256) {
        return (loopbombs[_id].author, loopbombs[_id].date);
    }

    function setBaseTokenURI(string memory _uri) public onlyOwner {
        baseTokenUri = _uri;
    }

    function withdraw() external onlyOwner {
        msg.sender.transfer(address(this).balance);
    }

    function setMintPrice(uint256 _price) external onlyOwner {
        mintPrice = _price;
    }

    function baseTokenURI() public view returns (string memory) {
        return baseTokenUri;
    }

    function getMintPrice() public view returns (uint256) {
        return mintPrice;
    }

}
