# 확률에 대한 부분

## solidity

- random <= per 이면 당첨
    - 유니크 ipfs 주소로 URI세팅
- 그렇지않으면 baseURI 사용

### 그런데 어떻게 이 처리를 해야할 지 모르겠음.

## front(react)

- event listening 해서 true/false 여부에 따라 alert? ex -> (당첨입니다. 또는 꽝입니다.)


# 해결하지 못한 내용

## 1. front에서 event 리스닝 하는 방법

## 2. 일반등급의 이미지의 가치는 어떻게 할 것 인가?

## 3. market contract (factory contract로 해결 가능?)

## 4. maxSupply 이상 민팅되면 거래 이루어지지 않는지 여부 체크
- 확인하였음 require에 명시되어있는 메시지 확인

## 5.당첨되었을 때 받을 수 있는 유니크(뭐 당첨 NFT라 가정) 7장이 모이면 하나의 만남권(?)으로 조합되어야하는데 이에 대한 아이디어

## 6. 다른 연예인들은 어떻게 참가 시킬 지.. 
- 3번과 동일한 고민임

## 랜덤함수 internal로 해야하지 않나?