pragma solidity ^0.5.0;

import "./TradeableERC721Token.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @title Loopbomb
 * Loopbomb - a contract for my non-fungible loopbombs.
 */
contract Loopbomb is TradeableERC721Token {
  constructor(address _proxyRegistryAddress) TradeableERC721Token("Loopbomb", "OSC", _proxyRegistryAddress) public {  }

  function baseTokenURI() public view returns (string memory) {
    return "https://loopbomb.com/assets/v1/api/loop/";
  }
}
