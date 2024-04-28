# DevOps - Lemoncode - CI/CD pipeline with GitHub Actions Exercises
1. [Introduction](#intro)
2. [GitHub Workflow Exercises](#exercises)
3. [Solution structure](#structure)

<a name="intro"></a>
## 1. Introduction

You can automate, customize, and execute your software development workflows in your repository with GitHub Actions. You can discover, create, and share actions to perform any job you'd like, including CI/CD, and combine actions in a completely customized workflow.

A workflow must contain the following components:

1. One or more events that will [trigger the workflow](https://docs.github.com/en/actions/using-workflows/triggering-a-workflow).
2. One or more jobs, each of which will execute on a runner machine and run a series of one or more steps.
3. Each step can either run a script that you define or run an action, which is a reusable extension that can simplify your workflow.

GitHub Actions uses YAML syntax to define the workflow. Each workflow is stored as a separate YAML file in your code repository, in a directory named `.github\workflows`.


<a name="exercises"></a>
## 2. GitHub Workflow Exercises

We've been asked by LemonCode team to implement the solution of the following `CI/CD pipeline with GitHub Actions` exercises:

### Exercise 1. CI Workflow - MUST

* This exercise is to create a CI workflow that runs automatically when the following two events occur:
   * There are changes on the hangman-front project   
   * Pull request is made

   The workflow will do the following tasks:

   * Build the hangman-front project
   * Run unit tests

* To run the hangman-front app locally and unit tests, look at the steps in [run-solution-locally](./hangman-front-locally.md).

* You can see the solution in [ci-workflow-must.md](https://github.com/monicacrespo/bootcamp-devops-student-github-actions/tree/main/1.ci-workflow-must.md).


### Exercise 2. CD Workflow - MUST

* This exercise is to create a CD workflow that will do the following tasks:

   * Create a new Docker image 
   * Publish that image in GitHub Container Registry

   The event that will trigger the workflow is `workflow_dispatch`.

* You can see the solution in [cd-workflow-must.md](https://github.com/monicacrespo/bootcamp-devops-student-github-actions/tree/main/2.cd-workflow-must.md).


### Exercise 3. Tests e2e Workflow using Cypress GitHub Action - NICE TO HAVE

* This exercise is to create a GitHub workflow to run end-to-end tests using the Cypress Action. The event that will trigger the workflow is `workflow_dispatch`.
* To run the end to end tests locally, look at the steps in [run-e2e-tests](./hangman-front-locally.md#e2e).
* You can see the solution in [e2e-cypress-workflow-nice-to-have.md](https://github.com/monicacrespo/bootcamp-devops-student-github-actions/tree/main/3.e2e-cypress-workflow-nice-to-have.md).

### Exercise 4. Tests e2e Workflow using Docker Compose - CHALLENGE

* This exercise is to create a GitHub workflow to run end-to-end tests using Docker Compose. The event that will trigger the workflow is `workflow_dispatch`.

* We need to ensure that `hangman-api`, `hangman-front` and `hangman-e2e` services start in the correct order, which is the following:
   1. `hangman-api` service
   2. `hangman-front` depends on the `hangman-api` service. You want to ensure that the `hangman-api` starts and can accept connections before your `hangman-front` Node.js application starts. 
   3. `e2e` depends on the `hangman-front` service.  The execution of the Cypress test runner needs to fire after the web `hangman-front` service connects and run its server.

   These dependencies are specified using the `depends_on` option which is a valuable tool in Docker Compose for ensuring that services start-up in the correct order with dependiences in a healthy state.

   However, `depends_on` only controls the startup order and does not guarantee service readiness by default. It doesn't wait until the container is in ready state. It only waits until the dependent container is in 'running' state. To verify the availability of dependent services before starting services that rely on them, use additional tools or techniques such as
   * health checks in Docker Compose, or
   * your own start shell script in the e2e Dockerfile ENTRYPOINT to wait until a depending container service starts.

* You can see the solution using the native health check in Docker Compose in [e2e-docker-compose-workflow-health-check-nice-to-have.md](https://github.com/monicacrespo/bootcamp-devops-student-github-actions/tree/main/4.e2e-docker-compose-workflow-health-check-nice-to-have.md).

* You can see the solution using an own custom health check shell script in [e2e-docker-compose-workflow-nice-to-have.md](https://github.com/monicacrespo/bootcamp-devops-student-github-actions/tree/main/4.e2e-docker-compose-workflow-nice-to-have.md).

### Exercise 5. Custom JavaScript Action - NICE TO HAVE

* This exercise es to create a [custom JavaScript Action](https://github.com/Lemoncode/bootcamp-devops-lemoncode/tree/master/03-cd/exercises#4-crea-una-custom-javascript-action---opcional) that runs when an issue contains the `motivate` label. The action will print by console a motivational message. You could use this free [API](https://type.fit/#%7B%22text%22:%22Welcome%20to%20Type.fit!%5CnA%20keyboard%20typing%20practice%20web%20application.%5CnDesigned%20for%20the%20improvement%20of%20typing%20speed%20along%20with%20accuracy.%22%7D). You can find more information of how to create a una custom JS action in this [link](https://docs.github.com/es/actions/creating-actions/creating-a-javascript-action).

   `curl https://type.fit/api/quotes`

* You can see the solution in [custom-javascript-action-nice-to-have.md](https://github.com/monicacrespo/bootcamp-devops-student-github-actions/tree/main/5.custom-javascript-action-nice-to-have.md).

<a name="structure"></a>
## 3. Solution structure

```
bootcamp-devops-student-github-actions
├── .github (new) 
│   ├── workflows (new)
│     ├── 1.ci-hangman-front.yaml (new - exercise 1)
│     ├── 2.cd-hangman-front.yaml (new - exercise 2)
│     ├── 3.e2e-hangman-front-cypress-action.yaml (new - exercise 3)
│     ├── 4.e2e-hangman-front-docker-compose-health-check.yaml (new - exercise 4 - native health check)
│     ├── 4.e2e-hangman-front-docker-compose.yaml (new - exercise 4)
│     ├── 5.quote-custom-action.yaml (new - exercise 5)
├── hangman-api (existing)
│   ├── ...
│   ├── .env 
│   ├── Dockerfile 
│   ├── Dockerfile.migrations 
│   ├── package-lock.json 
│   ├── package.json 
├── hangman-e2e (existing)
│   ├── e2e
│       ├── .env 
│       ├── cypress-16-e2e.dockerfile (new - exercise 4 - native health check)
│       ├── docker-entrypoint.sh (new - exercise 4)
│       ├── Dockerfile (new - exercise 4)
│       ├── e2e.dockerfile
│       ├── package-lock.json 
│       ├── package.json 
│       ├── wait-for-it.sh (new - exercise 4)
├── hangman-front (existing)
│   ├── ...
│   ├── docker-compose-health-check.yml (new - exercise 4 - native health check) 
│   ├── docker-compose.yml (new - exercise 4) 
│   ├── Dockerfile 
├── 1.ci-workflow-must.md (new - exercise 1)
├── 2.cd-workflow-must.md (new - exercise 2)
├── 3.e2e-cypress-workflow-nice-to-have.md (new - exercise 3)
├── 4.e2e-docker-compose-workflow-health-check-nice-to-have.md (new - exercise 4 - native health check)
├── 4.e2e-docker-compose-workflow-nice-to-have.md (new - exercise 4)
├── 5.custom-javascript-action-nice-to-have.md (new - exercise 5)
├── hangman-front-locally.md (new)
├── images (new)
│   ├── hangman-front-locally.JPG (new)
│   ├── ...
├── README.md (new)
```

```
bootcamp-devops-inspirational-quote-javascript-action
├── dist (new - exercise 5) 
│   ├── index.js (new - exercise 5)
├── action.yaml (new - exercise 5)
├── package.json (new - exercise 5)
├── README.md (new - exercise 5)
```