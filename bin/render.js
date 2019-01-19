const Table = require('cli-table2');

class Render {
  hasNoData(data) {
    if (!data && !(data instanceof Object)) return false;
    if (data.length > 0) return false;
    console.log();
    console.log('No results to display');
    console.log();
    return true;
  }

  results(data) {
    if (this.hasNoData(data.hits)) return;
    const results = data.hits;

    const head = [' ', ...Object.keys(results[0]._source)];

    const table = new Table({ head, wordWrap: true });

    results.forEach((result, index) =>
      table.push([Number(index) + 1, ...Object.values(results[index]._source)])
    );

    console.log(table.toString());
    console.log();
    console.log('TOTAL RESULTS FOUND: ', data.total);
    console.log();
  }

  indices(data) {
    if (this.hasNoData) return;

    data.forEach((index, i) => {
      indices.push([Number(i) + 1, index]);
    });

    console.log(indices.toString());
  }
}

module.exports = Render;
