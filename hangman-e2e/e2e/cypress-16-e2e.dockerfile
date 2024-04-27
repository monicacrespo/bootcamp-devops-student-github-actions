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

ENV CI=1 

# Install Cypress and any other required npm packages
RUN npm ci

# Execute the Cypress test runner
CMD ["npx", "cypress", "run"]