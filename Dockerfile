# python:slimイメージをベースにする
FROM python:slim

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# uvをインストール
RUN pip install uv

# supergatewayをnpmでインストール
RUN npm install -g supergateway

# 作業ディレクトリを設定
WORKDIR /app

# リポジトリをクローン
RUN git clone https://github.com/runekaagaard/mcp-redmine.git . && \
    git checkout main

# ENTRYPOINTとしてsupergatewayを指定
ENTRYPOINT ["supergateway"]

# デフォルトコマンド
CMD ["--stdio", "uv --directory /app run server.py"]
