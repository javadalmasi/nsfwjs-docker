FROM node:lts-bullseye as builder
WORKDIR /usr/app
RUN npm install -g pnpm
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm build

FROM node:lts-bullseye
WORKDIR /app
RUN npm install -g pnpm
COPY --from=builder /usr/app /app/
EXPOSE 3333
CMD ["pnpm", "start"]
