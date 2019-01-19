const Table = require('cli-table2');

const results = new Table({
  head: [
    ' ',
    'Passenger Id',
    'Survived',
    'Pclass',
    'Passenger Name',
    'Sex',
    'Age',
    'SibSp',
    'Parch',
    'Ticket',
    'Fare',
    'Cabin',
    'Embarked'
  ]
});

const indices = new Table({
  head: [' ', 'indices'],
  colWidths: [5, 35]
});

const renderResultsTable = (data, totalResults) => {
  if (data.length === 0) {
    console.log('================== No results to display =================');
    return;
  }

  for (let index in data) {
    results.push([Number(index) + 1, ...Object.values(data[index]._source)]);
  }
  console.log(results.toString());
  console.log();
  console.log('TOTAL RESULTS FOUND: ', totalResults);
  console.log();
};

const renderIndicesTable = data => {
  if (data.length <= 0) {
    console.log('================== No results to display =================');
    return;
  }

  data.forEach((index, i) => {
    indices.push([Number(i) + 1, index]);
  });

  console.log(indices.toString());
};

module.exports = {
  renderResultsTable,
  renderIndicesTable
};
