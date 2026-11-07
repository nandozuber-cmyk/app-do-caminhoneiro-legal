---
name: conhecimento-acessibilidade
description: "Manual de acessibilidade e usabilidade da equipe do ENGENHEIRO IA (WCAG 2.2 nível AA, web, Android e iOS) com o que conferir em cada tela. Carregado nos agentes que definem, constroem ou revisam telas."
user-invocable: false
---

# Manual de acessibilidade e usabilidade (equipe do ENGENHEIRO IA)

Meta: **WCAG 2.2 nível AA** e uso confortável no celular. Cada item diz **o que exigir → como conferir**.

## Essencial em toda tela
1. **Contraste:** texto normal ≥ 4,5:1; texto grande e ícones ≥ 3:1, nos temas claro e escuro → medir as cores usadas.
2. **Alvos de toque:** pelo menos 24×24 px (ideal 44×44 pt no iOS, 48×48 dp no Android), com espaço entre eles.
3. **Rótulos:** todo campo tem rótulo visível ligado a ele (`<label for>`, `contentDescription`, `accessibilityLabel`); placeholder não é rótulo.
4. **Erros:** mensagem em texto, perto do campo, dizendo como corrigir; não depender só de cor; o que o usuário digitou é mantido.
5. **Teclado e leitor de tela:** tudo funciona sem mouse, na ordem visual, com foco visível; ícone-botão tem nome acessível.
6. **Texto ampliado:** com fonte em 200% (web) ou tamanho máximo do sistema (apps), nada some nem se sobrepõe.
7. **Movimento:** respeitar "reduzir movimento"; nada pisca mais de 3 vezes por segundo; animação não é obrigatória para entender.
8. **Idioma e textos:** `lang="pt-BR"`; linguagem simples; botões dizem a ação ("Salvar tarefa", não "OK").

## Web
- HTML semântico: `button` para ações, `a` para navegação, títulos em ordem (`h1` → `h2`), `main`, `nav`, listas reais.
- Imagens com `alt` útil; decorativas com `alt=""`.
- Mudanças dinâmicas anunciadas com `aria-live="polite"` (ex.: "Tarefa salva").
- Diálogos: foco vai para dentro, `Esc` fecha, foco volta ao botão que abriu.
- Layout de 320 px a telas grandes sem rolagem horizontal; `viewport` sem bloquear zoom.
- Conferir: navegar só com `Tab`/`Enter`/`Esc`; rodar o axe (se já existir no projeto) ou inspecionar a árvore de acessibilidade no Playwright.

## Android (Jetpack Compose)
- `Modifier.semantics { contentDescription = ... }` em ícones; `mergeDescendants` em itens de lista.
- Tamanhos em `sp` para texto e `dp` para toque (mínimo 48 dp).
- Testar com TalkBack e com "Tamanho da fonte" no máximo; `Modifier.testTag` para testes.

## iOS (SwiftUI)
- `.accessibilityLabel`, `.accessibilityHint`, `.accessibilityAddTraits(.isButton)` quando preciso.
- Dynamic Type: fontes do sistema (`.font(.body)`), sem tamanho fixo; testar no tamanho de acessibilidade máximo.
- Testar com VoiceOver e com "Aumentar contraste".

## Usabilidade para quem usa pelo celular
- Ação principal ao alcance do polegar; confirmação antes de apagar, com opção de desfazer quando possível.
- Estados vazios explicam o que fazer ("Nenhuma tarefa ainda. Toque em + para criar").
- Carregamento com indicação; falha de rede com mensagem e botão "Tentar de novo".

## Como relatar
Tela/componente → critério (ex.: WCAG 1.4.3 Contraste) → o que acontece → quem é afetado → correção sugerida.
