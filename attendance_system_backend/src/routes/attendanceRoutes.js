const express = require("express");
const router = express.Router();
const {
  createAttendance,
  getAllAttendance,
  updateAttendance,
  deleteAttendance,
} = require("../conttrollers/attendanceController");

// Route to create a new attendance record

router.post("/", async (req, res) => {
  const { person_name } = req.body;
  if (!person_name) {
    return res.status(400).json({ error: "Person name is required" });
  }
  try {
    await createAttendance(person_name);
    res
      .status(201)
      .json({ message: "Attendance record created successfully!" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Failed to create attendance recordss" });
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

// Route to update attendance record
router.put("/:id", async (req, res) => {
  const { id } = req.params;
  const { person_name } = req.body;
  if (!person_name) {
    return res.status(400).json({ error: "Person name is required" });
  }
  try {
    await updateAttendance(id, person_name);
    res
      .status(200)
      .json({ message: "Attendance record updated successfully!" });
  } catch (error) {
    res.status(500).json({ error: "Failed to update attendance record" });
  }
});

// Route to delete attendance record
router.delete("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    await deleteAttendance(id);
    res
      .status(200)
      .json({ message: "Attendance record deleted successfully!" });
  } catch (error) {
    res.status(500).json({ error: "Failed to delete attendance record" });
  }
});

module.exports = router;
