# Direção de Arte — Ciência Fora de Controle, Episódio 01

Referência artística oficial: `referencias/ref_casal_banco.gif` + folhas de turnaround em `referencias/ref_lucio_turnaround.png`, `ref_amanda_turnaround.png`, `ref_casal_turnaround.png`, `ref_expressoes.png` e `ref_casal_close.gif`.

Este documento substitui qualquer decisão anterior de "low poly básico". A direção agora é **STYLIZED FACETED 3D / POLISHED LOW-POLY CARTOON 3D**.

---

## 1. Resumo do estilo

Um personagem 3D cartoon com corpo e rosto suaves, cabelo construído por **mechas poligonais facetadas**, roupas com dobras geométricas discretas, materiais foscos e iluminação quente de três pontos. Nada é fotorrealista, mas nada é "box art" tampouco — a geometria é intencionalmente baixa onde o brilho da estilização aparece (cabelo, plantas, tecido com drapeado) e densa o bastante onde o cartoon exige fluidez (rosto, mãos, olhos).

Benchmarks mentais: It Takes Two, Luca (Pixar) com quantização poligonal, Overwatch na simplificação de rosto, Astro Bot na leitura de silhueta.

Anti-benchmarks: Roblox, Minecraft, Funko Pop, LEGO, PS1 flat-shaded, protótipo com primitivas.

---

## 2. Paleta (hex aproximados retirados das referências)

| Elemento | Cor | Hex |
|---|---|---|
| Pele dos protagonistas | Pêssego quente médio | `#F2B48C` chave, `#D98464` sombra, `#FFD4B2` highlight |
| Cabelo (ambos) | Castanho terroso em 3 valores | `#7A4028` escuro, `#A05A32` médio, `#C47346` highlight |
| Lábios | Rosa coral desaturado | `#C97362` |
| Olhos (íris) | Marrom chocolate profundo | `#3E2318` |
| Sobrancelhas | Marrom escuro quente | `#4A2B1A` |
| Vestido Amanda | Vermelho carmim saturado | `#C7232A` chave, `#8A1B23` sombra |
| Camisa / calça Lúcio | Preto quente levemente dessaturado | `#1C1A1C` chave, `#2E2A2C` highlight |
| Sandália / tênis | Creme off-white | `#EDE2D2` |
| Fundo de estúdio | Roxo-azulado dessaturado | `#5A5A74` |
| Céu da praça | Azul vívido suave | `#7FB8E0` |
| Vegetação | Verde oliva estilizado em 3 tons | `#4F7A3D`, `#6EA053`, `#8EC26B` |
| Madeira do banco | Marrom caramelo quente | `#A26A3C` |

A regra geral: **nenhuma cor pura**. Tudo tem leve lavagem de calor (um pouco de laranja/âmbar). Preto não é `#000000`. Branco não é `#FFFFFF`. Isso é o que diferencia o visual polido do look low-poly cru.

---

## 3. Proporções

Cabeça-corpo: **~6 a 6,5 cabeças** (ligeiramente estilizado para cima, mas realista o bastante para evitar aparência infantil). Nada de "chibi" 3 cabeças.

### Amanda
- Altura total ~ 1,70m equivalente no mundo.
- Cintura marcada; quadril ligeiramente mais largo que ombro.
- Pescoço esbelto.
- Braços e pernas longos, dedos finos.
- Mãos pequenas (~0,75 da cabeça).
- **Cabelo adiciona ~40% ao volume total do busto quando visto de frente** — é parte fundamental da silhueta.

### Lúcio
- Altura total ~ 1,75m equivalente, um pouco mais alto que Amanda.
- Ombros levemente mais largos que quadril (V discreto, não exagerado).
- Pescoço mais curto que o de Amanda.
- Mãos um pouco maiores (~0,85 da cabeça).
- Cabelo compacto, adiciona ~15% ao volume da cabeça.

### Regra ao posicionar os dois juntos
Topo do cabelo de Amanda ≈ linha do nariz de Lúcio (quando ela está em sandália de salto). Em pé descalça, topo do cabelo de Amanda ≈ linha dos olhos de Lúcio.

---

## 4. Construção facial — a regra mais importante

O rosto é a parte onde é fácil errar e cair em "LEGO / Funko". Para evitar:

### Topologia e shading
- **Rosto com smooth shading obrigatório**. Nenhuma faceta visível no rosto.
- Loops faciais convencionais: um loop ao redor do olho, um ao redor da boca, loops de bochecha, loop de mandíbula.
- Densidade de polígonos: ~3.000–5.000 tris por cabeça (média o suficiente para rig facial sem exagero).
- **Autosmooth 30° + sharp edges só em pálpebra e lábio** para marcar o contorno.

### Formato geral
- **Cabeça arredondada**, não quadrada nem triangular.
- Mandíbula suavemente definida (visível mas não angular).
- Bochechas com volume discreto — Lúcio e Amanda têm as mesmas bochechas cartoon, não emagreça o Lúcio.
- Testa ampla (~1/3 da altura da cabeça acima das sobrancelhas).

### Olhos
- Globo ocular esférico, mas **a íris é um disco plano frontal** com shader de reflexo (não esfera dentro de esfera com refração — isso é custo e não acrescenta no estilo).
- Íris grande: ~55% do diâmetro visível do olho (muito grande para humano real, perfeito para cartoon).
- **Escleróticas levemente off-white** (`#F5EEE4`) — nunca branco puro.
- Reflexo primário: 1 highlight circular pequeno no canto superior da íris + 1 highlight menor diametralmente oposto.
- Pálpebra superior cobre ~15% da íris em expressão neutra (olhar "alerta/vivo").
- Cílios: NÃO modelar fio a fio. Modelar como uma faixa poligonal preta na borda da pálpebra superior (Amanda com faixa um pouco mais grossa).

### Sobrancelhas
- **Modeladas como geometria separada**, grudadas na pele, não texturizadas no plano do rosto.
- Cor `#4A2B1A`, levemente mais escuras nas pontas.
- Formato: Amanda mais arqueada e fina; Lúcio mais reta e um pouco mais grossa.
- São móveis — rig deve controlá-las independentemente.

### Nariz
- Pequeno, estilizado, apenas 3–4 planos visíveis: ponte, lóbulo, duas narinas sutis.
- Lúcio: nariz ligeiramente mais largo e arredondado na ponta.
- Amanda: nariz menor, mais fino, ligeiramente arrebitado.
- **Sem furo de narina visível** (apenas sombra sutil).

### Boca e lábios
- Lábios definidos por geometria, não só pintura.
- Lábio superior mais fino e sombreado; inferior mais cheio e com highlight.
- Linha da boca separada, controlável independente para sorriso.
- Dentes: dois blocos (superior/inferior), não dente a dente. Material branco-creme, não branco pôster.
- Língua: apenas se necessária para visema "L/TH" — bloco rosa simples com SSS fraco.

### Sardas (Amanda, e Lúcio em menor grau)
- 6–8 pintas pequenas no osso malar e ponte do nariz.
- Feitas por **textura procedural** (noise mask → color ramp) sobre o shader da pele, não geometria.
- Opacidade ~40% para manter sutileza.

---

## 5. Cabelo — a assinatura visual do projeto

Esta é a característica mais distintiva do GIF e precisa ser reproduzida com precisão.

### Técnica recomendada
- **Hair cards poligonais**, cada "mecha" sendo um pequeno volume de 6–12 faces com shading facetado (flat shading ou autosmooth 1°).
- Não usar partículas de cabelo do Blender. Não usar curvas. Hair cards manuais.
- Material com **flat shading forçado por fluxo** (não smooth) para preservar o look facetado.

### Amanda (cachos longos, volumosos)
- ~150–250 mechas no total.
- Mechas variam entre 4cm e 15cm de "cacho" visível.
- Direções alternadas: metade cai ligeiramente para trás, metade para os lados (frente nunca cobre o rosto).
- **Três tons alternados**: `#7A4028`, `#A05A32`, `#C47346` — distribuir por material index para variar entre mechas vizinhas (não gradiente, discreto).
- Volume total: cabelo ocupa uma elipse que vai do topo da cabeça até ~15cm abaixo do ombro.
- Silhueta de costas: amplamente mais larga que o ombro, criando a "aura" característica.

### Lúcio (cachos curtos no topo)
- ~40–70 mechas no total.
- Mechas pequenas de 2–4cm.
- Volume concentrado no topo e levemente nas laterais; nuca raspada curtinha.
- Mesma paleta de 3 tons de castanho.
- Hairline discreta e irregular (não corte militar reto).

### Regras compartilhadas
- Uma mecha nunca atravessa outra mecha ou o rosto.
- Autosombra entre mechas é essencial (ambient occlusion local + sombra por luz).
- Nenhuma textura de "fios" — a leitura de cabelo vem da **silhueta poligonal + sombra**, não de textura.

---

## 6. Materiais e shaders

### Pele (ambos)
- Principled BSDF, **Subsurface weight = 0,08** (muito baixo, só para suavizar transição claro/escuro).
- Subsurface color: `#E8907A` (rosado quente).
- Subsurface radius: `(1.0, 0.3, 0.2)` — típico para pele.
- Roughness: 0,55 (fosco, com leve "cera").
- Specular IOR level: 0,35.
- **Sem bump map complexo** — o estilo rejeita poros fotorrealistas. Apenas um noise sutil (strength 0,02) para evitar superfície plástica.

### Cabelo
- Principled BSDF flat shaded.
- Base color variando entre os 3 tons (material slots por mecha).
- Roughness: 0,7 (fosco).
- Specular: 0,15 (brilho sutil nas facetas superiores).
- **Sem transparência**, sem anisotropy.

### Roupas (vestido vermelho, camisa preta)
- Principled BSDF fosco.
- Vestido: roughness 0,45 com ligeiro leve brilho tipo "cetim barato" — não seda brilhante.
- Camisa Lúcio: roughness 0,6 (fosca de verdade).
- Normal map: NÃO. As dobras vêm da geometria facetada mesmo.
- Edges visíveis com autosmooth 20° — queremos ver as facetas aqui.

### Olhos (globo + íris)
- Globo: branco off (`#F5EEE4`), roughness 0,35, specular 0,5.
- Íris: color map chocolate com highlight simulado por emissão baixa (strength 0,15) na faixa superior.
- Córnea: shader de camada transparente, roughness 0,0, IOR 1,4 — pequeno disco frontal, não esfera.

### Metal (relógio, colar, brincos)
- Metalness 1.0, roughness 0,25 (polido mas não espelhado).
- Tint: `#C0C0C0` (prateado frio).

### Tênis/sandália
- Base color `#EDE2D2`.
- Roughness 0,4.
- Sola: material separado com roughness 0,8, mais escura.

---

## 7. Iluminação padrão

### Setup estúdio (para turnarounds e closes)
- **Fundo sólido** `#5A5A74` (plano curvado "cyclorama" ou Hold-Out com cor plana).
- **Key light**: Área 1x1m, 250W equivalente, temperatura 4800K (levemente quente), posição ~45° alto frente-esquerda.
- **Fill light**: Área 2x2m, 60W, temperatura 6500K (fria), posição ~45° frente-direita, mais baixa.
- **Rim light**: Spot, 200W, 3200K (quente), posição atrás-direita, incidindo no cabelo.
- **AO (EEVEE Ambient Occlusion)**: distance 0,3m, fator 0,8.
- **Bloom off** (não combina com o estilo faceted).

### Setup praça (cena 01 e 05)
- **Sun light**: ângulo 55° do zênite, rotação azimute de ~120°, strength 3,0, temperatura 5400K.
- **HDRI** suave de céu azul com nuvens — world background em `#7FB8E0` com gradiente para `#A5CDE5` no horizonte.
- **AO forte** para marcar sombras entre folhas/galhos.
- **Fog** (Volume Scatter) muito sutil para separar planos de profundidade — opcional.

### Setup rua residencial (cena 03)
- Similar à praça, mas com sol mais dourado (temperatura 4200K) sugerindo final de tarde.
- Sombras longas e dramáticas para o pombo espião aparecer.

### Setup cafeteria (cena 05)
- Luz dourada de tarde (3800K).
- Guarda-sóis criam sombras coloridas discretas.

### Setup tribunal (cena 06)
- Luz solene única de cima (spot grande, 5000K).
- Volumétrica sutil visível para dar peso dramático.
- Sombras longas atrás dos pombos no banco.

---

## 8. Render — EEVEE Next (Blender 4.2+/5.3)

### Settings obrigatórios
- **Render engine**: EEVEE (Cycles só se um shot específico pedir vidro/subsuperficial pesado).
- **Resolution**: 1080x1920, 30 fps.
- **Samples**: 64 viewport, 128 render.
- **Ambient Occlusion**: on, distance 0,3, factor 1,0.
- **Bloom**: OFF.
- **Screen Space Reflections**: on, half resolution, trace precision 0,25.
- **Shadows**: Cube size 2048, Cascade size 2048, High bitdepth, soft shadows on.
- **Film > Transparent**: off (background sempre com cor sólida ou HDRI).
- **Color Management**: Standard view transform (não Filmic — Filmic achatar demais os pretos do estilo).
- **Look**: Medium High Contrast.

### Testes preliminares
- Sempre renderizar previews em **540x960 metade da res** para iterar rápido.
- Única exceção: renders finais de personagem turnaround (full res).

---

## 9. Expressões obrigatórias (shape keys ou rig facial)

Cada personagem precisa de:

| Shape key / blendshape | Função |
|---|---|
| `smile_L`, `smile_R` | Canto da boca sobe |
| `frown_L`, `frown_R` | Canto da boca desce |
| `jaw_open` | Abre mandíbula (0 → 1,5cm) |
| `lips_pucker` | Lábios fechados projetados |
| `lips_wide` | Lábios esticados |
| `cheek_puff_L/R` | Bochecha infla |
| `brow_up_L/R` | Sobrancelha sobe |
| `brow_down_L/R` | Sobrancelha desce (bravo) |
| `brow_inner_up` | Pontas internas sobem (triste/preocupado) |
| `eye_wide_L/R` | Olho arregalado |
| `eye_squint_L/R` | Olho semicerrado |
| `blink_L/R` | Pálpebra fecha |
| `nose_wrinkle` | Franze o nariz |
| `viseme_AA` | Boca aberta "A" |
| `viseme_EE` | Boca esticada "E" |
| `viseme_OO` | Boca redonda "O" |
| `viseme_FV` | Lábio inferior toca dente |
| `viseme_MBP` | Lábios fechados (M, B, P) |
| `viseme_TH` | Língua entre dentes |

Combinações pré-definidas por emoção:
- **Feliz** = `smile_L + smile_R + eye_squint_L*0.3 + eye_squint_R*0.3`
- **Sarcástico (Amanda)** = `smile_R*0.4 + brow_up_R*0.6 + eye_squint_L*0.5`
- **Assustado (Lúcio)** = `jaw_open*0.8 + eye_wide_L*1.0 + eye_wide_R*1.0 + brow_up_L + brow_up_R`
- **Constrangido (Lúcio)** = `smile_L*0.3 + smile_R*0.3 + brow_up_L + cheek_puff_L*0.2`
- **Revirando olhos (Amanda)** = pose keyframe de olhos subindo + `brow_up_L + brow_up_R`

---

## 10. Rigging corporal

- **Rigify** (built-in do Blender) com metarig humano, ajustado às proporções dos personagens.
- IK/FK switch em braços e pernas (Rigify já fornece).
- Controles de dedos simplificados (IK de ponta de dedo + rotação de falange média).
- Rig facial separado por bones (não só shape keys) para olhos, mandíbula e cabeça.
- Rig de cabelo: **apenas 2–3 bones de JIGGLE** no Amanda para permitir leve movimentação secundária das mechas durante caminhada e virada de cabeça. Não rig completo por mecha.

Em `~/.claude/skills/3d-animator-skill/` tem toda a receita de rigging para scanned/generated, incluindo validação de topologia e teste de poses de stress. Usar como base.

---

## 11. Cenários — estilo consistente

Todos os cenários seguem a mesma lógica: **geometria facetada visível + materiais polidos + iluminação quente**.

### Praça (cenário A)
- Calçada: planos grandes com grid de 60cm, textura procedural sutil de granito/concreto.
- Árvores: tronco com ~8 lados; folhagem composta por 5–8 esferas poligonais sobrepostas, cada uma com 8–12 faces.
- Bancos de praça: 4 pernas de ferro + 3 ripas de madeira — modelo baixo-poli mas legível.
- Lanchonete ao fundo: fachada estilizada, janela única com toldo colorido.
- Pedestres secundários: silhuetas simplificadas (tipo recorte poligonal), não detalhados.

### Rua residencial (cenário B)
- Casas: box com telhado triangular, 2–3 janelas, 1 porta — não detalhar paredes.
- Postes de luz: cilindro + lâmpada esférica.
- Carros estacionados: forma de carrinho com ~200 tris.
- Céu: gradiente vertical do azul claro ao cyan pálido.

### Cafeteria (cenário C)
- Mesa redonda + 2 cadeiras.
- Guarda-sol listrado (geometria setorizada).
- Vegetação em vasos (3 plantas).
- Pedestres desfocados: usar DOF do EEVEE, não modelos detalhados.

### Tribunal (cenário D)
- Bancada do juiz elevada, com decoração mínima.
- Fileiras de bancos de madeira — instance array.
- Fotografia do réu em moldura.
- Peruca do juiz: esferoide branco com cachos facetados (como o cabelo da Amanda, mas branco).
- Iluminação: um único spot cenital dramático.

---

## 12. O que NÃO fazer

Lista de anti-padrões para o modelador não cair neles:

- ❌ Rosto triangulado como se fosse low-poly PS1.
- ❌ Olhos como esferas lisas sem íris; ou esferas com refração complexa.
- ❌ Cabelo como capacete único de geometria sólida.
- ❌ Cabelo com textura fotográfica de fios.
- ❌ Dentes como blocos retangulares cinza.
- ❌ Lábios pintados no plano do rosto (sem geometria).
- ❌ Roupa como mesh colada ao corpo sem drapeado.
- ❌ Pele pura `#FFC0A0` sem variação (precisa de SSS e specular sutil).
- ❌ Fundo preto puro em nenhuma cena.
- ❌ Specular 1.0 em qualquer material fora metal.
- ❌ Smooth shading no cabelo (destrói o estilo).
- ❌ Flat shading no rosto (vira LEGO).
- ❌ Luz única sem fill nem rim.
- ❌ Olhos sem highlight circular pequeno.
- ❌ Sobrancelha texturizada no plano em vez de geometria.

---

## 13. Fluxo de validação

Para cada personagem, antes de declarar "aprovado para animar":

1. Render 1080x1920 do turnaround (frente / perfil / 3/4 / costas) em fundo `#5A5A74`.
2. Render de close do rosto em neutro + 3 expressões (feliz, susto, reviro-de-olho).
3. Comparar lado a lado com `referencias/ref_{lucio,amanda}_turnaround.png`.
4. Checklist de semelhança:
   - [ ] Formato geral de cabeça bate com referência
   - [ ] Proporção olho/nariz/boca correta
   - [ ] Cabelo tem a quantidade e direção certa de mechas
   - [ ] Cor de pele e sardas presentes
   - [ ] Expressões mostram toda a amplitude emocional
   - [ ] Silhueta de costas tão legível quanto a de frente
   - [ ] Nenhum anti-padrão da seção 12 presente

Se qualquer item falhar, voltar ao modelador. Não avançar para a próxima etapa.

---

## 14. Requisitos de execução

Nada neste documento é produzível sem Blender 5.3 rodando em uma máquina com GPU decente. O container atual não tem Blender; o fluxo é:

1. Usuário conecta máquina Windows via Remote Control.
2. Claude usa skills `blender-skills` + `3d-animator-skill` para dirigir Blender 5.3 remoto.
3. Scripts Python em `scripts/` executam em modo headless ou via MCP conforme a tarefa.
4. Renders de preview em `renders/previews/`, finais em `renders/final/`.

Até lá, este documento + estrutura de pastas + referências extraídas servem como **briefing executável** para quando o ambiente estiver completo.
