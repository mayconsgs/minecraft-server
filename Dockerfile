FROM openjdk:21-jdk-slim

ENV MINECRAFT_VERSION=1.21.1
ENV MODLOADER=NeoForge
ENV MODLOADER_VERSION=21.1.133
ENV LEGACYFABRIC_INSTALLER_VERSION=1.0.0
ENV FABRIC_INSTALLER_VERSION=1.0.3
ENV QUILT_INSTALLER_VERSION=0.12.1
ENV RECOMMENDED_JAVA_VERSION=1.21.0-4
ENV JAVA_ARGS="-Xmx4G -Xms4G"
ENV JAVA="java"
ENV WAIT_FOR_USER_INPUT=true
ENV ADDITIONAL_ARGS=-Dlog4j2.formatMsgNoLookups=true
ENV RESTART=true
ENV SKIP_JAVA_CHECK=false
ENV JDK_VENDOR=graalvm
ENV JABBA_INSTALL_URL_SH=https://github.com/Jabba-Team/jabba/raw/main/install.sh
ENV JABBA_INSTALL_URL_PS=https://github.com/Jabba-Team/jabba/raw/main/install.ps1
ENV JABBA_VERSION=0.13.0
ENV SERVERSTARTERJAR_FORCE_FETCH=true
ENV SERVERSTARTERJAR_VERSION=latest
ENV USE_SSJ=true

WORKDIR /server

# Baixar Forge installer para a versão 1.21.1
# ADD https://maven.neoforged.net/releases/net/neoforged/neoforge/21.1.168/neoforge-21.1.168-installer.jar neoforge-installer.jar
# RUN java -jar neoforge-installer.jar --installServer && rm neoforge-installer.jar

# Instalar unzip
RUN apt update && apt install -y unzip curl

# Baixar e instalar o modpack BMC5 para a versão 1.21.1
ADD https://mediafilez.forgecdn.net/files/6413/713/BMC5_Server_Pack_v27.zip BMC5.zip
RUN unzip BMC5.zip -d ./ && rm BMC5.zip
RUN curl -sL https://github.com/Jabba-Team/jabba/raw/main/install.sh | bash && . ~/.jabba/jabba.sh

# Copiar mods e arquivos de configuração adicionais
COPY eula.txt ./eula.txt

# Expor a porta padrão do servidor Minecraft
EXPOSE 25565

# Comando para iniciar o servidor
# CMD ["java", "-Xmx4G", "-Xms2G", "-jar", "forge-1.21.1-47.1.0.jar", "nogui"]
RUN chmod +x start.sh
CMD ["./start.sh"]
