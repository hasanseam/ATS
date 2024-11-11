// attendanceController.js
const { getDBConnection } = require('../database/db');

// Create attendance record (Save person name)
const createAttendance = async (personName) => {
  const connection = await getDBConnection();
  try {
    const result = await connection.execute(
      `INSERT INTO save_attendance (person_name) VALUES (:person_name)`,
      [personName],
      { autoCommit: true }  // Automatically commit the transaction
    );
    console.log('Attendance record saved:', result);
  } catch (error) {
    console.error('Error saving attendance record:', error);
    throw error;
  } finally {
    await connection.close();
  }
};

// Get all attendance records
const getAllAttendance = async () => {
  const connection = await getDBConnection();
  try {
    const result = await connection.execute('SELECT * FROM SAVE_ATTENDANCE');
    return result.rows;  // Return the rows from the query
  } catch (error) {
    console.error('Error fetching attendance records:', error);
    throw error;
  } finally {
    await connection.close();
  }
};

// Update attendance record (update person name by id)
const updateAttendance = async (id, newPersonName) => {
  const connection = await getDBConnection();
  try {
    const result = await connection.execute(
      `UPDATE save_attendance SET person_name = :person_name WHERE id = :id`,
      [newPersonName, id],
      { autoCommit: true }
    );
    console.log('Attendance record updated:', result);
  } catch (error) {
    console.error('Error updating attendance record:', error);
    throw error;
  } finally {
    await connection.close();
  }
};

// Delete attendance record by id
const deleteAttendance = async (id) => {
  const connection = await getDBConnection();
  try {
    const result = await connection.execute(
      `DELETE FROM save_attendance WHERE id = :id`,
      [id],
      { autoCommit: true }
    );
    console.log('Attendance record deleted:', result);
  } catch (error) {
    console.error('Error deleting attendance record:', error);
    throw error;
  } finally {
    await connection.close();
  }
};

module.exports = { createAttendance, getAllAttendance, updateAttendance, deleteAttendance };
