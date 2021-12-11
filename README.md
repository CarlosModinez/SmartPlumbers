# OramaChallenge

### Funcionaliade
- [x] Fazer uma chamada GET em
https://s3.amazonaws.com/orama-media/json/fund_detail_full.json
- [x] Possui uma tela que exibe os 6 primeiros fundos da API em uma UICollectionView.
- [x] Ao tocar na célula do fundo será exibida uma tela com alguns detalhes a mais sobre o
fundo.

### Requisitos técnicos obrigatórios:
- [x] O app deve dar suporte a partir da iOS 11 e deve utilizar a linguagem Swift;
- [x] O app deve possuir mapeamento json, exemplo: ObjectMapper, Codable, etc...
- [x] Utilizar Auto Layout ou ViewCode para a construção das telas.
- [x] Os campos que vem da API devem ser formatados para uma melhor exibição para o usuário,
valores com R$ por exemplo.    
  
A API retorna várias informações sobre o fundo, na célula são exibidos o:
1. simple_name
2. operability.minimum_initial_application_amount
3. specification.fund_risk_profile.name

Na tela de detalhe, são exibidos
1. full_name
2. initial_date
3. strategy_video.thumbnail (se possuir!)
4. fund_manager.description
5. operability.minimum_initial_application_amount (Decisão de layout - não era pré-requisito)
6. specification.fund_risk_profile.name (Decisão de layout - não era pré-requisito)

## Observações feitas pelo desenvolvedor
* A resposta da chamada da API é bastante grande e pode demorar para responder. Logo, tomei a decisão de não fazer o load das informações todas as vezes que a tela é aberta. No entanto, inclui uma funcionalidade que vêm sendo utilizada que é o carregamento quando o usuário faz um scroll para cima.
  
* Os requisitos do projeto descrevem que devem ser mostradas apenas os 6 primeiros fundos da resposta da requisição, no entanto, na maioria dos meus testes, os 5 primeiros vêm com o parâmetro strategy_video.thumbnail nulo. Portanto, não é possível visualizar a thumbnail na tela de detalhes nesses casos. Não desista, há fundos que vem com a resposta do thumbail preenchida.
  
* Pelo mesmo motivo citado à cima, a indição de risco dos fundos sempre aparenta ser muito alta. Para verificar o funcionamento da indicação de risco, experimente alterar o código para mostrar mais fundos a fim de mostrar alguns com baixo risco.
