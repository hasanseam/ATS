// Import the required modules
const express = require('express');
const oracledb = require('oracledb');
const dotenv = require('dotenv');
const { getDBConnection } = require('./database/db');


const attendanceRoutes = require('./routes/attendance');
const testRoutes = require('./routes/testConnection');

// Load environment variables from a .env file (if you want to keep sensitive information like DB credentials safe)
dotenv.config();

// Initialize express app
const app = express();

//router define
app.use('/attendance',attendanceRoutes);
app.use('/test-connection',testRoutes);


// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
