FROM gocd/gocd-agent-almalinux-9:v25.3.0

LABEL gocd.version="25.3.0" \
      description="GoCD agent based on AlmaLinux" \
      maintainer="Tecladozurdo" \
      url="https://tecladozurdo.com"

# Copiar el JDK 7 al contenedor
COPY jdk-7u80-linux-x64.tar.gz /tmp/jdk-7u80-linux-x64.tar.gz

# Instalar JDK 7
USER root

RUN mkdir -p /usr/lib/jvm && \
    tar -xzf /tmp/jdk-7u80-linux-x64.tar.gz -C /usr/lib/jvm && \
    rm /tmp/jdk-7u80-linux-x64.tar.gz && \
    # Renombrar el directorio si es necesario (ajusta según el nombre de tu archivo)
    mv /usr/lib/jvm/jdk1.7.0_* /usr/lib/jvm/java-7-oracle && \
    # Configurar alternativas
    alternatives --install /usr/bin/java java /usr/lib/jvm/java-7-oracle/bin/java 17000000 && \
    alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-7-oracle/bin/javac 17000000 && \
    alternatives --install /usr/bin/jar jar /usr/lib/jvm/java-7-oracle/bin/jar 17000000

    # Copiar el archivo settings.xml de Maven
COPY settings.xml /tmp/settings.xml

    # Instalar Maven (versión compatible con JDK 7)
RUN microdnf install -y wget which && \
    mkdir -p /opt/maven && \
    wget https://archive.apache.org/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz -P /tmp && \
    tar -xzf /tmp/apache-maven-3.2.5-bin.tar.gz -C /opt/maven && \
    rm /tmp/apache-maven-3.2.5-bin.tar.gz && \
    ln -s /opt/maven/apache-maven-3.2.5 /opt/maven/current && \
    # Configurar Maven con los mirrors personalizados
    mkdir -p /root/.m2 && \
    cp /tmp/settings.xml /root/.m2/settings.xml && \
    rm /tmp/settings.xml && \
    microdnf clean all

ENV JAVA_7_HOME="/usr/lib/jvm/java-7-oracle" \
    M2_HOME="/opt/maven/current" \
    PATH="/usr/lib/jvm/java-7-oracle/bin:/opt/maven/current/bin:$PATH"

# Verificar la instalación
RUN java -version && javac -version && mvn -version