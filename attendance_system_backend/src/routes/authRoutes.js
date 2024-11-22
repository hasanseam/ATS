const express = require("express");
const router = express.Router();

const AuthController = require("../controllers/authController");

// Login route
router.post("/login", async (req, res) => {
    
    const { username, password } = req.body;
    try {
      const tokens = await AuthController.login(username, password);
      //console.log(tokens);
      res.status(200).json({
        message: "Authentication successful",
        accessToken: tokens.accessToken,
        refreshToken:tokens.refreshToken
      });
    } catch (err) {
        res.status(401).json({
        message: "Authentication failed",
        error: err.message,
      });
    }
  });

  module.exports = router;