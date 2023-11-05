#!/bin/bash

# Diretório de entrada (onde estão os vídeos originais)
input_dir=$PWD/video
echo $input_dir

# Diretório de saída (onde os vídeos compactados serão salvos)
output_dir="/home/mgarcia/mergulho"

# Verifique se o diretório de saída existe; se não, crie-o
if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
fi

# Loop para processar cada arquivo de vídeo na pasta de entrada
for video_file in "$input_dir"/*.mp4; do
  if [ -f "$video_file" ]; then
    # Nome do arquivo de saída na pasta de saída
    output_file="$output_dir/$(basename "$video_file")"

    # Comando ffmpeg para comprimir o vídeo (ajuste os parâmetros conforme necessário)
    # + CRF significa mais compactação e menos qualidade. 36 é razoável.
    # Atente que quanto mais compactação maior uso de processador e portanto mais demorado é.
    # Essa chamada já utiliza todas as threads disponíveis.
    # Obviamente você precisa do ffmpeg pra rodar o script ( sudo apt-get install ffmpeg )
    ffmpeg -i "$video_file" -c:v libx264 -crf 36 -c:a aac -strict experimental -vf "fps=15" -b:v 500K "$output_file"
    
    echo "Vídeo comprimido: $output_file"
  fi
done

echo "Compactação de vídeos MP4 concluída."
