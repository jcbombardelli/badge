import Vue from 'vue'
import Vuex from 'vuex'
import web3 from './web3'
import getWeb3 from '../util/getWeb3'

Vue.use(Vuex)

export const store = new Vuex.Store({
  strict: true,
  web3,
  mutations: {
    registerWeb3Instance (state, payload) {
      console.log('registerWeb3instance Mutation being executed', payload)
      let web3Copy = web3
      web3Copy.account = payload.account
      web3Copy.networkId = payload.networkId
      web3Copy.balance = parseInt(payload.balance, 10)
      web3Copy.isInjected = payload.injectedWeb3
      web3Copy.web3Instance = payload.web3
      state.web3 = web3Copy
    }
  },
  actions: {
    registerWeb3 ({ commit }) {
      console.log('registerWeb3 Action being executed')
      getWeb3.then(result => {
        console.log('committing result to registerWeb3Instance mutation')
        commit('registerWeb3Instance', result)
      }).catch(e => {
        console.log('error in action registerWeb3', e)
      })
    }
  }
})
