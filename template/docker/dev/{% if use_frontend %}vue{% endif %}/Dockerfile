# Node na Debianie, nie Alpine (natywne moduły npm)
FROM node:24-slim

RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# użytkownik node z obrazu dostaje UID hosta, inaczej package.json po npm install należy do roota
ARG UID
RUN usermod -u ${UID} node

WORKDIR /app
RUN chown node:node /app
USER node

COPY --chown=node:node frontend/package*.json ./
RUN npm ci

COPY --chown=node:node frontend/ .

EXPOSE 3000

CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
