FROM elixir:1.12-alpine

WORKDIR /app

COPY . .

RUN apk update && \
  apk add --no-cache build-base git nodejs yarn inotify-tools && \
  mix local.hex --force && \
  mix local.rebar --force && \
  mix archive.install hex phx_new --force

EXPOSE 2222 80

CMD ["./docker-entrypoint.sh"]
