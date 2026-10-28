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
  comando="/engenheiro-ia:desenvolver"
else
  skill="$skill_projeto"
  prefixo=""
  comando="/desenvolver"
fi

if [ ! -f "$skill" ]; then
  exit 0
fi

cat <<EOF
Modo equipe do ENGENHEIRO IA ligado neste projeto.
- A equipe tem quatro agentes: ${prefixo}arquiteto, ${prefixo}desenvolvedor, ${prefixo}testador e ${prefixo}revisor.
- O processo da equipe está em: $skill
- Quando o responsável pede para criar, alterar, corrigir, testar ou documentar algo neste projeto, o pedido segue esse processo do início ao fim, como se tivesse sido feito com $comando: ler o arquivo acima, planejar com o arquiteto e executar cada etapa com desenvolvedor, testador e revisor.
- Perguntas, explicações, consultas e conversas são respondidas diretamente, sem acionar a equipe.
- Quando o pedido contém "sem equipe", ele é feito diretamente, sem acionar a equipe.
- As regras do AGENTS.md ou CLAUDE.md do projeto continuam valendo, inclusive as que exigem aprovação do responsável.
EOF
exit 0
