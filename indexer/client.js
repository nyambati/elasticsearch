const es = require('elasticsearch');

const client = new es.Client({
  host: process.env.ELASTICSEARCH_HOST
});

const ensureEsConnection = async () => {
  try {
    const response = await client.cluster.health({});
    if (response.status === 'red') {
      console.log(`Cluster is on red status, try again in a few`);
      process.exit(1);
    }
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

ensureEsConnection();

module.exports = client;
