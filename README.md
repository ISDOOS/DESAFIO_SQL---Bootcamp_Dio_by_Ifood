# 🛒 Sistema de E-commerce - Definição do Esquema de Banco de Dados

Este script SQL apresenta a definição do esquema de banco de dados para um sistema de e-commerce. É importante notar que este esquema foi refinado em relação ao esquema original para melhor atender às necessidades específicas do projeto. Além disso, foram criadas funções de inserção para preencher as tabelas com dados fictícios e consultas adicionais para explorar o funcionamento do sistema.

## 📊 Diferenças entre o E-commerce Original e o E-commerce Refinado

### Adição de Tipos de Cliente

No esquema refinado (ecommerce refinado), foi introduzida uma distinção entre clientes Pessoa Física (PF) e Pessoa Jurídica (PJ). A tabela de clientes agora inclui um campo "tipoCliente" para diferenciar os dois tipos de clientes.

### Inclusão de Informações de Pagamento e Entrega

Foram adicionadas as tabelas "pagamentos" e "entregas" para rastrear as formas de pagamento cadastradas pelos clientes e manter o status das entregas dos pedidos.

### Refinamento das Relações

As relações entre as tabelas foram refinadas para refletir as mudanças introduzidas no esquema. Por exemplo, a tabela de pedidos agora se relaciona com a tabela de clientes, e a tabela de entregas está vinculada à tabela de pedidos.

## 📥 Funções de Inserção

Foram criadas funções de inserção para preencher as tabelas com dados fictícios de clientes, produtos, pedidos, fornecedores e vendedores. Essas funções simplificam o processo de população do banco de dados com informações de teste.

## 📊 Consultas Adicionais

Para demonstrar o funcionamento do sistema, foram criadas consultas adicionais que respondem a perguntas específicas, como:

1. Quantos pedidos foram feitos por cada cliente?
2. Algum vendedor também é fornecedor?
3. Relação de produtos fornecedores e estoques.
4. Relação de nomes dos fornecedores e nomes dos produtos.

## 🚀 A Profundidade do Estudo

Este projeto proporcionou uma oportunidade valiosa para aprofundar o conhecimento em gerenciamento de banco de dados e consultas SQL. A capacidade de modificar o esquema original para atender a requisitos específicos e a criação de funções e consultas adicionais permitiram uma compreensão mais completa e prática do desenvolvimento de sistemas de e-commerce e da manipulação de dados.

## 👨‍💻 Como Usar

O esquema de banco de dados pode ser implementado em qualquer sistema de gerenciamento de banco de dados relacional (RDBMS) compatível com SQL. O README inclui instruções sobre como criar o banco de dados, inserir dados de teste usando as funções de inserção e executar as consultas SQL fornecidas.

---

Um agradecimento especial à DIO (Digital Innovation One) por proporcionar esta oportunidade de aprendizado! 🙏
