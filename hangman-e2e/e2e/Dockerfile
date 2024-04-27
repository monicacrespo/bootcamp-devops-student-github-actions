# Use the Cypress base image
FROM cypress/base:16

# Set the working directory in the container
WORKDIR /app

# Copy the test code into the container
COPY ./package.json .
COPY ./package-lock.json .
COPY ./cypress.config.ts .
COPY ./tsconfig.json .
COPY ./cypress ./cypress

COPY ./wait-for-it.sh ./wait-for-it.sh
COPY ./docker-entrypoint.sh ./docker-entrypoint.sh

RUN chmod +x ./wait-for-it.sh ./docker-entrypoint.sh

ENV CI=1 

# Install Cypress and any other required npm packages
RUN npm ci

# It must use the JSON-array syntax
ENTRYPOINT ["./docker-entrypoint.sh"]
# Execute the Cypress test runner
CMD ["npx", "cypress", "run"]