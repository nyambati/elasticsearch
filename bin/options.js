const commandLineUsage = require('command-line-usage');

const minimist = require('minimist');

const sections = [
  {
    header: 'Elastic search indexer',
    content: 'Creates indexes from supplied data'
  },
  {
    header: 'Options',
    optionList: [
      {
        name: 'src',
        description: 'The location of the file to be indexed'
      },
      {
        name: 'index',
        description: 'Name of the index'
      },
      {
        name: 'type',
        description: 'Index type'
      },
      {
        name: 'help',
        description: 'Print this usage guide.'
      }
    ]
  }
];

module.exports = {
  usage: commandLineUsage(sections),
  args: minimist(process.argv.slice(2))
};
