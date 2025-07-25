# BookstoreRobot140

Este projeto automatiza testes para uma API de livraria utilizando Robot Framework.

## O que foi feito
- Criação de testes automatizados para endpoints de usuários e livros da API.
- Organização dos testes em arquivos separados para melhor manutenção.
- Estrutura de pastas para facilitar o entendimento e execução dos testes.

## Ferramentas utilizadas
- **Robot Framework**: Framework de automação de testes.
- **Python**: Linguagem base para execução do Robot Framework.
- **Requests Library**: Biblioteca para requisições HTTP no Robot Framework.

## Estrutura do projeto
```
__tests__/
  api/
    test_bookstore_book.robot
    test_bookstore_user.robot
```

## Como rodar localmente

1. **Instale o Python** (recomendado 3.8+).
2. **Instale o Robot Framework e a Requests Library**:
   ```powershell
   pip install robotframework robotframework-requests
   ```
3. **Execute os testes**:
   ```powershell
   robot __tests__/api
   ```

Os resultados dos testes serão exibidos no terminal e relatórios serão gerados na pasta de execução.