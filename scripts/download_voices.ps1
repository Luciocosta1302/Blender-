# Baixa as vozes geradas no ElevenLabs para audio/vozes/
# URLs expiram em algumas horas - rodar logo apos push.
#
# Uso:
#   cd $HOME\Documents\CienciaForaDeControle
#   powershell -ExecutionPolicy Bypass -File .\scripts\download_voices.ps1
#
# Gerado em 2026-11-23. Expira 1795467600 (unix).

$ErrorActionPreference = "Stop"
$ExpiresUnix = 1795467600

$nowUnix = [int][double]::Parse((Get-Date -UFormat %s))
if ($nowUnix -gt $ExpiresUnix) {
    Write-Host "[ERRO] URLs expiraram. Rode novamente a geracao no Claude da nuvem." -ForegroundColor Red
    exit 1
}

$outDir = Join-Path $PSScriptRoot "..\audio\vozes"
New-Item -ItemType Directory -Path $outDir -Force | Out-Null

$voices = @(
    @{ name = "c01_lucio_01";    url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/EkZgCKZ8SwafQYTTkueK/KRCMnp85vM71srYSPh3B/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=DIB4znVPRLCwpCluQtdBqr-Gw1w="; text = "Sai daqui, seu rato com asa." },
    @{ name = "c01_amanda_01";   url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/HMiTINjqMgR9wQlqEyha/8ISFtd5jxvRL18loFaNr/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=WjrccpanhH9z1t_vaAUG6hliMWA="; text = "Deixa o bicho, doido." },
    @{ name = "c02_narrador_01"; url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/lZzvdJbniYolNoy1t0q7/h5Mmxg2CiLt0IM5SVyfX/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=dHxQL8PXihTUMwu-x6yYVvee5HA="; text = "Tu sabia que pombo consegue reconhecer pessoas..." },
    @{ name = "c02_narrador_02"; url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/o4PbX3dbxXS7ksagoNlG/V2ELbsVtkzQ0iyPVl9AA/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=zrROOggIa_ULw1yHH1W_BW3QQCA="; text = "E trocar de roupa nao e garantia de enganar o bicho!" },
    @{ name = "c03_lucio_01";    url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/n8MyPSraUrskv6wAR9Pi/UezvcasLSKiVgMw110xL/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=ng7rI5DEsJ1HFKkcEfkDzjvAf1k="; text = "Agora quero ver aquele desgracado me reconhecer." },
    @{ name = "c03_pombo_01";    url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/GM02NJVSMrhhDI3Q95Tc/1mNW4Gmr0AsvEIbdOy0J/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=JDvTI_h30PTmeRGKYxkjyhoS050="; text = "E ele." },
    @{ name = "c05_lucio_01";    url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/dT6aDIFpw50GN2ulym3B/kmKOMJcWXtelKr7n1wqv/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=nyETHhbKyL1wCpOoHv7pMQFby18="; text = "AMOR, OS POMBO TAO ATRAS DE MIM!" },
    @{ name = "c05_amanda_01";   url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/w7Ymx5cZKNcFULmLDlGh/YZjX8f2IG083x9200T0R/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=Hq1ueEG5LR0NDAvxC9MoHHTHRLE="; text = "Eu avisei." },
    @{ name = "c05_pombo_02";    url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/9xyoSojmkRkGNXVmPVd9/4aJwO4EqApqfHoaldHqT/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=SyiPr40SBxvFzlEp-w_Uj5CRJZc="; text = "A senhora conhece o individuo?" },
    @{ name = "c05_amanda_02";   url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/5nKzTHTNjaE7elYlK78o/kf4DE4CaIbWPzzgqr296/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=I5C7AGreqyxjzoss0gFck6_eoCQ="; text = "...Infelizmente." },
    @{ name = "c06_juiz_01";     url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/33w8I3kIUMZu6IIwDCVZ/Ky8i9AlM5FcYc1NBxYoO/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=N9dx-lBM7mg60zIGTRxgvid79HE="; text = "O reu tem algo a declarar?" },
    @{ name = "c06_lucio_01";    url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/ESTXEGdHi6ha35eJSLJU/asUkYnEHCVOHHyQzkmSl/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=CSFtM7tLPll2qUwUMu1s7CvCRfc="; text = "Eu so queria comer meu pastel..." },
    @{ name = "c06_juiz_02";     url = "https://elevenlabsusercontent.com/database/workspace/3229f548394b4117ad7d7e307ae3bc36/content_generation/zCdZMRBxprB7oqejYmaV/bsFw5JyjW77IHjW88Biu/content.mp3?Expires=1795467600&KeyName=assets-cdn-key-1&Signature=qpjtR63C9T8GPzfOTYimsnfizdM="; text = "CAGUEM!" }
)

$ok = 0
$fail = 0
foreach ($v in $voices) {
    $out = Join-Path $outDir ($v.name + ".mp3")
    Write-Host "[dl] $($v.name) - $($v.text)" -ForegroundColor Cyan
    try {
        Invoke-WebRequest -Uri $v.url -OutFile $out -UseBasicParsing
        $size = (Get-Item $out).Length
        Write-Host "     OK ($size bytes)" -ForegroundColor Green
        $ok++
    } catch {
        Write-Host "     FAIL: $_" -ForegroundColor Red
        $fail++
    }
}

Write-Host ""
Write-Host "=== $ok baixadas, $fail falhas ===" -ForegroundColor Cyan
Write-Host "Falta gerar: c04_narrador_01 (facao/historia) e c04_lucio_01 (AMANDA! PELO AMOR DE DEUS!)" -ForegroundColor Yellow
