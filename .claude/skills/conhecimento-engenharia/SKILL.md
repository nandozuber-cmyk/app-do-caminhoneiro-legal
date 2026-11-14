---
name: conhecimento-engenharia
description: "Manual de engenharia sênior da equipe do ENGENHEIRO IA: como um desenvolvedor sênior decide, desenha, escreve, protege, observa e entrega código que dura. Carregado em todos os desenvolvedores, no arquiteto e no revisor."
user-invocable: false
---

# Manual de engenharia sênior (equipe do ENGENHEIRO IA)

Um desenvolvedor sênior não é quem escreve mais código: é quem entrega o resultado certo com o **menor risco e o menor custo de manutenção**, e deixa o projeto melhor do que encontrou.

## 1. Entender o problema antes da solução
- Pergunte "qual problema do usuário isto resolve?" e "como saberemos que funcionou?". Se o pedido traz uma solução pronta que não resolve o problema, diga isso no relatório e proponha a alternativa.
- Leia o código vizinho, os testes e o histórico (`git log -p` do arquivo) antes de mudar. Entenda **por que** o código é como é antes de mudar.
- Encontre todos os lugares afetados (`grep` pelos usos) antes de alterar uma função, um tipo ou um formato de dado.

## 2. Julgamento de engenharia
- **Simples primeiro:** a solução mais simples que atende aos critérios e às restrições reais. Nada de abstração "para o futuro" sem um segundo caso concreto (regra do três).
- **Decisões reversíveis rápido, irreversíveis com cuidado:** formato de dado, API pública, esquema de banco e dependências merecem comparação de opções; nomes internos e organização de arquivos, não.
- **Custo total:** pese o código que você adiciona (ler, testar, manter) contra o que ele evita.
- **Dívida técnica consciente:** se tomar um atalho, registre-o como pendência com o motivo e como pagar.
- **Discorde com dados:** quando o plano tiver um problema real, diga qual, mostre a evidência e proponha a correção. Não implemente em silêncio algo que você sabe que vai quebrar.

## 3. Desenho de código
- Funções pequenas com um propósito; nomes que dizem a intenção; sem efeitos colaterais escondidos.
- Separe regra de negócio, acesso a dados e interface: a regra deve ser testável sem rede, banco ou tela.
- Dependências apontam para dentro (a regra não conhece o framework).
- Dados imutáveis quando possível; estados impossíveis não representáveis (tipos, enums, validação na borda).
- Trate erros onde há informação para decidir; não engula exceções; não use exceção para fluxo normal.
- Evite duplicação de **conhecimento** (a mesma regra em dois lugares), não de linhas parecidas.

## 4. Contratos e compatibilidade
- APIs: contrato explícito (entrada, saída, erros, códigos HTTP), versionamento quando quebrar, paginação e limites desde o início.
- Nunca quebre quem já usa: acrescente campos em vez de mudar significado; mantenha o formato antigo legível enquanto houver dados ou clientes antigos (expandir e contrair).
- Dados persistidos (localStorage, banco, arquivos) mudam com migração e teste com dados no formato antigo.

## 5. Confiabilidade
- Toda chamada externa tem tempo limite, nova tentativa com espera crescente quando segura, e comportamento definido em falha.
- Operações repetíveis (idempotentes) quando podem ser reenviadas.
- Falhe de forma segura e visível: mensagem clara ao usuário, registro útil para quem mantém.
- Concorrência: pense em dois usuários (ou duas abas) fazendo a mesma coisa ao mesmo tempo.

## 6. Desempenho com medida
- Não otimize no escuro: meça (tempo, consultas, tamanho do pacote) antes e depois.
- Cuidados que valem sempre: sem N+1, paginação, índices nas consultas usadas, imagens e pacotes enxutos, nada pesado na thread principal.
- Orçamento web de referência: página interativa em até ~3 s numa rede 4G e celular comum; sem bloquear a interface por mais de 200 ms.

## 7. Observabilidade
- Registros (logs) estruturados nos pontos de decisão e de falha, com contexto (id da operação), **sem dados pessoais nem segredos**.
- Mensagens de erro que dizem o que aconteceu e o que fazer.
- Quando o projeto tiver métricas ou rastreamento, instrumente o caminho novo.

## 8. Testes como um sênior
- Teste comportamento, não implementação; cubra regra de negócio, bordas e erros.
- Cada defeito corrigido ganha um teste de regressão.
- Testes rápidos, determinísticos e independentes da ordem.
- Refatoração só com testes verdes antes e depois.

## 9. Entrega segura
- Mudanças pequenas e revisáveis; um commit por ideia, com mensagem que explica o **porquê**.
- Mudança arriscada atrás de chave de liga/desliga (feature flag) ou com caminho de volta escrito.
- Deixe o código mais limpo do que encontrou, **só** no que você tocou (regra do escoteiro), sem misturar refatoração grande com função nova.
- Documente decisões não óbvias num comentário curto (o porquê, não o quê) ou em `DECISOES.md`.

## 10. Antes de dizer "pronto"
- Os critérios de aceitação estão atendidos e provados por teste ou execução real?
- Rodei a suíte completa, o lint e o build?
- Li o meu diff inteiro como revisor: nomes, erros tratados, segurança, sobras de depuração, arquivos fora do escopo?
- Pensei em celular, rede ruim, dados vazios, dados antigos e dois usuários ao mesmo tempo?
- Quem mantiver isto daqui a um ano entende sem me perguntar?
