import Vue from "vue"
import { defineCustomElements as Ionic } from "@ionic/core/loader"

Vue.use(Ionic)
Vue.config.ignoredElements = [/^ion-/]
