# Status do projeto — Ciência Fora de Controle, Episódio 01

Última atualização: 2026-11-23

## O que está pronto

### Skills instaladas em `~/.claude/skills/`
30 skills Blender ativas (verificado pelo discovery automático do Claude Code):

**EL4CTEO/blender-skills (28 skills)** — pipeline completo
- `blender-core` (ponto de entrada, rotea para as outras)
- Modelagem: `blender-hardsurface-modeling`, `blender-sculpting`, `blender-retopology-uv`, `blender-geometry-nodes`
- Materiais: `blender-pbr-materials`, `blender-texturing`, `blender-texture-baking`
- Personagem: `blender-character-rigging`, `blender-facial-shapekeys`, `blender-clothing`, `blender-hair-grooming`
- Animação: `blender-animation`
- Cena: `blender-scene-setup`, `blender-environment-kits`, `blender-time-of-day`, `blender-weather-fx`, `blender-lighting-lookdev`
- Render: `blender-rendering`, `blender-stylized-npr`, `blender-video-editing`
- Export: `blender-export-pipelines`, `blender-game-optimization`, `blender-asset-qa`
- Automação: `blender-pipeline-automation`, `blender-addon-development`, `blender-simulation`, `blender-workflow-recipes`

**studioigor/3d-animator-skill** — rigging, retargeting mocap, lip sync ARKit (`3d-animator`)
**DisturbedMediaGroup/claude-animation-skill** — cinematografia de câmera e timing (`animation-direction`)

Instalação feita via `git clone` + symlinks. **Sem rodar install.sh** conforme sua autorização. Reversível com `rm ~/.claude/skills/blender-*` (os simbólicos) e `rm -rf ~/.claude/skills/{blender-skills,3d-animator-skill,claude-animation-skill}`.

### Estrutura do projeto em `/home/user/Blender-/`
```
Blender-/
├── referencias/         ← 6 imagens + 2 GIFs + frames extraídos do GIF principal
├── personagens/{modelos, texturas, rigs}
├── cenarios/{praca, rua, cafeteria, tribunal}
├── animacoes/cenas
├── audio/{vozes, efeitos, musicas}
├── renders/{previews, final}
├── scripts/            ← scripts bpy prontos para executar
├── docs/               ← DIRECAO_ARTE.md, HANDOFF, estes STATUS.md
└── STATUS.md
```

### Documentos entregues
- `docs/DIRECAO_ARTE.md` — direção de arte completa no estilo **Stylized Faceted 3D / Polished Low-Poly Cartoon 3D** (paleta, proporções, construção facial, cabelo, materiais, iluminação EEVEE, rigging, expressões, cenários, 14 seções).
- `docs/HANDOFF_CLAUDE_CODE.md` — handoff original preservado.
- `scripts/smoke_test.py` — script de validação do pipeline (ver seção "Como validar").

### Ambiente
- Python 3.13, ffmpeg 6.1, uv, git, node 22: instalados ✅
- Blender: **não instalado neste container** ❌
- GPU: nenhuma ❌
- Blender MCP: não há servidor Blender rodando acessível a esta sessão ❌

## O bloqueio

Este é um container Linux na nuvem. Não tem Blender nem GPU. Para produzir qualquer `.blend`, render ou vídeo eu preciso dirigir o seu Blender 5.3 no Windows — e para isso sua máquina precisa estar conectada via **Remote Control**.

**Próximo passo seu (nessa ordem):**

### 1. Conectar sua máquina Windows
1. Abra o Claude Desktop no seu Windows.
2. Vá em Settings → Claude Code → Remote Control.
3. Ative Remote Control.
4. Compartilhe a pasta onde você quer o projeto (sugestão: `Documentos\CienciaForaDeControle`).
5. Me avise que conectou.

Depois disso eu vou enxergar sua pasta e poder:
- Copiar este projeto todinho (skills, docs, scripts) para o Windows.
- Rodar Blender 5.3 via subprocess do seu lado.
- Dirigir o viewport em tempo real se você tiver o `blender-mcp` rodando.

### 2. Instalar Blender MCP (opcional mas recomendado)
No PowerShell do Windows, uma vez só:
```powershell
# UV
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
# blender-mcp (servidor MCP que expõe seu Blender ao Claude)
uvx blender-mcp
```

Depois no Blender 5.3 → Edit → Preferences → Add-ons → procure "Blender MCP" e ative. Isso me permite executar comandos bpy ao vivo no seu viewport em vez de só rodar headless.

### 3. Sem o Blender MCP (fallback)
Mesmo sem o MCP ao vivo, eu consigo:
- Escrever scripts Python em `scripts/`.
- Dizer exatamente o comando (`blender -b arquivo.blend -P scripts/X.py`).
- Analisar renders que você gerar e me mandar.

É mais lento mas funciona.

## Como validar o pipeline (quando Blender conectar)

Com o Blender 5.3 rodando, execute:
```bash
blender -b -P scripts/smoke_test.py -- --out renders/previews/smoke_test.png
```

O script cria uma esfera com shader de pele estilizada, luz 3 pontos no padrão do `DIRECAO_ARTE.md`, renderiza em EEVEE 540x960 e grava `smoke_test.png`. Se isso roda sem erro, o pipeline está pronto para os personagens.

## Comandos de uso das skills (uma vez tudo conectado)

Pede ao Claude Code (nesta sessão ou outra) em linguagem natural:

### Personagens (Etapa B do briefing)
> "Modele o Lúcio seguindo `docs/DIRECAO_ARTE.md` e as referências. Produza turnaround de 4 ângulos + 3 expressões em `renders/previews/lucio_v01/`."

Isso vai acionar: `blender-core` → `blender-scene-setup` → `blender-hardsurface-modeling` + `blender-sculpting` → `blender-hair-grooming` → `blender-character-rigging` → `blender-facial-shapekeys` → `blender-lighting-lookdev` → `blender-rendering` → `blender-asset-qa` (checklist da seção 13 do DIRECAO_ARTE).

Mesma coisa para Amanda. Mesmo arquivo `DIRECAO_ARTE.md` mantém consistência.

### Vozes (Etapa C)
As 15 falas estão listadas no HANDOFF. Com a conta ElevenLabs conectada, esta sessão já pode gerar os WAVs — pedir:
> "Gere os 15 WAVs de voz conforme `docs/HANDOFF_CLAUDE_CODE.md` seção 'Vozes', salvando em `audio/vozes/`."

### Animação (Etapa D)
> "Para a cena 04 use `3d-animator` para lip-sync do áudio `audio/vozes/c04_lucio_01.wav` sobre o rig facial do Lúcio. Depois use `animation-direction` para configurar a câmera de perseguição em 35mm com arco."

### Cenários e render final (Etapas D/E)
Usar `blender-environment-kits` + `blender-time-of-day` para os 4 ambientes. Render final em EEVEE 1080x1920 30fps com `blender-rendering`. Montagem com `blender-video-editing` + FFmpeg (seus loudness targets -14 LUFS / -1 dBTP).

## O que NÃO foi feito (e por quê)

- ❌ Modelagem dos personagens — requer Blender
- ❌ Teste animado de 5 segundos — requer Blender + áudio
- ❌ Extração detalhada de todos os frames do GIF — fiz 9 do banco e 9 do close, suficiente para a direção. Posso extrair mais se precisar.
- ❌ Instalação do MCP for Blender — é na sua máquina Windows, não no container
- ❌ Geração de vozes — reservado para depois de validar personagens (Etapa C do briefing)
