# CI/CD pipeline with GitHub Actions 
1. [Introduction](#intro)
2. [CI Workflow - MUST](#ci)
3. [CD Workflow - MUST](#cd)
4. [Tests e2e Workflow - NICE TO HAVE](#e2e)
5. [Custom JavaScript Action - NICE TO HAVE](#js)

<a name="intro"></a>
## 1. Introduction

You can automate, customize, and execute your software development workflows in your repository with GitHub Actions. You can discover, create, and share actions to perform any job you'd like, including CI/CD, and combine actions in a completely customized workflow.

A workflow must contain the following components:

1. One or more events that will [trigger the workflow](https://docs.github.com/en/actions/using-workflows/triggering-a-workflow).
2. One or more jobs, each of which will execute on a runner machine and run a series of one or more steps.
3. Each step can either run a script that you define or run an action, which is a reusable extension that can simplify your workflow.

GitHub Actions uses YAML syntax to define the workflow. Each workflow is stored as a separate YAML file in your code repository, in a directory named `.github\workflows`.

### Solution structure
```
├── .github (new) 
│   ├── workflows (new)
│     ├── cd-hangman-front.yaml (new)
│     ├── ci-hangman-front.yaml (new)
│     ├── hangman-e2e-integration.yaml (new)
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
│       ├── cypress-16.dockerfile 
│       ├── e2e.dockerfile
│       ├── package-lock.json 
│       ├── package.json 
├── hangman-front (existing)
│   ├── ...
│   ├── Dockerfile 
├── hangman-front-locally.md (new)
├── hangman-front-locally.JPG (new)
├── README.md (new)
```

<a name="ci"></a>
## 2. CI Workflow - MUST

We've been asked by LemonCode team to create a [CI workflow](https://github.com/Lemoncode/bootcamp-devops-lemoncode/tree/master/03-cd/exercises#1-crea-un-workflow-ci-para-el-proyecto-de-frontend---obligatorio) for the frontend project [.start-code/hangman-front](https://github.com/Lemoncode/bootcamp-devops-lemoncode/tree/master/03-cd/03-github-actions/.start-code/hangman-front). It’s a small NodeJS application that runs an Express server. You’ll need Node.js and Visual Studio code as prerequisites for the application.

The CI workflow needs to run when the following two events occur:
* There are changes on the hangman-front proyect   
* Pull request is made

The workflow will do the following tasks:

* Build the hangman-front project
* Run unit tests


### Workflow for automating the build and unit tests 

`.github\workflows\ci-hangman-front.yaml` 

```yaml
name: Exercise 1 - npm build and test

on:   
  pull_request:
    branches: [main]
    paths: ["hangman-front/**"]

jobs:
  build:
    runs-on: ubuntu-latest
   
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 16
      - name: build
        working-directory: ./hangman-front
        run: |
          npm ci
          npm run build --if-present
          npm test
```

The above workflow specifies two conditions to run:
* Changes on `hangman-front/**` path 
* Pull request targeting the `main` branch

It has one job named `build` and it does use the following actions:

* [checkout](https://github.com/actions/checkout) action will perform a local git clone of the repository.
* [setup-node](https://github.com/actions/setup-node) action will take care of installing Node.js inside the container running our job. We can see one of the action arguments here too. The with block tells Actions what Node.js version to install—in our case, the 16 version.
* The next step installs any Node.js modules we need. Then builds it. And then executes our tests using `npm test`

### Run the workflow
1. Create a new branch, e.g. 'ci-newworkflow' and switched to it.
```bash
$ git checkout -b ci-newworkflow
```

2. Make a change to our `hangman-front` project, e.g. edit the app.tsx file and add a comment, commit the result, and push it.

```bash
git add hangman-front/src/app.tsx
git commit -m 'Added a comment to trigger ci workflow'
git push origin ci-newworkflow
```

3. Create a pull request for this branch. After the request has been created, Actions will initiate our workflow, resulting in a failure run. The reason is because the `StartGame` unit test located on `hangman-front/src/components/start-game.spec.tsx` file, has an error. 

4. Fix the unit test, and push it, resulting in a successful run.
   Before the fix
   ``` 
   expect(items).toHaveLength(1);
   ```
   After the fix
   ```
   expect(items).toHaveLength(2);
   ```
5. Merge it to the main branch.

GitHub Action runs displayed on the Actions tab 

![](./images/01_02_actions.png)

And logs within each step

![](./images/01_02_actions.png)

<a name="cd"></a>
## 3. CD Workflow - MUST
We've been asked by LemonCode team to create a [CD workflow](https://github.com/Lemoncode/bootcamp-devops-lemoncode/tree/master/03-cd/exercises#2-crea-un-workflow-cd-para-el-proyecto-de-frontend---obligatorio) for the frontend project that is triggered manually using `workflow_dispatch` event.
The workflow will do the following tasks:

* Create a new Docker image 
* Publish that image in GitHub Container Registry

<a name="e2e"></a>
## 4. Tests e2e Workflow - NICE TO HAVE

We've been asked by LemonCode team to create a [e2e tests workflow](https://github.com/Lemoncode/bootcamp-devops-lemoncode/tree/master/03-cd/exercises#3-crea-un-workflow-que-ejecute-tests-e2e---opcional).

You can use [Docker Compose](https://docs.docker.com/compose/gettingstarted/) or [Cypress action](https://github.com/cypress-io/github-action) to run the tests located [here](https://github.com/Lemoncode/bootcamp-devops-lemoncode/tree/master/03-cd/03-github-actions/.start-code/hangman-e2e/e2e).

To run the e2e tests follow these steps:

1. The front and the api must be up by running the following commands:
   
    ```
    docker run -d -p 3001:3000 binarylavender/hangman-api:latest
    docker run -d -p 8080:8080 -e API_URL=http://localhost:3001 binarylavender/hangman-front:latest
    ```
2. To run the end to end tests run the following commands:
    ```
    $ cd hangman-e2e/e2e
    $ npm run open
    ```
<a name="js"></a>
## 5. Custom JavaScript Action - NICE TO HAVE
We've been asked by LemonCode team to create a [custom JavaScript Action](https://github.com/Lemoncode/bootcamp-devops-lemoncode/tree/master/03-cd/exercises#4-crea-una-custom-javascript-action---opcional) that runs when an issue contains the `motivate` label. The action will print by console a motivational message. You could use this free [API](https://type.fit/#%7B%22text%22:%22Welcome%20to%20Type.fit!%5CnA%20keyboard%20typing%20practice%20web%20application.%5CnDesigned%20for%20the%20improvement%20of%20typing%20speed%20along%20with%20accuracy.%22%7D). You can find more information of how to create a una custom JS action in this [link](https://docs.github.com/es/actions/creating-actions/creating-a-javascript-action).

`curl https://type.fit/api/quotes`