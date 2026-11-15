---
name: conhecimento-estrategia
description: "Manual de estratégia e finanças da equipe do ENGENHEIRO IA para o CEO: Jobs to be Done, Lean Canvas, estrela-guia, concorrência, cenários financeiros, preço no Brasil (Pix, taxas, impostos), decisão sob incerteza e memorando de decisão."
user-invocable: false
---

# Manual de estratégia e finanças (equipe do ENGENHEIRO IA)

## 1. Entender o cliente: Jobs to be Done
- Escreva o trabalho que o cliente quer realizar: "Quando [situação], eu quero [motivação], para que [resultado]".
- Separe as dimensões funcional (o que precisa ser feito), emocional (como quer se sentir) e social (como quer ser visto).
- Ache a **solução atual** que o produto substitui (planilha, caderno, WhatsApp, concorrente) e o que faria o cliente trocar.

## 2. Lean Canvas (uma página)
Problema (os 3 principais) · Segmento de clientes e primeiros adotantes · Proposta de valor única · Solução · Canais · Receitas · Custos · Métricas-chave · Vantagem injusta (o que é difícil copiar).
Use para checar se o pedido fortalece alguma caixa fraca do negócio.

## 3. Métrica estrela-guia
- Uma métrica que captura o valor entregue ao cliente e antecipa a receita (ex.: fretes fechados por semana, imóveis visitados por lead, vídeos publicados por mês).
- Cada pedido deve mover a estrela-guia ou uma métrica de entrada dela (ativação, frequência, retenção, conversão).
- Funil AARRR: Aquisição → Ativação → Retenção → Receita → Indicação. Ache o gargalo e priorize o que o resolve. Retenção baixa torna aquisição desperdício.

## 4. Concorrência e posicionamento
- Pesquise (WebSearch) de 3 a 5 alternativas reais, incluindo a "não solução" (fazer na mão). Compare preço, público, ponto forte e ponto fraco; cite as fontes e a data da consulta.
- Posicione pela diferença que importa ao cliente, não pela lista de funções.
- Barreiras de defesa: dados próprios, rede de usuários, integração com o dia a dia, marca local, custo de troca.

## 5. Modelagem financeira simples (faça as contas)
- Faça os cálculos de verdade (por exemplo com `node -e` ou `python3 -c`) e mostre a fórmula; nunca chute o resultado.
- **Por cliente:** receita mensal média (ARPU); custo variável (servidores, APIs, IA, SMS, taxas de pagamento); margem de contribuição.
- **CAC** (custo para conquistar um cliente) e **LTV** (margem mensal ÷ churn mensal). Saudável: LTV ≥ 3 × CAC e CAC recuperado em até 12 meses.
- **Ponto de equilíbrio:** custos fixos mensais ÷ margem de contribuição por cliente = clientes necessários.
- **Três cenários** (pessimista, realista, otimista) com as premissas escritas; destaque a premissa que mais mexe no resultado (análise de sensibilidade).
- Valores em reais; quando a fonte for em dólar, informe a cotação usada e a data.

## 6. Preço e cobrança no Brasil
- Formas comuns: Pix (taxa baixa ou zero), boleto, cartão de crédito (taxa e parcelamento), assinatura recorrente; compare taxas atuais dos provedores pesquisando a fonte oficial.
- Lojas de apps cobram comissão em compras digitais dentro do app; verifique a regra atual antes de propor preço.
- Impostos: MEI tem limite de faturamento anual e atividades permitidas; Simples Nacional tem alíquotas por faixa. Apenas sinalize o tema e recomende contador; não dê parecer tributário.
- Preço por valor percebido (quanto o cliente economiza ou ganha), testado com poucos clientes antes de fixar.

## 7. Decisão sob incerteza
- Classifique a decisão: **porta de mão dupla** (reversível, decida rápido) ou **porta de mão única** (irreversível, aprofunde e peça aprovação).
- **Valor esperado:** probabilidade × impacto para cada cenário; prefira opções com perda limitada e ganho grande.
- **Custo de oportunidade:** o que deixa de ser feito se a equipe fizer isto.
- **Advogado do diabo:** escreva o melhor argumento contra a sua recomendação e responda a ele.
- **Pré-mortem de negócio:** "daqui a 6 meses isto fracassou: por quê?". Liste as 3 causas mais prováveis e como evitar.
- **Opção de aprendizado:** quando a incerteza é alta, recomende o experimento mais barato que reduz a dúvida (página de interesse, protótipo, 5 entrevistas, versão manual).

## 8. Memorando de decisão (como apresentar)
1. Recomendação em uma frase.
2. Por que agora (o problema e o custo de não fazer).
3. Opções consideradas (pelo menos 2, incluindo "não fazer") com prós, contras e custo.
4. Números-chave com fonte ou "estimativa".
5. Riscos e como mitigar.
6. O que precisa da decisão do responsável.
7. Como saberemos que deu certo (métrica e prazo).
