ARG BUILD_FROM
FROM $BUILD_FROM

RUN apt -qq update && \
    apt -qq install -y \
        wget \
        gnupg2 \
        lsb-release \
    && \
    wget -qO- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt -qq update && \
    apt -qq install vault && \
    apt clean all && \
    rm -rf /var/lib/apt/lists/*

# Copy data for add-on
COPY run.sh /
COPY vault-agent.tmpl /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
