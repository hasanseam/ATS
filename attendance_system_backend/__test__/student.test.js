const request = require('supertest');
const app = require('../src');

describe('Student Endpoints', () => {
    test('GET /student/1000 should login get a user', async () => {
      const response = await request(app)
        .get('/student/1000')
        .send({
        });
      expect(response.statusCode).toBe(200);
    });
  });
  