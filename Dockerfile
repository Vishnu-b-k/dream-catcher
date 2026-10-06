# Use the Node 22 Alpine image (uses musl instead of glibc)
FROM node:22-alpine

# Create app directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies (this will download Alpine-specific binaries, avoiding GLIBC issues)
RUN npm ci --omit=dev

# Bundle your app's source code inside the Docker image
COPY . .

# Your app binds to port 3001, so we expose it
EXPOSE 3001

# Define the command to run your app
CMD [ "npm", "start" ]
