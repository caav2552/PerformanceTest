import { SharedArray } from 'k6/data';
import papaparse from 'https://jslib.k6.io/papaparse/5.1.1/index.js';

export function loadCSV(filePath) {
  return new SharedArray('csvData', function () {
    return papaparse.parse(open(filePath), { header: true }).data;
  });
}

export function randomItem(array) {
  return array[Math.floor(Math.random() * array.length)];
}
