const commandLineUsage = require('command-line-usage');

const minimist = require('minimist');

const path = require('path').resolve('package.json');
const version = require(path).version;

const sections = [
  {
    header: `Elastic search indexer  version ${version}`,
    content: 'Index and search data'
  },
  {
    header: 'Usage',
    content: [
      '$ es index {bold --src} {bold --index} {bold --type} ',
      '$ es search [{bold index}] {bold --term} {bold --count} {bold --offset} {bold --type}',
      '$ es {bold --help}'
    ]
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
        name: 'count',
        description: 'Number of results to be returned'
      },
      {
        name: 'offset',
        description: 'The starting offset'
      },
      {
        name: 'url',
        description: '[host]:[port] Host of the elasticsearch cluster '
      },
      {
        name: 'fuzzy',
        description:
          'Enable fuzziness, [Works only when searching string valued columns]'
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
