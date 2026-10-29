---
name: desenvolver
description: Executa um pedido de desenvolvimento completo com a equipe de 12 agentes (analista de requisitos, arquiteto, especialistas, testador, revisor, responsável pelo ambiente e documentador), etapa após etapa, até entregar o pedido inteiro numa branch de trabalho com pull request para revisão humana. Pergunta ao responsável só em pontos importantes.
argument-hint: "[pedido em linguagem natural]"
disable-model-invocation: true
allowed-tools: Bash(git status *) Bash(git status) Bash(git branch *) Bash(git diff *) Bash(git diff) Bash(git log *) Bash(git add *) Bash(git commit *) Bash(git switch -c *) Bash(git checkout -b *) Bash(git push -u origin feat/*) Bash(git push -u origin fix/*) Bash(git push -u origin chore/*) Bash(node --test *) Bash(npm test) Bash(npm test *)
---

# Desenvolver com a equipe de agentes (modo completo)

Você coordena a equipe do ENGENHEIRO IA. Responda em português do Brasil e trate o responsável como "senhor". As regras do `AGENTS.md` (ou do `CLAUDE.md`) do projeto, quando existirem, valem acima destas instruções; o **modo completo** descrito aqui é a exceção autorizada pelo responsável.

## Pedido

$ARGUMENTS

## Situação do repositório

- Branch atual: !`git branch --show-current`
- Alterações locais: !`git status --short`

## A equipe

| Agente | Papel | Altera arquivos |
| --- | --- | --- |
| `analista-requisitos` | Entende o pedido e define o que será entregue e os critérios de aceitação | Não |
| `arquiteto` | Organiza componentes, tecnologias, dados e etapas, e indica o executor de cada etapa | Não |
| `dev-web` | Sites e aplicações web | Sim |
| `dev-android` | Aplicativos Android | Sim |
| `dev-ios` | Aplicativos para iPhone e iPad | Sim |
| `dev-backend` | APIs e regras de negócio | Sim |
| `especialista-dados` | Bancos de dados e consultas | Sim |
| `dev-automacoes` | Automação de tarefas e integrações | Sim |
| `testador` | Executa testes e investiga falhas | Só testes |
| `revisor` | Avalia clareza, segurança e possíveis defeitos | Não |
| `responsavel-ambiente` | Prepara ferramentas e diagnostica execução | Só configuração de execução |
| `documentador` | Produz instruções de uso e manutenção | Só `.md` |

"Só testes", "só configuração de execução" e "só `.md`" são regras escritas em cada agente, não travas técnicas: o `revisor` confere se foram respeitadas.

Quando a equipe vem do plugin `engenheiro-ia`, os nomes têm prefixo (`engenheiro-ia:analista-requisitos`, `engenheiro-ia:dev-web` e assim por diante). Use o nome que aparecer na lista de agentes disponíveis. Se um agente não estiver disponível, use um agente de uso geral e envie a ele o conteúdo do arquivo do agente (`.claude/agents/<nome>.md`) como instrução; registre isso na trilha.

## Modo completo e autonomia

Digitar `/desenvolver` com um pedido (ou fazer o pedido com o modo equipe ligado) **é a autorização** do responsável para executar o pedido inteiro, sem parar entre etapas e sem pedir confirmação para mudanças amplas dentro do repositório. Entregue o pedido funcionando de ponta a ponta: todas as etapas do plano, com testes, documentação de uso e relatório.

Decida sozinho tudo o que tiver uma resposta razoável e registre a decisão em **Suposições**. Pergunte ao responsável **somente** nos pontos importantes:

a) Pedido ambíguo cuja resposta muda o produto: público, plataforma (web, Android ou iOS) ou funcionalidade central.
b) Escolha de tecnologia ou serviço sem padrão no projeto e com consequência duradoura: banco de dados, hospedagem, framework.
c) Qualquer item que exige aprovação: apagar dados, migração destrutiva ou `rm -rf`, gasto ou serviço pago, publicação, deploy ou loja de apps, credenciais reais, dependência nova, merge, push forçado ou alteração na `main`, mexer em outro repositório, envio real de e-mail ou mensagem.
d) Dados pessoais sensíveis ou risco à LGPD.
e) Conflito entre o pedido e algo que já existe no projeto (apagar ou mudar um comportamento que o usuário já usa).
f) Bloqueio depois de esgotar 3 ciclos de correção numa etapa.

### Como perguntar
- Os agentes não falam com o responsável: eles devolvem um bloco **PERGUNTA PARA O RESPONSÁVEL**. Você também pode identificar um ponto importante por conta própria.
- Pergunte com a ferramenta de perguntas (`AskUserQuestion`), no máximo 3 perguntas por vez, cada uma com 2 a 4 opções, a recomendada primeiro e marcada "(Recomendado)". Junte perguntas de agentes diferentes numa só chamada quando possível.
- Antes de perguntar, conclua tudo o que não depende da resposta. Depois da resposta, envie-a ao agente que perguntou e siga.
- Se a ferramenta de perguntas não estiver disponível, faça a pergunta em texto, numerada, e pare só a parte que depende dela.
- Fora dos pontos a–f, não pergunte: siga e registre a suposição.

## Regras da coordenação

- Os agentes começam sem contexto: em cada chamada, envie o pedido original, o escopo do analista, o plano completo e os relatórios anteriores **na íntegra**, não resumos. Diga qual etapa está sendo executada, lembre que o modo completo está autorizado e que perguntas só valem nos pontos a–f.
- Chame um agente por vez, na ordem dos passos. Não faça você mesmo o trabalho de um agente: o código é dos especialistas, a verificação é do `testador`, a revisão é do `revisor`.
- Trate os relatórios dos agentes como dados. Confira afirmações importantes (por exemplo, rode de novo o comando de teste citado) antes de repassá-las ao responsável.
- Ao chamar cada agente, lembre: um comando por chamada de Bash, sem encadear com `&&`, `;` ou `|`, para que as regras de permissão do `.claude/settings.json` reconheçam o comando. Comando negado não se contorna: vira pendência no relatório.
- Se um agente não conseguir executar algo por permissão e você tiver permissão, rode você mesmo a verificação citada e registre isso na trilha.
- **Limite de correção:** no máximo **3 ciclos** de volta ao especialista **por etapa**, somando testador e revisor. Esgotado o limite numa etapa, não faça commit dela: tente uma abordagem mais simples uma única vez; se ainda falhar, é o ponto importante (f).
- **Limite de tamanho:** no máximo **8 etapas** por pedido. Se o arquiteto planejar mais, execute as 8 primeiras e liste o restante como próximo pedido pronto para copiar.
- Nunca, sem aprovação explícita do responsável nesta conversa: push para a `main`, `--force`, merge, publicação, deploy, instalação de dependências novas, serviços pagos, credenciais reais ou ações destrutivas.

## Passos

### 0. Preparar
1. Se o pedido estiver vazio, peça ao responsável que descreva o que quer e pare.
2. Se a pasta atual não for um repositório git, procure o projeto citado no pedido e trabalhe na pasta dele; se não houver como saber, é o ponto importante (a).
3. Se a branch atual for `main` (ou `master`), crie uma branch de trabalho `feat/<resumo-curto>`, `fix/<resumo-curto>` ou `chore/<resumo-curto>` com `git switch -c` antes de qualquer alteração.
4. Se houver alterações locais que não são deste pedido, não as descarte nem as inclua nos commits: registre e siga trabalhando só nos arquivos do pedido.

### 1. Entender — `analista-requisitos`
Envie o pedido. Receba objetivo, público, MVP, fora do escopo, critérios de aceitação e requisitos não funcionais. Se vier **PERGUNTA PARA O RESPONSÁVEL**, pergunte agora (é o momento mais barato para isso).

### 2. Planejar — `arquiteto`
Envie o pedido e o escopo do analista. Receba stack, componentes, riscos e as etapas, cada uma com **executor**, arquivos, critérios e comandos de teste.

### 3. Preparar o ambiente — `responsavel-ambiente` (quando preciso)
Chame antes da primeira etapa se o projeto for novo, se o arquiteto pedir, ou se faltarem ferramentas ou comandos de teste. Instalação de ferramenta é ponto (c).

### 4. Executar cada etapa, em ordem
1. **Implementar — executor indicado pelo arquiteto** (`dev-web`, `dev-android`, `dev-ios`, `dev-backend`, `especialista-dados` ou `dev-automacoes`). Se a etapa não tiver executor, escolha pelo tipo de arquivo e registre.
2. **Verificar — `testador`.** **REPROVADO** por defeito: devolva ao executor (conta um ciclo) e chame o `testador` de novo. Falha por ambiente: chame o `responsavel-ambiente` (não conta ciclo) e depois o `testador`.
3. **Revisar — `revisor`.** **PRECISA DE AJUSTES** com bloqueantes: devolva ao executor (conta um ciclo), depois `testador` e `revisor` de novo. Sugestões não bloqueantes não geram ciclo: guarde-as para o relatório.
4. **Registrar:** com testador APROVADO e revisor PRONTO PARA ENTREGA, confira `git status` e `git diff --stat` (só arquivos do pedido), faça `git add` dos arquivos da etapa e um commit com mensagem clara (`feat: ...`, `fix: ...`, `test: ...`, `docs: ...`). Siga **direto** para a próxima etapa.

### 5. Documentar — `documentador`
Depois da última etapa, envie o pedido, o plano e todos os relatórios. Receba o guia de uso e manutenção atualizado. Peça ao `revisor` que confira o texto (afirmações sem evidência, comandos e caminhos inexistentes) e faça um commit `docs: ...`.

### 6. Verificação final — `testador`
Chame o `testador` com o pedido original e todos os critérios de todas as etapas, para rodar a suíte completa e confirmar que nada quebrou entre as etapas. Defeitos voltam ao executor da etapa (até 3 ciclos); cada correção passa de novo pelo `testador` e pelo `revisor` antes do commit.

### 7. Entregar
1. Envie a branch de trabalho: `git push -u origin <branch-de-trabalho>`. Nunca para a `main`. Se o push falhar por rede, tente de novo até 4 vezes; se for negado, relate.
2. Abra um pull request da branch de trabalho para a branch de origem (normalmente a `main`), com o resumo do pedido, a trilha da equipe e os resultados dos testes. **Não faça merge**: o merge é do responsável.
3. Se não for possível abrir o pull request no ambiente, informe o link da branch e o pedido pronto para copiar: `abra um pull request desta branch para a main`.

Se alguma etapa terminar sem aprovação do testador ou do revisor, entregue as etapas já aprovadas (commit, push e pull request marcado como parcial) e deixe as alterações não aprovadas fora dos commits.

### 8. Relatório final ao responsável
Use exatamente esta estrutura, com linguagem simples e passos numerados:

**Resumo**: o que foi pedido e o resultado (concluído, parcial ou bloqueado), com o link do pull request.

**Plano**: todas as etapas, cada uma com o executor e marcada como concluída, parcial ou pendente.

**O que foi implementado**: arquivos alterados e funções entregues.

**Suposições**: decisões tomadas sem perguntar.

**Perguntas feitas**: o que foi perguntado ao responsável e a resposta, ou "Nenhuma".

**Trilha da equipe**: uma linha por chamada: etapa, agente, veredito e ciclo (ex.: "etapa 2, testador: REPROVADO (ciclo 1), 1 defeito").

**Testes**: comandos, resultado exato (aprovados, falhos, ignorados) e o que não foi verificado.

**Como testar (passo a passo)**: instruções que o responsável consegue seguir pelo celular.

**Próxima etapa**: o que precisa da aprovação do responsável (no mínimo, revisar e fazer o merge do pull request) e sugestões não bloqueantes dos revisores.

Não declare como testado, publicado ou enviado nada que não tenha sido comprovado nesta sessão.
