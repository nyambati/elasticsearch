const Table = require('cli-table2');

const table = new Table({
  head: [
    'ℹ️',
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
  ],
  colWidths: [5, 15, 10, 10, 60, 10, 10, 10, 7, 15, 10, 10, 10]
});

const renderTable = (data, totalResults) => {
  if (data.length === 0) {
    console.log('================== No results to display =================');
    return;
  }

  for (let index in data) {
    table.push([Number(index) + 1, ...Object.values(data[index]._source)]);
  }
  console.log(table.toString());
  console.log();
  console.log('TOTAL RESULTS FOUND: ', totalResults);
  console.log();
};

module.exports = renderTable;
