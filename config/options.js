const BASE_URL = __ENV.BASE_URL || 'https://fakerestapi.azurewebsites.net/api/v1';
const ENDPOINT = __ENV.ENDPOINT || '/Activities';
const TEST_DURATION = __ENV.TEST_DURATION || '60s';
const TARGET_TPS = parseInt(__ENV.TARGET_TPS || '20');
const MAX_VUS = parseInt(__ENV.MAX_VUS || '50');
const PRE_ALLOCATED_VUS = parseInt(__ENV.PRE_ALLOCATED_VUS || '10');
const RESPONSE_TIME_P95 = parseInt(__ENV.RESPONSE_TIME_P95 || '1500');
const ERROR_RATE_THRESHOLD = parseFloat(__ENV.ERROR_RATE_THRESHOLD || '0.03');

export const config = {
  BASE_URL,
  ENDPOINT,
  TEST_DURATION,
  TARGET_TPS,
  MAX_VUS,
  PRE_ALLOCATED_VUS,
  RESPONSE_TIME_P95,
  ERROR_RATE_THRESHOLD,
};

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
