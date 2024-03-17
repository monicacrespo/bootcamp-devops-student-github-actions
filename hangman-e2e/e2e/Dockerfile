FROM cypress/base:16

WORKDIR /app

COPY ./package.json .
COPY ./package-lock.json .
COPY ./cypress.config.ts .
COPY ./tsconfig.json .
COPY ./cypress ./cypress

COPY ./wait-for-it.sh ./wait-for-it.sh

RUN chmod +x wait-for-it.sh

ENV CI=1 

RUN npm ci &&\
    npx cypress info

#RUN npx cypress verify
#RUN npm run open
ENTRYPOINT ["npm", "run", "cypress:run"]
##ENTRYPOINT  sleep 10; npm run cypress:run