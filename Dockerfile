FROM ubuntu:24.04
WORKDIR /server

# Instalar unzip
RUN apt update && apt install -y unzip curl

# Baixar e instalar o modpack BMC5
ADD https://mediafilez.forgecdn.net/files/6413/713/BMC5_Server_Pack_v27.zip BMC5.zip
RUN unzip BMC5.zip -d ./ && rm BMC5.zip

# Habilita os scripts
RUN chmod +x install_java.sh
RUN chmod +x start.sh

# Instalar Java
RUN echo "I agree" | ./install_java.sh

# Copiar mods e arquivos de configuração adicionais
COPY eula.txt ./eula.txt

# Expor a porta padrão do servidor Minecraft
EXPOSE 25565

# Comando para iniciar o servidor
CMD ["./start.sh"]
