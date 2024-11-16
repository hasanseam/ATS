const JWTService = require('../services/jwtService');

const authMiddleware = (req, res, next) => {
    const authHeader = req.headers.authorization;
  
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({ message: 'No token provided' });
    }
  
    const token = authHeader.split(' ')[1];
    const decoded = JWTService.verifyToken(token);
  
    if (!decoded) {
      return res.status(401).json({ message: 'Invalid token' });
    }
  
    req.user = decoded;
    next();
  };
  
  module.exports = authMiddleware;