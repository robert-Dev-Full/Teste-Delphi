# Teste-Delphi

Criando o banco de dados:
Abra o IBExpert
Clique em Database → Create Database
Configure:
Database file:
caminho do banco\TESTE.FDB
User: SYSDBA
Password: masterkey
Clique em OK

utilizar o arquivo que esta em MD/Script.sql para criar as tabelas.

Informações sobre arquivo de configuração:
Deve estar no mesmo diretório do executável.
DriverID=FB	Driver do Firebird no FireDAC
Database	Caminho completo do .FDB
User_Name	Usuário padrão
Password	Senha padrão
Server	localhost ou IP
Port	Porta padrão (3050)
ClientLibrary	Caminho da fbclient.dll

Após criar o banco de dados e atualizar as informações do arquivo de configuração ja pode ser executado o SistDelphi.exe.

Como utilizar:
  No menu principal tem um botão para iniciar um novo pedido.
  
Visão geral da tela

A interface é dividida em duas áreas principais:

🔹 1. Cabeçalho (topo)
Identificação do pedido (ex: número do pedido)
Área onde será associado o cliente
Provavelmente contém campos como:
Código do cliente
Nome do cliente
Data do pedido

👉 Essa parte é essencial para iniciar o processo.

🔹 2. Grid de itens (corpo da tela)

A maior parte da tela é ocupada por uma grid/listagem de produtos do pedido, contendo colunas como:

Código / Item
Descrição do produto
Unidade (ex: UN, GL, etc.)
Quantidade
Valor unitário
Valor total

👉 Cada linha representa um item do pedido.

⚙️ 🔄 Fluxo de funcionamento
✔️ 1. Início do pedido
Informar o cliente
Clicar no botão Confirmar

👉 Esse passo é obrigatório
👉 Somente após isso o sistema permite inserir produtos

✔️ 2. Inserção de produtos
Informar o produto (código ou busca)
O sistema:
Carrega automaticamente:
Descrição
Unidade
Valor padrão
Informar:
Quantidade
(Opcional) alterar valor
Confirmar inclusão

👉 O item é adicionado na grid

🔁 3. Manipulação dos itens na grid
▶️ Alterar item (atalho ENTER)
Selecionar um produto na grid
Pressionar ENTER

👉 O sistema:

Abre o item para edição
Permite alterar:
Quantidade
Valor
❌ Excluir item
Selecionar um item na grid
Acionar o botão de exclusão

👉 O sistema exibe:

Caixa de confirmação
“Deseja realmente excluir?”

✔️ Se confirmar → remove o item
❌ Se cancelar → mantém o item

🔘 Funcionalidades adicionais
📂 Botão Abrir Pedido
Ao clicar:
Sistema solicita o número do pedido
Após confirmação:
Carrega todos os dados na tela:
Cliente
Itens
Valores

👉 Usado para:

edição
consulta
🧹 Botão Limpar
Limpa toda a tela
Remove:
cliente selecionado
itens da grid

👉 Uso principal:

após visualizar um pedido
iniciar um novo lançamento  