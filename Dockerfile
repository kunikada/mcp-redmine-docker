FROM node:20-slim

RUN apt-get update && apt-get install -y \
    wget \
    && apt-get clean

# supergatewayをnpmでインストール
RUN npm install -g supergateway \
    && npm cache clean --force

USER node:node

# uvをインストール
RUN wget -qO- https://astral.sh/uv/install.sh | sh
ENV PATH="/home/node/.local/bin:${PATH}"

ENTRYPOINT ["supergateway"]

CMD ["--stdio", "uvx --from mcp-redmine==2025.04.09.153531 mcp-redmine"]
