const request = require('supertest');
const app = require('./index');

describe('GET /', () => {
    it('should return detailed project results including infrastructure', async () => {
        const res = await request(app).get('/');
        expect(res.statusCode).toBe(200);
        expect(res.body.message).toBe('Hello ChuZone!');
        expect(res.body.status).toBe('Ready');
        expect(res.body.infrastructure).toBeDefined();
        expect(res.body.infrastructure.status).toMatch(/Ready|Provisioning.../);
    });
});

describe('GET /health', () => {
    it('should return status ok', async () => {
        const res = await request(app).get('/health');
        expect(res.statusCode).toBe(200);
        expect(res.body.status).toBe('ok');
    });
});
