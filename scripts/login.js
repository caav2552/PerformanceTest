import http from 'k6/http';
import { check, sleep } from 'k6';
import { options, config } from '../config/options.js';
import { loadCSV, randomItem } from '../utils/helpers.js';

const users = loadCSV('../data/users.csv');

export { options };

export default function () {
  const user = randomItem(users);
  const url = `${config.BASE_URL}${config.ENDPOINT}`;
  
  const payload = JSON.stringify({
    id: 0,
    title: `Login test for ${user.username}`,
    dueDate: new Date().toISOString(),
    completed: false
  });

  const response = http.post(url, payload, {
    headers: { 'Content-Type': 'application/json' },
  });

  check(response, {
    'status is 200': (r) => r.status === 200,
    'response time OK': (r) => r.timings.duration < config.RESPONSE_TIME_P95,
  });

  sleep(1); 
}
