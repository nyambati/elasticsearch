const Table = require('cli-table2');

const hasNoData = data => {
  if (data.length > 0) return false;
  console.log();
  console.log('No results to display');
  console.log();
  return true;
};

const renderResultsTable = (data, totalResults) => {
  if (hasNoData(data)) return;

  const head = [' ', ...Object.keys(data[0]._source)];

  const results = new Table({ head });

  for (let index in data) {
    results.push([Number(index) + 1, ...Object.values(data[index]._source)]);
  }

  console.log(results.toString());
  console.log();
  console.log('TOTAL RESULTS FOUND: ', totalResults);
  console.log();
};

const renderIndicesTable = data => {
  if (hasNoData) return;

  data.forEach((index, i) => {
    indices.push([Number(i) + 1, index]);
  });

  console.log(indices.toString());
};

module.exports = {
  renderResultsTable,
  renderIndicesTable
};
