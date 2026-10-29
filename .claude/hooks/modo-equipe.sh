#!/usr/bin/env bash
# Modo equipe do ENGENHEIRO IA: ao abrir a sessão, informa ao Claude que os
# pedidos de desenvolvimento seguem o processo do /desenvolver.
# Funciona dentro do repositório (.claude/hooks) e dentro do plugin
# (plugins/engenheiro-ia/scripts). Nunca bloqueia a sessão: sai com 0 sempre.

# Desligar sem apagar nada: ENGENHEIRO_IA_MODO_EQUIPE=0
if [ "${ENGENHEIRO_IA_MODO_EQUIPE:-1}" = "0" ]; then
  exit 0
fi

projeto="${CLAUDE_PROJECT_DIR:-$PWD}"
skill_projeto="$projeto/.claude/skills/desenvolver/SKILL.md"

if [ -n "${CLAUDE_PLUGIN_ROOT:-}" ]; then
  # Se o projeto já traz a equipe na própria pasta .claude, o gatilho do
  # projeto avisa; o do plugin fica em silêncio para não repetir.
  if [ -f "$skill_projeto" ]; then
    exit 0
  fi
  skill="$CLAUDE_PLUGIN_ROOT/skills/desenvolver/SKILL.md"
  prefixo="engenheiro-ia:"
else
  skill="$skill_projeto"
  prefixo=""
fi

if [ ! -f "$skill" ]; then
  exit 0
fi

agentes=""
for nome in analista-requisitos arquiteto dev-web dev-android dev-ios dev-backend especialista-dados dev-automacoes testador revisor responsavel-ambiente documentador; do
  agentes="${agentes:+$agentes, }${prefixo}${nome}"
done

cat <<EOF
Modo equipe do ENGENHEIRO IA ligado neste projeto.
- A equipe tem 12 agentes: ${agentes}.
- A equipe trabalha de forma autônoma e só pergunta ao responsável em pontos importantes: pedido ambíguo que muda o produto, escolha duradoura de tecnologia, ações que exigem aprovação, dados pessoais sensíveis, conflito com o que já existe e bloqueio após 3 ciclos de correção.
- O processo da equipe está em: $skill
- Quando o responsável pede para criar, alterar, corrigir, testar ou documentar algo neste projeto, o pedido segue esse processo do início ao fim, como se tivesse sido feito com /desenvolver: ler o arquivo acima, entender com o analista de requisitos, planejar com o arquiteto e executar cada etapa com o especialista indicado, o testador e o revisor, terminando com o documentador.
- Perguntas, explicações, consultas e conversas são respondidas diretamente, sem acionar a equipe.
- Quando o pedido contém "sem equipe", ele é feito diretamente, sem acionar a equipe.
- As regras do AGENTS.md ou CLAUDE.md do projeto continuam valendo, inclusive as que exigem aprovação do responsável.
EOF
exit 0
