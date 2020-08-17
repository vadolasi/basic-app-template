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
