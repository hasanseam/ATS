// Import the required modules
const express = require('express');
const oracledb = require('oracledb');
const dotenv = require('dotenv');



const attendanceRoutes = require('./routes/attendanceRoutes');
const testRoutes = require('./routes/testConnection');
const authRoutes = require('./routes/authRoutes');

// Load environment variables from a .env file (if you want to keep sensitive information like DB credentials safe)
dotenv.config();

// Initialize express app
const app = express();

// Middleware to parse JSON bodies
app.use(express.json());

//router define
app.use('/attendance',attendanceRoutes);
app.use('/test-connection',testRoutes);
app.use('/auth',authRoutes);


// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
