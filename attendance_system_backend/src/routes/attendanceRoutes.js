const express = require("express");
const router = express.Router();
const {
  createAttendance,
  getAllAttendance,
  updateAttendance,
  deleteAttendance,
} = require("../controllers/attendanceController"); // Fixed typo in "controllers"

// Route to create a new attendance record
router.post("/", async (req, res) => {
  console.log(req.body)
  const { studentID, studentName, inOut, staff, macAddress } = req.body; // Match controller's method signature
  if (!studentID || !studentName || !inOut || !staff || !macAddress) {
    return res.status(400).json({
      error: "Student ID, Student name, In/Out status, Staff, and MAC address are required.",
    });
  }
  try {
    await createAttendance(studentID, studentName, inOut, staff, macAddress);
    res
      .status(201)
      .json({ message: "Attendance record created successfully!" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to create attendance record" });
  }
});

// Route to get all attendance records
router.get("/", async (req, res) => {
  try {
    const attendance = await getAllAttendance();
    res.status(200).json(attendance);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch attendance records" });
  }
});

// Route to update attendance record (now using ID as primary key)
router.put("/", async (req, res) => {
  const { id, studentID, studentName, inOut, staff, macAddress } = req.body; // Match controller's method signature
  if (!id || !studentID || !studentName || !inOut || !staff || !macAddress) {
    return res.status(400).json({
      error: "ID, Student ID, Student name, In/Out status, Staff, and MAC address are required to update a record.",
    });
  }
  try {
    await updateAttendance(id, studentID, studentName, inOut, staff, macAddress);
    res
      .status(200)
      .json({ message: "Attendance record updated successfully!" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to update attendance record" });
  }
});

// Route to delete attendance record (using ID as the primary key)
router.delete("/", async (req, res) => {
  const { id } = req.body; // Match controller's method signature
  if (!id) {
    return res.status(400).json({
      error: "ID is required to delete a record.",
    });
  }
  try {
    await deleteAttendance(id);
    res
      .status(200)
      .json({ message: "Attendance record deleted successfully!" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to delete attendance record" });
  }
});

module.exports = router;
