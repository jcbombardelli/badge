<template>
  <div id="app">
    <b-navbar toggleable="sm" type="light" variant="light" class="fixed-top">

      <b-navbar-brand :to="{name:'home'}">
        <img src="./assets/mutley.gif" width="30" height="30" class="d-inline-block align-top" alt />
        Mutley Badge's Collection
      </b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav class="justify-content-end">
        <b-navbar-nav>
          <b-nav-item :to="{name:'about'}">Issuers</b-nav-item>
          <b-nav-item :to="{name:'about'}">Badges</b-nav-item>
          <b-nav-item :to="{name:'about'}">My Badges</b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>

    <router-view />
  </div>
</template>

<script>

export default {
  name: 'app',

  beforeCreate () {
    this.$store.dispatch('registerWeb3')
  }
}
</script>

<style lang="scss">
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
