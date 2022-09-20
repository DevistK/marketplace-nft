// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// ERC721 URI Storage 에서 init
contract NFT is ERC721URIStorage{
    // tokenIds increment 를 위한 counter utils 사용
    using Counters for Counters.Counter;
    // 멤버변수 선언 tokenIds
    Counters.Counter private _tokenIds;
    // contractAddress 선언
    address contractAddress;

    // ERC721 초기화
    // nft 마켓에 등록할 토큰들이기 때문에 marketplace address contractAddress 로 할당
    constructor(address marketplaceAddress) ERC721('Metaverse Token', 'METT'){
        contractAddress = marketplaceAddress;
    }

    // token 생성 로직
    function createToken(string memory tokenURI) public returns (uint){
        // 새 토큰 id 1증가
        _tokenIds.increment();
        // 새 nft를 item이라 칭하고 방금 증가한 token value값을 할당
        uint256 newItemId = _tokenIds.current();

        // nft 생성 시 생성하는 사람 , 어떤 nft 인지 인자전달
        _mint(msg.sender, newItemId);
        // tokenURI 세팅 시 어떤 nft를 URI 셋 할건지 인자전달
        _setTokenURI(newItemId, tokenURI);
        // 이 메서드를 호출하는 오퍼레이터를 (마켓에서 nft를 사용하기 떄문에 marketplace address) 승인 할 수 있게 해줌
        setApprovalForAll(contractAddress, true);
        // 민팅부터 URI 셋 , 컨트랙트 접근 승인절차 까지 끝나면 해당 nft를 클라이언트에게 리턴
        return newItemId;
    }
}

