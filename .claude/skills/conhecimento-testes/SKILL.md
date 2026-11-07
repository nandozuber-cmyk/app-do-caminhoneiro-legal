---
name: conhecimento-testes
description: "Manual de técnicas de teste da equipe do ENGENHEIRO IA: como escolher casos (partição, valores-limite, tabela de decisão, estados), como escrever testes confiáveis e como achar a causa de uma falha. Carregado no testador, no revisor e nos executores."
user-invocable: false
---

# Manual de testes (equipe do ENGENHEIRO IA)

## Escolher os casos (não teste ao acaso)
1. **Partição de equivalência:** divida as entradas em grupos que se comportam igual (válido, inválido, vazio) e teste um de cada.
2. **Valores-limite:** teste exatamente no limite, um abaixo e um acima (ex.: máximo 100 caracteres → 99, 100, 101; quantidade 0, 1, máximo).
3. **Tabela de decisão:** quando várias condições se combinam (logado × dono × arquivado), liste as combinações relevantes e o resultado esperado de cada.
4. **Transição de estados:** para fluxos com estados (rascunho → enviado → pago → cancelado), teste cada transição válida e pelo menos uma inválida.
5. **Erros e ambiente:** rede caída, resposta lenta, resposta malformada, disco cheio, permissão negada, armazenamento vazio ou corrompido.
6. **Dados reais do Brasil:** acentos e cedilha, nomes compostos, CPF/telefone com e sem máscara, datas dd/mm/aaaa, vírgula decimal, fuso de São Paulo.
7. **Regressão:** todo defeito corrigido ganha um teste que falhava antes da correção.

## Escrever testes confiáveis
- Um comportamento por teste, nome que descreve o cenário ("recusa tarefa com título vazio").
- Estrutura **Preparar → Agir → Conferir**; asserção sobre o **resultado observável**, não sobre detalhes internos.
- Nada de `sleep` fixo: espere pela condição (Playwright: `expect(locator).toBeVisible()`).
- Isolamento: cada teste cria e limpa os próprios dados; ordem dos testes não importa.
- Relógio, aleatoriedade e rede controlados (datas fixas, sementes, serviços simulados).
- **Teste do teste:** pense "se eu quebrasse o código, este teste falharia?". Se não, a asserção é fraca.
- Nunca desative, apague ou afrouxe um teste para ficar verde.

## Pirâmide
- Muitos testes de unidade (rápidos) para regras de negócio.
- Alguns testes de integração (API + banco temporário, componentes juntos).
- Poucos testes de ponta a ponta no navegador ou no app, nos caminhos principais.

## Testar o sistema real
- Web: abrir a página com Playwright (se disponível), em 375 px e em 1280 px, e seguir o caminho do usuário; conferir console sem erros.
- API: chamar com sucesso, erro de validação, sem login e com login de outra conta.
- Scripts e automações: rodar em modo de simulação duas vezes seguidas (idempotência).

## Achar a causa de uma falha
1. Reproduza com o menor comando possível e leia a mensagem inteira.
2. Forme hipóteses e elimine uma por vez com uma observação (log, asserção, teste menor).
3. Se o teste falha às vezes, rode várias vezes e procure dependência de ordem, tempo ou dados compartilhados.
4. Diferencie: defeito do código, teste errado ou limitação do ambiente.
5. Relate: passos para reproduzir, esperado, obtido, causa (arquivo:linha) e confiança.
