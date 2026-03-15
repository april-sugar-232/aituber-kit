FROM node:24 AS base

# 必要なシステムライブラリをインストール
RUN apt-get update && apt-get install -y \
  libcairo2-dev \
  libpango1.0-dev \
  libjpeg-dev \
  libgif-dev \
  librsvg2-dev \
  pkg-config \
  && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /app

# package.jsonとpackage-lock.jsonをコピー
COPY package*.json ./

# 依存関係をインストール
RUN npm ci

# アプリケーションのソースコードをコピー
COPY . .

ENV NODE_ENV=production
ENV PORT=8080

RUN npm run build

EXPOSE 8080

CMD ["npm", "start"]