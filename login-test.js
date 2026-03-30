import http from 'k6/http';
import { check, sleep } from 'k6';
import { SharedArray } from 'k6/data';
import papaparse from 'https://jslib.k6.io/papaparse/5.1.1/index.js';

const BASE_URL = __ENV.BASE_URL || 'https://fakerestapi.azurewebsites.net/api/v1';
const ENDPOINT = __ENV.ENDPOINT || '/Activities';
const TEST_DURATION = __ENV.TEST_DURATION || '60s';
const TARGET_TPS = parseInt(__ENV.TARGET_TPS || '20');
const MAX_VUS = parseInt(__ENV.MAX_VUS || '50');
const PRE_ALLOCATED_VUS = parseInt(__ENV.PRE_ALLOCATED_VUS || '10');
const RESPONSE_TIME_P95 = parseInt(__ENV.RESPONSE_TIME_P95 || '1500');
const ERROR_RATE_THRESHOLD = parseFloat(__ENV.ERROR_RATE_THRESHOLD || '0.03');
const USERS_CSV_PATH = __ENV.USERS_CSV_PATH || './users.csv';

const csvData = new SharedArray('users', function () {
  return papaparse.parse(open(USERS_CSV_PATH), { header: true }).data;
});

export const options = {
  scenarios: {
    load_test: {
      executor: 'constant-arrival-rate',
      rate: TARGET_TPS,
      timeUnit: '1s',
      duration: TEST_DURATION,
      preAllocatedVUs: PRE_ALLOCATED_VUS,
      maxVUs: MAX_VUS,
    },
  },
  thresholds: {
    http_req_duration: [`p(95)<${RESPONSE_TIME_P95}`],
    http_req_failed: [`rate<${ERROR_RATE_THRESHOLD}`],
  },
};

export default function () {
  const user = csvData[Math.floor(Math.random() * csvData.length)];
  
  const url = `${BASE_URL}${ENDPOINT}`;
  const payload = JSON.stringify({
    id: 0,
    title: `Login test for ${user.username}`,
    dueDate: new Date().toISOString(),
    completed: false
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  const response = http.post(url, payload, params);

  check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 1.5s': (r) => r.timings.duration < RESPONSE_TIME_P95,
  });

  sleep(1);
}
