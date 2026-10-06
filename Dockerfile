# Use the Node 22 slim image (matches your local environment)
FROM node:22-slim

# Create app directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install Python and build tools to compile sqlite3 from source
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*

# Install dependencies normally first
RUN npm ci --omit=dev

# Explicitly force sqlite3 to rebuild from source using the container's GLIBC
RUN npm rebuild sqlite3 --build-from-source

# Bundle your app's source code inside the Docker image
COPY . .

# Your app binds to port 3001, so we expose it
EXPOSE 3001

# Define the command to run your app
CMD [ "npm", "start" ]
