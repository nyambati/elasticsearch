const { client } = require('./client');
const Rx = require('rxjs');
const path = require('path');

class Indexer {
  constructor(path, index, type) {
    this.path = path;
    this.data = this.loadData(this.path);
    this.client = client;
    this.indexName = index;
    this.type = type;
    this.createIndex();
  }

  loadData(url) {
    if (!path.extname(url) === '.json') {
      console.log('Only json data format is supported for now');
      return [];
    }
    return require(path.resolve(url));
  }

  async createIndex() {
    const index = this.indexName;
    // Reset index if it exists
    if (await client.indices.exists({ index })) {
      console.log(`Index ${index} already exist resetting..`);
      await client.indices.delete({ index });
    }

    // Create the index with given index name
    try {
      await client.indices.create({ index });
      console.log(`Index ${index} has been successfully created`);
    } catch (err) {
      throw err;
    }
  }

  // This function add data to the index
  execute() {
    const source = Rx.Observable.from(this.data)
      // delay each insert by a second to avoid indexing errors.
      .delay(1000)
      .concatMap(payload =>
        client.index({ index: this.indexName, type: this.type, body: payload })
      );
    return source;
  }
}

module.exports = Indexer;
