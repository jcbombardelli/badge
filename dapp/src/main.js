import Vue from 'vue'
import App from './App.vue'
import router from './router'
import { store } from './store/index'
import './registerServiceWorker'

/** Bootstrap 4 */
import BootstrapVue from 'bootstrap-vue'
import './assets/bootstrap.scss'
Vue.use(BootstrapVue)

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
