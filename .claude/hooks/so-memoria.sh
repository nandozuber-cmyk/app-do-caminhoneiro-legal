#!/usr/bin/env bash
# Trava da equipe do ENGENHEIRO IA para agentes que não alteram o projeto
# (analista-requisitos, arquiteto, revisor): antes de cada Edit ou Write,
# só deixa passar arquivos dentro de .claude/agent-memory/. Qualquer outro
# caminho é bloqueado (saída 2, o motivo vai para o agente).
entrada="$(cat)"
caminho="$(printf '%s' "$entrada" | tr -d '\n' | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')"
if [ -z "$caminho" ]; then
  exit 0
fi
case "$caminho" in
  *..*)
    echo "Bloqueado pela equipe do ENGENHEIRO IA: caminho com '..' não é permitido ($caminho)." >&2
    exit 2
    ;;
  .claude/agent-memory/*|*/.claude/agent-memory/*)
    exit 0
    ;;
esac
echo "Bloqueado pela equipe do ENGENHEIRO IA: este agente não altera o projeto; só pode escrever na própria pasta .claude/agent-memory/<nome>/ ($caminho). Descreva a mudança no relatório para o especialista indicado." >&2
exit 2
