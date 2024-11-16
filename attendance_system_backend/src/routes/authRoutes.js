const express = require("express");
const router = express.Router();

const { login } = require("../conttrollers/authController");

// Login route
router.post("/login", async (req, res) => {
    console.log(req.body);
    const { username, password } = req.body;
  
    try {
      const user = await login(username, password);
      return res.status(200).json({
        message: "Authentication successful",
        user,
      });
    } catch (err) {
      return res.status(401).json({
        message: "Authentication failed",
        error: err.message,
      });
    }
  });

  module.exports = router;