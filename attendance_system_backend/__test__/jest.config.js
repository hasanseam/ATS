module.exports = {
    testEnvironment: 'node',
    testMatch: ['**/__tests__/**/*.test.js'],
    collectCoverageFrom: [
      'routes/**/*.js',
      'middleware/**/*.js'
    ],
    setupFilesAfterEnv: ['<rootDir>/jest.setup.js']
  };
  