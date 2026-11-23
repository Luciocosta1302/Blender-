# Ciência Fora de Controle — Episódio 01

Vídeo 3D animado de humor científico. Protagonistas Lúcio e Amanda em estilo **Stylized Faceted 3D / Polished Low-Poly Cartoon 3D**.

## Comece por aqui

- `STATUS.md` — estado atual do projeto e próximos passos
- `docs/DIRECAO_ARTE.md` — direção de arte completa (vinculante)
- `docs/HANDOFF_CLAUDE_CODE.md` — handoff original com decisões técnicas e lista de falas
- `referencias/briefing_episodio01.txt` — briefing completo do episódio

## Estrutura

Pastas organizadas conforme seção 13 do briefing: `referencias/`, `personagens/`, `cenarios/`, `animacoes/`, `audio/`, `renders/`, `scripts/`, `docs/`.

## Pipeline

1. **Pré-produção**: feita (este commit)
2. **Personagens**: bloqueado em Blender — ver `STATUS.md`
3. **Vozes**: ElevenLabs via MCP (voices já pré-selecionadas no HANDOFF)
4. **Animação**: pelas skills `blender-animation`, `3d-animator`, `animation-direction`
5. **Render**: EEVEE Next 1080x1920 30fps
6. **Pós**: FFmpeg + legendas amarelas

## Teste de pipeline

```bash
blender -b -P scripts/smoke_test.py -- --out renders/previews/smoke_test.png
```
