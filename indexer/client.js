const es = require("elasticsearch");

const client = new es.Client({
  host: process.env.ELASTICSEARCH_HOST
});

module.exports = client;
