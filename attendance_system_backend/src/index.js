// Import the required modules
const express = require('express');
const app = express();
const oracledb = require('oracledb');
const dotenv = require('dotenv');



const attendanceRoutes = require('./routes/attendanceRoutes');
const testRoutes = require('./routes/testConnection');
const authRoutes = require('./routes/authRoutes');

//Middleware
const authMiddleware = require('./middleware/auth.middleware');

// Load environment variables from a .env file (if you want to keep sensitive information like DB credentials safe)
dotenv.config();


// Middleware to parse JSON bodies
app.use(express.json());

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  next();
});

//router define
app.use('/attendance',authMiddleware,attendanceRoutes);
app.use('/test-connection',testRoutes);
app.use('/auth',authRoutes);


// Start the server
const PORT = process.env.PORT || 3000;
if (process.env.NODE_ENV !== 'test') {
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
}

module.exports = app;
