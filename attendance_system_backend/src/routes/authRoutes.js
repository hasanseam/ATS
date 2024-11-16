const express = require("express");
const router = express.Router();

const AuthController = require("../conttrollers/authController");

// Login route
router.post("/login", async (req, res) => {
    
    const { username, password } = req.body;
  
    try {
      const tokens = await AuthController.login(username, password);
      console.log(tokens);
      return res.status(200).json({
        message: "Authentication successful",
        accessToken: tokens.accessToken,
        refreshToken:tokens.refreshToken
      });
    } catch (err) {
      return res.status(401).json({
        message: "Authentication failed",
        error: err.message,
      });
    }
  });

  module.exports = router;