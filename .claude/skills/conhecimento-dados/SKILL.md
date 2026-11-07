---
name: conhecimento-dados
description: "Manual de bancos de dados da equipe do ENGENHEIRO IA: modelagem, migrações seguras (expandir e contrair), índices, transações, isolamento entre contas (RLS) e backup. Carregado no arquiteto, no especialista em dados e no backend."
user-invocable: false
---

# Manual de dados (equipe do ENGENHEIRO IA)

## Modelagem
- Chave primária estável (UUID ou inteiro autoincremento conforme o padrão do projeto); nunca usar CPF, e-mail ou nome como chave.
- Toda tabela de dados de cliente tem a coluna do dono (`conta_id` ou `usuario_id`), com índice.
- Restrições no banco, não só no código: `NOT NULL`, `UNIQUE`, `CHECK`, chaves estrangeiras com regra de exclusão pensada.
- Datas em UTC (`timestamptz` no PostgreSQL); converter para o fuso de São Paulo só na tela.
- Dinheiro em centavos (inteiro) ou `numeric`, nunca `float`.
- Colunas `criado_em` e `atualizado_em`; exclusão lógica (`apagado_em`) quando o usuário pode querer desfazer.

## Migrações seguras: expandir e contrair
1. **Expandir:** adicionar a coluna ou tabela nova, sem remover nada; código novo escreve nos dois formatos.
2. **Migrar:** copiar e converter os dados antigos em lotes, de forma repetível.
3. **Trocar:** código passa a ler do formato novo.
4. **Contrair:** remover o formato antigo só depois, em outro pedido, **com aprovação** (é destrutivo).
- Toda migração tem o caminho de volta escrito e testado num banco temporário com dados no formato antigo.
- Nunca editar uma migração que já rodou em algum lugar; criar outra.

## Índices e consultas
- Criar índice para colunas usadas em `WHERE`, `JOIN` e `ORDER BY` frequentes; índice composto na ordem do filtro mais seletivo.
- Conferir com `EXPLAIN` (PostgreSQL/SQLite) que a consulta usa o índice.
- Evitar N+1: buscar relacionados em lote (`IN`, `JOIN`, carregamento antecipado do ORM).
- Paginar listas (por cursor quando a tabela cresce muito).

## Transações e concorrência
- Operações que mudam várias linhas juntas ficam numa transação.
- Evitar condição de corrida em saldo e estoque: atualização atômica (`UPDATE ... SET qtd = qtd - 1 WHERE qtd > 0`) ou bloqueio de linha.
- Idempotência em gravações vindas de rede (chave de idempotência ou `UNIQUE`).

## Isolamento entre contas
- **Supabase/PostgreSQL:** ativar RLS em toda tabela exposta e escrever políticas por `auth.uid()`; testar com dois usuários.
- **Firebase:** regras de segurança que conferem `request.auth.uid` contra o dono do documento; testar no emulador.
- Chave de serviço (service role / admin) nunca no app ou no navegador.

## Backup e dados reais
- Nada de banco real nem credencial real nos testes: banco temporário ou emulador com dados fictícios.
- Antes de qualquer operação destrutiva aprovada: confirmar que existe backup e como restaurar.

## LGPD nos dados
- Guardar só o necessário; separar dados sensíveis; definir retenção e como apagar a pedido do titular.
