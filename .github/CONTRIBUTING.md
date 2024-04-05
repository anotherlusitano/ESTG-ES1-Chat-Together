# Contribuir
Para contribuir, ou seja, resolver as tarefas do [projeto](https://github.com/users/anotherlusitano/projects/5), é preciso seguir os seguintes passos:
1. Atribuir-se a tarefa desejada
2. Mover a tarefa para "**In progress**"
3. Clonar o repositório
4. Criar uma nova branch com o nome da tarefa
5. Fazer as alterações necessárias
6. Dar push da branch criada
7. Criar uma pull request e esperar por aprovação
8. Caso seja aprovada, mover a tarefa para "**Done**"

> [!NOTE]  
> Caso os colaboradores exijam alterações, será necessário efetua-las para obter a aprovação da pull request.

## Commits
Os commits devem ser:
- Com pequenas alterações
- Escritos em português
- Com um título conciso

### Estilo dos commits
Os commits serão divididos nas seguintes **tags**:
- feat – a introdução de uma nova feature
- fix – uma correção de bugs/erros
- chore – modificaçãoes que não mudam o código (por exemplo, atualizar as dependências)
- refactor – refacturar o código de modo a não corrigir nenhum erro nem acrescentar nenhuma feature
- docs – para atualizar o README ou um ficheiro markdown
- style – é apenas para formatar o código (espaçamentos, pontos e vírgulas, etc)
- test – para adicionar ou corrigir testes do código
- perf – para melhorar a performance do código
- build – para adicionar uma nova plataforma ou uma dependência
- revert – reverter o commit anterior

### Exemplos de commits
```bash
"feat: adicionar validação dos campos da página Login"
"feat: adicionar widget StandardButton"
"fix: erro de não mudar para a página Home ao clicar no butão"
"chore: atualizar firebase para a versão 9.10.2"
"docs: adicionar data model"
"style: adicionar vírgulas para o widget StandardButton"
"test: adicionar teste de navegação ao StandardButton"
"perf: substituir função recursiva por for loop"
"build: adicionar dependência firebase_auth"
"build: adicionar suporte à plataforma Android"
"revert: reverter commit acidental que inseria uma backdoor"
```
> [!NOTE]  
> Caso o titlo do commit não dê para escrever todas as informações, considere dividí-lo em pequenos commits ou escrever as informações no corpo do commit.
