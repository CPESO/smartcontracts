# smartcontracts
CPESO SmartContracts

## USE REMIX deploy with CPESO

1. 먼저 Remix 웹사이트에 접속합니다.

1. Remix 웹사이트에 접속하면 왼쪽에 파일 탐색기와 코드 편집기가 표시됩니다. 파일 탐색기에 새 파일을 생성하거나 기존 파일을 엽니다.

1. ERC-20 스마트 컨트랙트 코드를 작성합니다. 스마트 컨트랙트 코드를 작성하고 편집기에 붙여넣습니다.

1. 스마트 컨트랙트 코드를 작성한 후, 코드를 컴파일합니다. 이를 위해 왼쪽 상단에 있는 "Solidity Compiler" 탭을 클릭합니다.

1. "Compile [your_contract_name].sol" 버튼을 클릭하여 스마트 컨트랙트를 컴파일합니다. 컴파일된 결과가 아래에 표시됩니다.

1. 컴파일된 스마트 컨트랙트의 ABI(인터페이스)를 복사합니다.

1. 왼쪽 하단에 "Deploy & Run Transactions" 섹션으로 이동합니다.

1. "Environment" 드롭다운 메뉴에서 "Injected Web3"를 선택합니다. 이는 브라우저에 설치된 Ethereum 지갑과 연동하여 배포할 것입니다.

1. "Account" 드롭다운 메뉴에서 배포에 사용할 Ethereum 계정을 선택합니다.

1. "Gas limit"를 설정합니다. 이것은 배포에 사용될 최대 가스 양을 나타냅니다.

1. "Deploy" 버튼을 클릭하여 스마트 컨트랙트를 배포합니다.

1. 배포가 성공하면 Remix는 트랜잭션 해시와 배포된 스마트 컨트랙트 주소를 제공합니다.
