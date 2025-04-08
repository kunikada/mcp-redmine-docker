FROM node:20-slim

RUN apt-get update && apt-get install -y \
    wget \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# supergatewayをnpmでインストール
RUN npm install -g supergateway \
    && npm cache clean --force

USER node:node

# uvをインストール
RUN wget -qO- https://astral.sh/uv/install.sh | sh
ENV PATH="/home/node/.local/bin:${PATH}"

WORKDIR /opt/app

# メインプログラム
RUN git clone https://github.com/runekaagaard/mcp-redmine.git

ENTRYPOINT ["supergateway"]

CMD ["--stdio", "uv --directory /opt/app/mcp-redmine run server.py"]
