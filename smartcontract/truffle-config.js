module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    "localhost:8545": {
      network_id: "*",
      port: 8545,
      host: "127.0.0.1",
      consortium_id: 1564000645399
    }
  },
  mocha: {},
  compilers: {
    solc: {
      version: "0.5.9"
    }
  }
};
