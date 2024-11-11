const express = require('express');
const app = express();

const { getDBConnection } = require('../database/db');

// Test route to check the connection
app.get('/', async (req, res) => {
    try {
      // Try connecting to the Oracle DB
      console.log("Connection Okay");
      const connection = await getDBConnection()
      console.log('Successfully connected to Oracle Database');
      res.status(200).json({ message: 'Connected to Oracle Database successfully!' });
      // Close the connection after use
      await connection.close();
    } catch (error) {
      console.error('Error connecting to Oracle Database:', error);
      res.status(500).json({ error: 'Failed to connect to the database' });
    }
  });

  module.exports = app;