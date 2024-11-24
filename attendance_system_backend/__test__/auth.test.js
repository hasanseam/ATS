const request = require('supertest');
const app = require('../src'); // You'll need to export your app

describe('Auth Endpoints', () => {
  test('POST /auth/login should login a user', async () => {
    const response = await request(app)
      .post('/auth/login')
      .send({
        username: process.env.TEST_NAME,
        password: process.env.TEST_PASSWORD
      });

    expect(response.statusCode).toBe(200);
    expect(response.body).toHaveProperty('accessToken');
  });
});
