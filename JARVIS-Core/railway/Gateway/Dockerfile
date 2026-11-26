FROM oven/bun:1.4.4
WORKDIR /app
COPY package.json ./
RUN bun install --production
COPY index.ts ./index.ts
COPY identity.mjs ./identity.mjs
COPY agentMailbox.mjs githubDelivery.mjs ./
COPY src ./src
ENV NODE_ENV=production
EXPOSE 8080
CMD ["bun", "run", "index.ts"]
