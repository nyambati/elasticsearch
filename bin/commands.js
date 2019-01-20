const Indexer = require('../indexer');
const Progress = require('ascii-progress');
const { client, ensureEsConnection } = require('./client');
const Render = require('./render');

class Commands {
  ['set:config'](args) {
    const { writeFileSync } = require('fs');
    const url = args.url || 'localhost:9200';
    const path = `${process.cwd()}/.env`;
    console.log(`Setting elasticsearch host to ${url}`);
    return writeFileSync(path, `ELASTICSEARCH_HOST=${url}`);
  }

  ['set:index'](args) {
    let error = Commands.indexSanityCheck(args);

    if (typeof error === 'string') {
      console.log(error);
      process.exit();
    }

    ensureEsConnection();
    const indexer = new Indexer(args.src, args.index, args.type, client);

    const progress = new Progress({
      schema: '[:bar.white] :current/:total :percent',
      total: indexer.data.length
    });

    return indexer.execute().subscribe(
      _ => progress.tick(),
      error => console.log(error),
      _ => {
        progress.clear();
        console.log(
          `${indexer.data.length} documents have been successfuly indexed`
        );
      }
    );
  }

  async search(args) {
    const {
      index,
      offset,
      type,
      size,
      fuzziness,
      search,
      fields
    } = Commands.parseSearchArguments(args);

    ensureEsConnection();

    try {
      const response = await client.search({
        index,
        body: {
          from: offset,
          type,
          size,
          query: {
            multi_match: {
              query: `${search}`,
              fuzziness,
              operator: 'and',
              fields,
              type: 'most_fields'
            }
          }
        }
      });

      return new Render().results(response.hits);
    } catch (error) {
      console.log(error.message);
      return;
    }
  }

  async ['list:indices']() {
    ensureEsConnection();
    try {
      const response = await client.indices.get({
        index: '_all'
      });
      return new Render().indices(Object.keys(response));
    } catch (error) {
      console.log(error);
      return;
    }
  }

  static parseSearchInput(search) {
    const array = search.split(':');
    const term = array.splice('-1')[0];
    return {
      fields: array.length <= 0 ? undefined : array,
      search: term
    };
  }

  static parseSearchArguments(args) {
    const term = String(args.term || args._[2]);
    const { fields, search } = Commands.parseSearchInput(term);
    return {
      search,
      index: args._[1],
      offset: args.offset || 0,
      size: args.count,
      type: args.type,
      // Fuzziness seems to break when using Numeric fields
      fuzziness: args.fuzzy ? 'auto' : undefined,
      fields
    };
  }

  static indexSanityCheck(args) {
    // Ensure that the args have exactly for options
    const required = ['src', 'index', 'type'];
    const keys = Object.keys(args);

    if (keys.length !== 4) {
      return `Index command expects 3 options got ${keys.length - 1}`;
    }

    //  ensure that the properties

    if (!required.every(key => keys.includes(key))) {
      return ` --index, --type, --src are the only valid options`;
    }

    return true;
  }
}

module.exports = Commands;
