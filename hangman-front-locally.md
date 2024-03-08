## Running locally hangman-front app and unit tests

To build and run the tests manually of the `hangman-front` application do the following steps:
Start by cloning that repository and taking a look at it.

```bash
$ git clone https://github.com/monicacrespo/bootcamp-devops-student-cicd.git
$ cd hangman-front
```

We can then use `npm` to install the required Node.js modules run the following command:
```bash
$ npm install
```
Then use npm again to start the application. 

```bash
$ npm start
20:50:28 - Starting compilation in watch mode...
[type-check:watch] 
[start:dev       ] Failed to load ./.env.
[type-check:watch] 
[type-check:watch] 20:50:33 - Found 0 errors. Watching for file changes.
[start:dev       ] <i> [webpack-dev-server] Project is running at:
[start:dev       ] <i> [webpack-dev-server] Loopback: http://localhost:8080/, http://127.0.0.1:8080/
[start:dev       ] <i> [webpack-dev-server] Content not from webpack is served from 'C:\_gitrepos\bootcamp-devops-student-cicd\hangman-front\public' directory
[start:dev       ] asset app.js 4.31 MiB [emitted] (name: app)
[start:dev       ] asset index.html 314 bytes [emitted]
[start:dev       ] runtime modules 28.4 KiB 14 modules
[start:dev       ] modules by path ../node_modules/ 1.52 MiB 208 modules
[start:dev       ] modules by path ./ 10.4 KiB
[start:dev       ]   modules by path ./services/*.ts 3.33 KiB
[start:dev       ]     ./services/index.ts 1.02 KiB [built] [code generated]
[start:dev       ]     ./services/game.api.ts 1.25 KiB [built] [code generated]
[start:dev       ]     ./services/config.ts 1.06 KiB [built] [code generated]
[start:dev       ]   modules by path ./*.tsx 2.42 KiB
[start:dev       ]     ./index.tsx 1.2 KiB [built] [code generated]
[start:dev       ]     ./app.tsx 1.22 KiB [built] [code generated]
[start:dev       ]   modules by path ./components/ 4.6 KiB
[start:dev       ]     ./components/index.ts 1.03 KiB [built] [code generated]
[start:dev       ]     ./components/start-game.component.tsx 3.57 KiB [built] [code generated]
[start:dev       ] webpack 5.74.0 compiled successfully in 6187 ms
```

It’ll run on localhost on port 8080, and we can browse to see its output

![Hangman](./images/hangman-front-locally.JPG)

We also have a unit test. Let's run this with npm.

```bash
$ npm run test

> hangman-front@1.0.0 test
> jest -c ./config/test/jest.js

 PASS  src/components/start-game.spec.tsx (5.924 s)
  StartGame component specs
    √ should display a list of topics (197 ms)

Test Suites: 1 passed, 1 total
Tests:       1 passed, 1 total
Snapshots:   0 total
```