const client = require("./client");
const Rx = require("rxjs");

class Indexer {
  constructor(path, index, type) {
    this.path = path;
    this.data = this.loadData(this.path);
    this.client = client;
    this.indexName = index;
    this.type = type;
    this.createIndex();
  }

  loadData(path) {
    path = require("path").resolve(path);
    return require(path);
  }

  async createIndex() {
    // check if the index already exist
    const index = this.indexName;

    if (await client.indices.exists({ index })) {
      console.log(`Index ${index} has already been created`);
      return;
    }

    try {
      await client.indices.create({ index });
      console.log(`Index ${index} has been successfully `);
    } catch (err) {
      throw err;
    }
  }

  execute() {
    const source = Rx.Observable.from(this.data)
      .delay(3000)
      .concatMap(payload =>
        client.index({ index: this.indexName, type: this.type, body: payload })
      );
    return source;
  }
}

module.exports = Indexer;
