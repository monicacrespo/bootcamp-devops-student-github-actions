FROM cypress/base:16

WORKDIR /app

COPY ./package.json .
COPY ./package-lock.json .
COPY ./cypress.config.ts .
COPY ./tsconfig.json .
COPY ./cypress ./cypress

COPY ./wait-for-it.sh ./wait-for-it.sh
COPY ./docker-entrypoint.sh ./docker-entrypoint.sh

RUN chmod +x ./wait-for-it.sh ./docker-entrypoint.sh

ENV CI=1 

RUN npm ci

# It must use the JSON-array syntax
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["npx", "cypress", "run"]