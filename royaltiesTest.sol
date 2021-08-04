programa solidity ^0.8.6;

import @openzepplin/contracts/token/ERC721.sol;
import @openzepplin/contracts/token/ERC20.sol;

contract NFT is ERC721 {
address public artist;
address public txFeeToken;
uint public txFeeAmount;
mapping(address => bool) public excludedList;

contstructor(
	address _artist,
	address _txFeeToken,
	uint _txFeeAmount
	) ERC721('My NFT', ABC') {
	artist = _artist;
	txFeeToken= _txFeeToken;
	txFeeAmount = _txFeeAmount;
	excludedList[_artist] = true
	_mint(artist, 0);
	}
	
	
function setExcluded(address excluded, bool status) external{
	require(msg.sender === artist, 'artist only');
	excludedList[excluded] = status;
}
	

function transferFrom( address from, address to, uint256 tokenId) public override {
	require(_isApprovedorOwner(_msgSender(), tokenId),
	'ERC721: is not an owner or approved'
	);
	if(excludedList[from] == false){
	_payTxFee(from);
	}
	_transfer(from, to, tokenId);
}

function _payTxFee(address from) internal {
IERC20 token = IERC20(txFeeAmount);
token.transferFrom(from, artist, txFeeAmount);
}
}


