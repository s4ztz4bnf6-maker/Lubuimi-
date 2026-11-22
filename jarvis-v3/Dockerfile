FROM oven/bun:1.2.23-alpine
WORKDIR /app
COPY package.json index.js ./
ENV NODE_ENV=production
EXPOSE 8080
USER bun
CMD ["bun", "run", "index.js"]
