# Meu Bolso

**Meu Bolso** é um aplicativo simples e intuitivo para controle de despesas pessoais. O objetivo é permitir que os usuários registrem e visualizem suas despesas de forma rápida e prática.

---

## Funcionalidades

- ✅ Adicionar despesas com descrição, valor e data.
- ✅ Visualizar a lista de despesas cadastradas.
- ✅ Interface amigável e minimalista.
- ✅ Persistência de dados utilizando [Hive](https://pub.dev/packages/hive).

---

## Tecnologias Utilizadas

- **Flutter**: Framework para construção de aplicações multiplataforma.
- **Hive**: Banco de dados local rápido e leve para persistência de dados offline.
- **Dart**: Linguagem de programação para desenvolvimento do app.

---

## Estrutura do Projeto

```plaintext
lib/
├── data/
│   ├── hive_database.dart         # Operações relacionadas ao banco de dados Hive
├── models/
│   ├── expense.dart               # Modelo de dados para despesas
├── screens/
│   ├── home_screen.dart           # Tela inicial com a lista de despesas
│   ├── add_expense_screen.dart    # Tela para adicionar novas despesas
├── main.dart                      # Ponto de entrada do aplicativo
