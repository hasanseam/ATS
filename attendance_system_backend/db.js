// db.js
const oracledb = require('oracledb');
const dotenv = require('dotenv');

// Load environment variables from the .env file
dotenv.config();


const connectionConfig = {
    user: process.env.DB_USER,           // The database username (stored in .env)
    password: process.env.DB_PASSWORD,   // The database password (stored in .env)
    connectString: `${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_SERVICE_NAME}`,  // Database host and service name
  };

// Function to get a new DB connection
const getDBConnection = async () => {
  try {
    const connection = await oracledb.getConnection(connectionConfig);
    return connection;
  } catch (error) {
    console.error('Error connecting to Oracle Database:', error);
    throw error;
  }
};

module.exports = { getDBConnection };
