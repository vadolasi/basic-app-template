#!/bin/bash
#* Create a new nuxt and ionic project with my custom preferences

PROJECT_NAME=$1

# Create project folder
mkdir $PROJECT_NAME
cd $PROJECT_NAME

# Initialize git
git init
cat << EOF >> .gitignore
# Logs
/logs
*.log
yarn-debug.log*
yarn-error.log*

# Dependency directories
node_modules/

# Optional eslint cache
.eslintcache

# Yarn Integrity file
.yarn-integrity

# dotenv environment variables file
.env

# nuxt.js build output
.nuxt

# Nuxt generate
dist

# IDE / Editor
.idea
.vscode
EOF

# Configure NodeJS
cat << EOF >> package.json
{
  "name": "test",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "nuxt-ts",
    "build": "nuxt-ts build",
    "start": "nuxt-ts start",
    "generate": "nuxt-ts generate",
    "lint:js": "eslint --ext .js,.vue --ignore-path .gitignore .",
    "lint": "yarn lint:js",
    "test": "yarn test:unit && yarn test:e2e",
    "test:unit": "cross-env TEST=unit ava ./test/specs/**/*",
    "test:e2e": "cross-env TEST=e2e ava ./test/e2e/**/*"
  },
  "dependencies": {
    "@ionic/core": "^5.3.1",
    "@modus/ionic-vue": "^1.3.10",
    "@nuxt/content": "^1.5.0",
    "@nuxt/typescript-runtime": "^1.0.0",
    "@nuxtjs/axios": "^5.12.0",
    "@nuxtjs/pwa": "^3.0.0-beta.20",
    "material-design-icons": "^3.0.1",
    "nuxt": "^2.14.0",
    "vue-fragment": "^1.5.1",
    "vue-ionicons": "^3.0.5"
  },
  "devDependencies": {
    "@ava/babel": "^1.0.1",
    "@nuxt/types": "^2.14.0",
    "@nuxt/typescript-build": "^2.0.2",
    "@nuxtjs/eslint-config": "^3.1.0",
    "@nuxtjs/eslint-config-typescript": "^3.0.0",
    "@nuxtjs/eslint-module": "^2.0.0",
    "@vue/test-utils": "^1.0.3",
    "ava": "^3.11.0",
    "babel-eslint": "^10.1.0",
    "babel-plugin-module-resolver": "^4.0.0",
    "cross-env": "^7.0.2",
    "eslint": "^7.5.0",
    "eslint-config-prettier": "^6.11.0",
    "eslint-plugin-nuxt": "^1.0.0",
    "eslint-plugin-prettier": "^3.1.4",
    "jest": "26.2.2",
    "jsdom": "^16.3.0",
    "jsdom-global": "^3.0.2",
    "node-sass": "^4.14.1",
    "prettier": "^2.0.5",
    "require-extension-hooks": "^0.3.3",
    "require-extension-hooks-babel": "^1.0.0",
    "require-extension-hooks-vue": "^3.0.0",
    "sass-loader": "^9.0.3"
  }
}
EOF

# Install dependencies
yarn install

# Configure github
mkdir .github
cd .github
cat << EOF >> semantic.yml
titleAndCommits: true
allowMergeCommits: true
EOF

# Configure nuxt
cat << EOF >> nuxt.config.js
export default {
  srcDir: "src/",
  mode: "universal",
  target: "static",
  head: {
    title: process.env.npm_package_name || "",
    meta: [
      { charset: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      {
        hid: "description",
        name: "description",
        content: process.env.npm_package_description || "",
      },
    ],
    link: [{ rel: "icon", type: "image/x-icon", href: "/favicon.ico" }],
  },
  css: [
    "../node_modules/@ionic/core/css/core.css",
    "../node_modules/@ionic/core/css/normalize.css",
    "../node_modules/@ionic/core/css/structure.css",
    "../node_modules/@ionic/core/css/typography.css",
    "../node_modules/@ionic/core/css/ionic.bundle.css",
  ],
  plugins: [
    { src: "~/plugins/ionic.js", mode: "client" },
    { src: "~/plugins/ionicons.js", mode: "client" },
  ],
  components: true,
  buildModules: ["@nuxt/typescript-build"],
  modules: ["@nuxtjs/axios", "@nuxtjs/pwa", "@nuxt/content"],
  axios: {},
  content: {},
  build: {},
}
EOF

# Configure Javascript
cat << EOF >> jsconfig.json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "~/*": ["./src/*"],
      "@/*": ["./src/*"],
      "~~/*": ["./*"],
      "@@/*": ["./*"]
    }
  },
  "exclude": ["node_modules", ".nuxt", "dist"]
}
EOF

# Configure Typescript
cat << EOF >> tsconfig.json
{
  "compilerOptions": {
    "target": "ES2018",
    "module": "ESNext",
    "moduleResolution": "Node",
    "lib": [
      "ESNext",
      "ESNext.AsyncIterable",
      "DOM"
    ],
    "esModuleInterop": true,
    "allowJs": true,
    "sourceMap": true,
    "strict": true,
    "noEmit": true,
    "experimentalDecorators": true,
    "baseUrl": ".",
    "paths": {
      "~/*": [
        "./*"
      ],
      "@/*": [
        "./*"
      ]
    },
    "types": [
      "@types/node",
      "@nuxt/types"
    ]
  },
  "exclude": [
    "node_modules",
    ".nuxt",
    "dist"
  ]
}
EOF
cat << EOF >> shims.d.ts
declare module "*.vue" {
  import Vue from "vue"
  export default Vue
}
EOF

# Configure editor
cat << EOF >> .editorconfig
# editorconfig.org
root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.md]
trim_trailing_whitespace = false
EOF

# Configure Babel JS
cat << EOF >> .babelrc
{
  "env": {
    "test": {
      "plugins": [
        [
          "module-resolver",
          {
            "root": ["."],
            "alias": {
              "@": ".",
              "~": "."
            }
          }
        ]
      ]
    }
  }
}
EOF

# Configure ESlint
cat << EOF >> .eslintrc.js
module.exports = {
  root: true,
  env: {
    browser: true,
    node: true,
  },
  extends: [
    "@nuxtjs/eslint-config-typescript",
    "prettier",
    "prettier/vue",
    "plugin:prettier/recommended",
    "plugin:nuxt/recommended",
  ],
  plugins: ["prettier"],
  // add your custom rules here
  rules: {},
}
EOF

# Configure Prettier
cat << EOF >> .prettierc
{
  "semi": false,
  "singleQuote": false
}
EOF

# Configute AVA
cat << EOF >> ava.config.cjs
module.exports = () => {
  return {
    require: ["./test/helpers/ava.setup.js"],
    ignoredByWatcher: ["!**/*.{js,vue}"],
    babel: true,
    tap: true,
    verbose: true,
    color: true,
  }
}
EOF

# Create tests
mkdir tests
cd tests

# Create tests subfolders
mkdir e2e
mkdir helpers
mkdir specs

# exit of tests folder
cd ../

# Create src folder
mkdir src
cd src

# Create src subfolders
mkdir assets
mkdir components
mkdir layouts
mkdir middleware
mkdir pages
mkdir plugins
mkdir static

# Add content of plugins folder
cd plugins

# Add Ionic
cat << EOF >> ionic.js
import Vue from "vue"
import { defineCustomElements as Ionic } from "@ionic/core/loader"

Vue.use(Ionic)
Vue.config.ignoredElements = [/^ion-/]
EOF

# Add Ionicons
cat << EOF >> ionicons.js
import Vue from "vue"
import AllIcon from "vue-ionicons/dist/ionicons.js"

Vue.use(AllIcon)
EOF

# Exit of plugins folder
cd ../

# Add content of layouts folder
cd layouts

# Add global style
cat << EOF >> style.sass
.ion
  display: inline-flex

.ion__svg
  fill: currentColor

@-webkit-keyframes ionShake
	10%,
	90%
		-webkit-transform: translate3d(-1px, 0, 0)
		-ms-transform: translate3d(-1px, 0, 0)
		transform: translate3d(-1px, 0, 0)

	20%,
	80%
		-webkit-transform: translate3d(2px, 0, 0)
		-ms-transform: translate3d(2px, 0, 0)
		transform: translate3d(2px, 0, 0)

	30%,
	50%,
	70%
		-webkit-transform: translate3d(-4px, 0, 0)
		-ms-transform: translate3d(-4px, 0, 0)
		transform: translate3d(-4px, 0, 0)

	40%,
	60%
		-webkit-transform: translate3d(4px, 0, 0)
		-ms-transform: translate3d(4px, 0, 0)
		transform: translate3d(4px, 0, 0)

@keyframes ionShake
	10%,
	90%
		-webkit-transform: translate3d(-1px, 0, 0)
		-ms-transform: translate3d(-1px, 0, 0)
		transform: translate3d(-1px, 0, 0)

	20%,
	80%
		-webkit-transform: translate3d(2px, 0, 0)
		-ms-transform: translate3d(2px, 0, 0)
		transform: translate3d(2px, 0, 0)

	30%,
	50%,
	70%
		-webkit-transform: translate3d(-4px, 0, 0)
		-ms-transform: translate3d(-4px, 0, 0)
		transform: translate3d(-4px, 0, 0)

	40%,
	60%
		-webkit-transform: translate3d(4px, 0, 0)
		-ms-transform: translate3d(4px, 0, 0)
		transform: translate3d(4px, 0, 0)

@-webkit-keyframes ionRotate
	100%
		-webkit-transform: rotate(360deg)
		-ms-transform: rotate(360deg)
		transform: rotate(360deg)

@keyframes ionRotate
  100%
		-webkit-transform: rotate(360deg)
		-ms-transform: rotate(360deg)
		transform: rotate(360deg)

@-webkit-keyframes ionBeat
	0%
		-webkit-transform: scale(.75)
		-ms-transform: scale(.75)
		transform: scale(.75)

	20%
		-webkit-transform: scale(1)
		-ms-transform: scale(1)
		transform: scale(1)

	40%
		-webkit-transform: scale(.75)
		-ms-transform: scale(.75)
		transform: scale(.75)

	60%
		-webkit-transform: scale(1)
		-ms-transform: scale(1)
		transform: scale(1)

	80%
		-webkit-transform: scale(.75)
		-ms-transform: scale(.75)
		transform: scale(.75)

	100%
		-webkit-transform: scale(.75)
		-ms-transform: scale(.75)
		transform: scale(.75)

@keyframes ionBeat
	0%
		-webkit-transform: scale(.75)
		-ms-transform: scale(.75)
		transform: scale(.75)

	20%
		-webkit-transform: scale(1)
		-ms-transform: scale(1)
		transform: scale(1)

	40%
		-webkit-transform: scale(.75)
		-ms-transform: scale(.75)
		transform: scale(.75)

	60%
		-webkit-transform: scale(1)
		-ms-transform: scale(1)
		transform: scale(1)

	80%
		-webkit-transform: scale(.75)
		-ms-transform: scale(.75)
		transform: scale(.75)

	100%
		-webkit-transform: scale(.75)
		-ms-transform: scale(.75)
		transform: scale(.75)

.ion-beat
  -webkit-animation-iteration-count: infinite
  animation-iteration-count: infinite
  -webkit-animation-timing-function: linear
  animation-timing-function: linear
  -webkit-animation-name: ionBeat
  animation-name: ionBeat
  -webkit-animation-duration: 0.82s
  animation-duration: 0.82s

.ion-shake
  -webkit-animation-iteration-count: infinite
  animation-iteration-count: infinite
  -webkit-animation-timing-function: linear
  animation-timing-function: linear
  -webkit-animation-name: ionShake
  animation-name: ionShake
  -webkit-animation-duration: 0.82s
  animation-duration: 0.82s

.ion-rotate
  -webkit-animation-iteration-count: infinite
  animation-iteration-count: infinite
  -webkit-animation-timing-function: linear
  animation-timing-function: linear
  -webkit-animation-name: ionRotate
  animation-name: ionRotate
  -webkit-animation-duration: 2s
  animation-duration: 2s

html
  font-size: 60%
  box-sizing: border-box

@media screen and ( min-width: 700px )
  html
    font-size: 62.5%

@media screen and ( min-width: 1400px )
  html
    font-size: 65%

h1
  font-size: 5rem

h2
  font-size: 4.5rem

h3
  font-size: 4rem

h4
  font-size: 3.5rem

h5
  font-size: 3rem

h6
  font-size: 2.5rem

p
  font-size: 1.8rem
EOF

# Add default layout
cat << EOF >> default.vue
<template>
  <ion-app>
    <Nuxt />
  </ion-app>
</template>

<style lang="sass">
@import style
</style>
EOF

# Exit of layouts folder
cd ../

# Add content of pages folder
cd pages

# Add index page
cat << EOF >> index.vue
<template>
  <ion-content>
    <ion-text>
      <h1>
        Hello, world!
        <md-heart-icon w="60px" h="60px" animate="beat" />
      </h1>
    </ion-text>
  </ion-content>
</template>

<script lang="ts">
import Vue from "vue"

export default Vue.extend({})
</script>
EOF

# Exit of pages folder
cd ../

# Commit
git add --all
git commit -m "[feature] First commit of project $PROJECT_NAME"
