const request = require('supertest');
const app = require('../src');

describe('Attendance Endpoints', () => {
  let authToken;
  
  beforeAll(async () => {
    // Login and get token
    const response = await request(app)
      .post('/auth/login')
      .send({
        username: process.env.TEST_NAME,
        password: process.env.TEST_PASSWORD
      });
    authToken = response.body.accessToken;
  });

  test('GET /attendance should return attendance data', async () => {
    const response = await request(app)
      .get('/attendance')
      .set('Authorization', `Bearer ${authToken}`);
    
    expect(response.statusCode).toBe(200);
    expect(Array.isArray(response.body)).toBe(true);
  });
});
