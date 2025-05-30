# Use an official Node.js runtime as a parent image
FROM node:slim

# Install Chromium for Puppeteer
RUN apt-get update && \
    apt-get install -y chromium && \
    rm -rf /var/lib/apt/lists/*

# Set environment variable for Puppeteer to find Chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of your app's code
COPY . .

# Build your SvelteKit app
RUN npm run build

# Expose the port your app will run on
EXPOSE 3000

# Set environment variables for SvelteKit/Node
ENV PORT=3000
ENV HOST=0.0.0.0

# Start the Node server
CMD ["node", "build"]
