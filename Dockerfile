FROM elixir:1.14.0-alpine AS build
# install build dependencies
RUN apk add --no-cache build-base npm git python3
# prepare build dir
WORKDIR /app
# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force
# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile
COPY priv priv
RUN mix phx.digest
# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

# prepare release image
FROM alpine:3.16.2 AS app
RUN apk add --no-cache openssl ncurses-libs
WORKDIR /app
RUN chown nobody:nobody /app
USER nobody:nobody
COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/elixir_exploration ./
ENV HOME=/app
CMD ["bin/elixir_exploration", "start"]