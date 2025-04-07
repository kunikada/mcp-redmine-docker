# Redmine MCP Docker

このリポジトリは、[MCP Redmine](https://github.com/runekaagaard/mcp-redmine)をクライアントからHTTP/SSEで通信するためのプロジェクトです。RedmineのAPIを活用したモダンコマンドパレット（MCP）をHTTPサーバーとして実行できます。

## 概要

このプロジェクトは以下の機能を提供します：

- Redmineインスタンスに接続するMCPサーバーをDockerコンテナとして実行

## 前提条件

- Docker
- Redmineインスタンス
- RedmineのAPIキー

## 使い方

### 1. リポジトリのクローン

このリポジトリをローカルにクローンします：

```bash
git clone https://github.com/kunikada/mcp-redmine-docker.git
cd mcp-redmine-docker
```

### 2. Dockerイメージのビルド

以下のコマンドでDockerイメージをビルドします：

```bash
docker build -t mcp-redmine .
```

### 3. Dockerコンテナの実行

環境変数を設定してコンテナを起動します：

```bash
docker run -d -p 8000:8000 \
  -e REDMINE_URL="https://your-redmine-instance.com" \
  -e REDMINE_API_KEY="your-api-key" \
  -e REDMINE_REQUEST_INSTRUCTIONS="optional-instructions" \
  --name mcp-redmine \
  --restart=unless-stopped \
  mcp-redmine
```

### 4. MCPサーバーの設定例

```json
{
  "mcpServers": {
    "redmine": {
      "type": "sse",
      "url": "http://your-mcp-server.com:8000/sse"
    }
  }
}
```

## 環境変数

| 変数名 | 説明 | 必須 |
|---|---|---|
| `REDMINE_URL` | RedmineインスタンスのURL | はい |
| `REDMINE_API_KEY` | RedmineのAPIキー | はい |
| `REDMINE_REQUEST_INSTRUCTIONS` | リクエスト処理の追加指示 | いいえ |

## Docker Compose での実行例

```yaml
services:
  mcp-redmine:
    build: .
    container_name: mcp-redmine
    ports:
      - "8000:8000"
    environment:
      - REDMINE_URL=https://your-redmine-instance.com
      - REDMINE_API_KEY=your-api-key
      - REDMINE_REQUEST_INSTRUCTIONS=optional-instructions
    restart: unless-stopped
```

## ライセンス

このプロジェクトは元の [MCP Redmine](https://github.com/runekaagaard/mcp-redmine) と同じライセンスの下で提供されています。

## 謝辞

このプロジェクトは [runekaagaard/mcp-redmine](https://github.com/runekaagaard/mcp-redmine) をベースにしています。
