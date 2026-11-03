FROM --platform=linux/amd64 node:22-alpine

WORKDIR /usr/src/app

# Tools required to compile native modules such as sqlite3
RUN apk add --no-cache python3 make g++

# Copy dependency files first for Docker layer caching
COPY package*.json ./

# Force sqlite3 to compile inside this exact Alpine environment
RUN npm ci --omit=dev --build-from-source=sqlite3

# Copy application source
COPY . .

EXPOSE 3001

CMD ["npm", "start"]