# Handoff — Ciência Fora de Controle, Ep. 01: "Nunca arrume briga com um pombo"

Contexto para continuar no Claude Code (que tem o Blender MCP conectado ao Blender 5.3 no Windows).

## Arquivos que acompanham este handoff
- `briefing_episodio01.txt` — briefing completo (roteiro, direção de arte, voz, câmera, áudio, legendas, exportação). É a especificação oficial.
- `ref_lucio_turnaround.png` — Lúcio em 8 ângulos + close.
- `ref_amanda_turnaround.png` — Amanda em 8 ângulos + close.
- `ref_casal_turnaround.png` — os dois juntos, vários ângulos + praça.
- `ref_expressoes.png` — expressões faciais dos dois (sorriso, sarcasmo, susto, dúvida).
- `ref_casal_close.gif`, `ref_amanda_corpo.gif`, `ref_banco_praca.gif` — imagens extras.

**Essas folhas de personagem são as referências oficiais.** As fotos reais e o vídeo do TikTok citados no briefing (`referencias/504515.jpg` etc. e `508632.mp4`) não serão fornecidos — ignorar.

## Decisões já tomadas
- **Estilo visual:** low poly facetado, estilo das folhas de referência (cabelo em blocos poligonais marrons, pele lisa estilizada, olhos grandes expressivos, roupas com facetas visíveis). Não buscar fotorrealismo.
- **Lúcio:** camisa preta de botão com mangas dobradas, calça preta, cinto, relógio no pulso esquerdo, tênis branco, cabelo castanho cacheado curto/médio.
- **Amanda:** vestido longo vermelho tomara que caia com fenda, sandália clara de tiras, colar e brincos prateados, cabelo castanho longo e muito volumoso cacheado, sardas leves.
- **Render:** Blender 5.3 + Eevee. Testes em baixa resolução antes do final. Final 1080×1920, 30 fps, H.264, AAC 48 kHz.
- **Entregas:** a pasta do projeto pode ser criada pelo Claude Code onde fizer sentido (sugestão: `Documentos\CienciaForaDeControle`, com a estrutura de pastas do item 13 do briefing).

## Ciência verificada
Belguermi et al. (2011), *Animal Cognition* 14:909–917 — "Pigeons discriminate between human feeders" (PubMed 21647649). Pombos de rua em um parque de Paris passaram a evitar a pesquisadora que os espantava e continuaram evitando-a mesmo quando as duas pesquisadoras trocaram de jaleco. Provavelmente reconheciam pelo rosto.
- Narração do roteiro está correta.
- Ajuste na cena 2: no estudo, a outra pessoa **não alimentava** os pombos de forma especial, apenas os **ignorava** (neutra). Ilustrar como "uma pessoa neutra × uma que espanta".

## Vozes (ElevenLabs, conta gratuita, ~32 mil caracteres livres, roteiro usa ~600)
Modelo: `eleven_v4`, 1 take por fala. Na última tentativa o plano gratuito retornou "busy" — nada foi gerado nem cobrado.

| Personagem | Voz | voice_id |
|---|---|---|
| Narrador | Thiago – Charismatic and Upbeat | `Xe4F5v1n6BCIxcAlTJww` |
| Lúcio | Lucas – Engaging, Captivating and Kind | `7lu3ze7orhWaNeSPowWx` |
| Amanda | Larissa Vasconcelos | `E8coQI8QJIMu5Hxt4hIx` |
| Pombo espião / de terno | Nassif – Documentary | `acdKA5HckGxoxxvy40dA` |
| Pombo juiz | Leonardo – Deep & Resonant (reverb na pós) | `4XmhZ74tBbUVCXIYNMMo` |

Lista de falas (um arquivo WAV 48 kHz por fala):
1. `c01_lucio_01` — "Sai daqui, seu rato com asa." (irritado)
2. `c01_amanda_01` — "Deixa o bicho, doido." (seca)
3. `c02_narrador_01` — "Tu sabia que pombo consegue reconhecer pessoas? Inclusive aquelas que ficam enchendo o saco dele!"
4. `c02_narrador_02` — "E trocar de roupa não é garantia de enganar o bicho!"
5. `c03_lucio_01` — "Agora quero ver aquele desgraçado me reconhecer." (confiante)
6. `c03_pombo_01` — "É ele." (grave, frio)
7. `c04_narrador_01` — "Mas a ciência não disse que eles organizam uma facção. ESSA PARTE AQUI JÁ É OUTRA HISTÓRIA!"
8. `c04_lucio_01` — "AMANDA! PELO AMOR DE DEUS!" (desesperado)
9. `c05_lucio_01` — "AMOR, OS POMBO TÃO ATRÁS DE MIM!" (apavorado)
10. `c05_amanda_01` — "Eu avisei." (sem surpresa)
11. `c05_pombo_02` — "A senhora conhece o indivíduo?"
12. `c05_amanda_02` — "Infelizmente." (seca, pausa antes)
13. `c06_juiz_01` — "O réu tem algo a declarar?" (solene)
14. `c06_lucio_01` — "Eu só queria comer meu pastel..." (quase chorando)
15. `c06_juiz_02` — "CAGUEM!" (gritando)

## Próximos passos (ordem do briefing)
1. Confirmar conexão com o Blender MCP.
2. **Etapa B — personagens:** modelar Lúcio e Amanda low poly seguindo as folhas; renderizar frente, perfil e 3/4 lado a lado com as referências; testes de cabelo, material e expressões (shape keys de visemas + sobrancelhas + piscar); rig básico. Mostrar prévias ao Lucio antes de seguir.
3. **Etapa C:** gerar as 15 falas, montar timeline e animatic com a duração real das falas.
4. **Etapa D:** cenários (praça, rua residencial, cafeteria, tribunal dos pombos), pombos, câmeras, lip sync a partir dos WAVs, renders de teste por cena.
5. **Etapa E/F:** montagem com FFmpeg, legendas amarelas com contorno preto, mixagem (-14 LUFS, -1 dBTP), revisão completa.

Não declarar nada pronto sem render de verificação.
