const { getDBConnection } = require('../database/db');

class AttendanceController {
  // Create an attendance record (Save student name, status, staff, and MAC address)
  static async createAttendance(studentID, studentName, inOut, staff, macAddress) {
    const connection = await getDBConnection();
    try {
      const result = await connection.execute(
        `INSERT INTO AttendanceLog (StudentID, StudentName, InOut, Staff, MacAddress)
         VALUES (:studentID, :studentName, :inOut, :staff, :macAddress)`,
        [studentID, studentName, inOut, staff, macAddress],
        { autoCommit: true } // Automatically commit the transaction
      );
      console.log('Attendance record saved:', result);
    } catch (error) {
      console.error('Error saving attendance record:', error);
      throw error;
    } finally {
      await connection.close();
    }
  }

  // Get all attendance records
  static async getAllAttendance() {
    const connection = await getDBConnection();
    try {
      const result = await connection.execute('SELECT * FROM AttendanceLog');
      return result.rows; // Return the rows from the query
    } catch (error) {
      console.error('Error fetching attendance records:', error);
      throw error;
    } finally {
      await connection.close();
    }
  }

  // Update attendance record (update student name, in/out status, staff, or MAC address by ID and Timestamp)
  static async updateAttendance(id, studentID, studentName, inOut, staff, macAddress) {
    const connection = await getDBConnection();
    try {
      const setClauses = [];
      const values = [];

      if (studentID) {
        setClauses.push('StudentID = :studentID');
        values.push(studentID);
      }
      if (studentName) {
        setClauses.push('StudentName = :studentName');
        values.push(studentName);
      }
      if (inOut) {
        setClauses.push('InOut = :inOut');
        values.push(inOut);
      }
      if (staff) {
        setClauses.push('Staff = :staff');
        values.push(staff);
      }
      if (macAddress) {
        setClauses.push('MacAddress = :macAddress');
        values.push(macAddress);
      }

      // Add the ID as a filter for the UPDATE query
      values.push(id);

      const query = `
        UPDATE AttendanceLog 
        SET ${setClauses.join(', ')} 
        WHERE ID = :id
      `;

      const result = await connection.execute(query, values, { autoCommit: true });
      console.log('Attendance record updated:', result);
    } catch (error) {
      console.error('Error updating attendance record:', error);
      throw error;
    } finally {
      await connection.close();
    }
  }

  // Delete attendance record by ID
  static async deleteAttendance(id) {
    const connection = await getDBConnection();
    try {
      const result = await connection.execute(
        `DELETE FROM AttendanceLog WHERE ID = :id`,
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
  }
}

module.exports = AttendanceController;
