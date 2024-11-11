// Import the required modules
const express = require('express');
const oracledb = require('oracledb');
const dotenv = require('dotenv');
const { getDBConnection } = require('./db');
const { createAttendance, getAllAttendance, updateAttendance, deleteAttendance } = require('./attendanceController');

// Load environment variables from a .env file (if you want to keep sensitive information like DB credentials safe)
dotenv.config();

// Initialize express app
const app = express();

// Middleware to parse JSON bodies
app.use(express.json());

// Oracle DB connection configuration


// Test route to check the connection
app.get('/test-connection', async (req, res) => {
  try {
    // Try connecting to the Oracle DB
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

// Route to create a new attendance record
app.post('/attendance', async (req, res) => {
  const { person_name } = req.body;
  if (!person_name) {
    return res.status(400).json({ error: 'Person name is required' });
  }
  try {
    await createAttendance(person_name);
    res.status(201).json({ message: 'Attendance record created successfully!' });
  } catch (error) {
    console.log(error)
    res.status(500).json({ error: 'Failed to create attendance recordss' });
  }
});

// Route to get all attendance records
app.get('/attendance', async (req, res) => {
  try {
    const attendance = await getAllAttendance();
    res.status(200).json(attendance);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch attendance records' });
  }
});

// Route to update attendance record
app.put('/attendance/:id', async (req, res) => {
  const { id } = req.params;
  const { person_name } = req.body;
  if (!person_name) {
    return res.status(400).json({ error: 'Person name is required' });
  }
  try {
    await updateAttendance(id, person_name);
    res.status(200).json({ message: 'Attendance record updated successfully!' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to update attendance record' });
  }
});

// Route to delete attendance record
app.delete('/attendance/:id', async (req, res) => {
  const { id } = req.params;
  try {
    await deleteAttendance(id);
    res.status(200).json({ message: 'Attendance record deleted successfully!' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete attendance record' });
  }
});


// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
