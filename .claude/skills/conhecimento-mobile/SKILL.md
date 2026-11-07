---
name: conhecimento-mobile
description: "Manual de apps Android e iOS da equipe do ENGENHEIRO IA: arquitetura, ciclo de vida, offline, permissões, desempenho, armazenamento seguro e regras das lojas. Carregado no arquiteto e nos desenvolvedores de apps."
user-invocable: false
---

# Manual de apps móveis (equipe do ENGENHEIRO IA)

## Arquitetura
- Camadas: **tela (UI)** → **estado (ViewModel / @Observable)** → **repositório** → **fontes de dados** (rede, banco local).
- Estado da tela imutável e com casos explícitos: carregando, conteúdo, vazio, erro.
- Uma única fonte da verdade: a tela lê do repositório; o repositório decide entre cache e rede.
- Injeção de dependências simples (construtor) para conseguir testar com dados falsos.

## Ciclo de vida e dados do usuário
- Girar a tela, ir para segundo plano e voltar, ou o sistema fechar o app não pode perder o que o usuário digitou (Android: `SavedStateHandle`/`rememberSaveable`; iOS: `@SceneStorage` ou estado persistido).
- Trabalho em segundo plano: Android `WorkManager`; iOS `BackgroundTasks`. Nada de trabalho longo na thread principal.

## Offline primeiro (o usuário pode estar na estrada)
- Salvar localmente primeiro (Room/SQLite, SwiftData/Core Data) e sincronizar depois, com fila de envio e nova tentativa.
- Mostrar quando os dados estão desatualizados ou não enviados.
- Resolver conflitos com uma regra clara (ex.: última alteração vence, registrada em `DECISOES.md`).

## Permissões
- Pedir só quando a função é usada, com explicação antes do pedido do sistema.
- Funcionar de forma reduzida se a permissão for negada.
- Localização: preferir "durante o uso"; localização em segundo plano exige justificativa forte nas lojas.

## Desempenho e bateria
- Listas grandes com `LazyColumn` / `List` e itens com chave estável.
- Imagens redimensionadas e em cache.
- Evitar consultas e cálculos repetidos a cada recomposição/renderização.

## Armazenamento seguro
- Tokens e dados sensíveis: Android `EncryptedSharedPreferences`/Keystore; iOS Keychain.
- Nada sensível em logs, capturas de tela de tarefas recentes ou notificações.
- HTTPS sempre; sem desativar validação de certificado.

## Testes
- Android: JUnit para ViewModel e repositório; Compose UI Test para telas; `./gradlew test`.
- iOS: XCTest ou Swift Testing; testes de UI com XCUITest; precisa de macOS com Xcode.
- Sem SDK no ambiente: não inventar resultado; registrar como pendência e passar o passo a passo ao responsável.

## Lojas (sempre ponto de aprovação)
- Publicar, mudar ficha da loja, preço ou assinatura é decisão do responsável.
- Exigências comuns: política de privacidade com link, declaração de dados coletados (Play: Segurança dos dados; Apple: Privacy Nutrition Label), opção de excluir a conta quando há cadastro, permissões justificadas.
- Confirmar requisitos atuais na documentação oficial das lojas antes de afirmar algo (as regras mudam).
