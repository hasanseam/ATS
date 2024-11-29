const express = require("express");
const router = express.Router();

const StudentController = require("../controllers/studentController");

// Get student by ID route
router.get("/:id", async (req, res) => {
    try {
        const studentId = req.params.id;
        const student = await StudentController.getStudent(studentId);
        
        if (!student) {
            return res.status(404).json({
                message: "Student not found"
            });
        }

        res.status(200).json({
            message: "Student retrieved successfully",
            data: student
        });
        
    } catch (err) {
        res.status(500).json({
            message: "Error retrieving student",
            error: err.message
        });
    }
});

module.exports = router;