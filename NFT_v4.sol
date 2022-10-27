// SPDX-License-Identifier : MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//onlyOwner 사용 위함
import "@openzeppelin/contracts/access/Ownable.sol";


contract NFT is ERC721, Ownable
{
    using Strings for uint256;

    uint256 MAX_SUPPLY = 45;
    uint256 totalSupply;
    uint256 public cost = 0.05 ether;
    string public baseExtension = ".json";

    mapping (uint256 => uint256) public tokenMetadataNo;

    // sale 기간 -> preSale가격
    bool isSaleActive = true;

    constructor() ERC721("Random NFTs", "YGBS") {
        _safeMint(msg.sender, totalSupply++);
    }

    function _baseURI() internal view override returns(string memory)
    {
        return "ipfs://QmUsjyVGzbSSrtdPYNFa61KAxDhrCV4ZgPqJbaVDWkcUXg/";
    }

    function mint(uint256 count) external payable
    {   
        require(isSaleActive, "sale period is ended");
        require(msg.value >= cost * count, "you have to pay exact price");
        require(count <= 1, "you can mint only 1 times at once");
        for (uint i = 0; i < count; i++) {
            require(totalSupply < MAX_SUPPLY, "max supply exceeded");
            uint256 randomNumber = getRandomNumber(msg.sender, MAX_SUPPLY);
            tokenMetadataNo[totalSupply] = randomNumber;
            _safeMint(msg.sender, totalSupply++);
        }
    }

    function tokenURI(uint256 tokenId) public view virtual override returns(string memory)
    {
        _requireMinted(tokenId);
        string memory baseURI = _baseURI();
        return string(abi.encodePacked(baseURI, tokenMetadataNo[tokenId].toString(),baseExtension));
    }

    // internal
function getRandomNumber(address _to, uint256 _range) internal returns (uint256)
    {
        uint256 randomNum = uint256(
            keccak256(
                abi.encode(
                    _to,
                    tx.gasprice,
                    block.number,
                    block.timestamp,
                    block.difficulty,
                    blockhash(block.number - 1),
                    address(this),
                    _range
                )
            )
        );
        uint256 randomNumber = 1 + randomNum % _range;
        return randomNumber;
    }

    // only owner

    // 이 함수를 아무 지갑에서 호출하면 안된다. NFT 프로젝트의 오너만 이 값을 바꿀 수 있어야 한다.
    // 오너 외의 지갑이 호출하면 revert(취소) 된다.
    function setSale(bool active) public onlyOwner
    {
        isSaleActive = active;
    }

    function setCost(uint256 _newCost) public onlyOwner 
    {
        cost = _newCost;
    }
    
    function withdraw() public payable onlyOwner 
    {
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success);
    }

}
