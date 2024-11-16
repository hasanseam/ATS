const jwt = require('jsonwebtoken');

const config = require('../jwt.config');

class JWTService{
    static generateToken(payload){
        return jwt.sign(payload, config.secret, { expiresIn: config.expiresIn });
    }

    static generateRefreshToken(payload) {
        return jwt.sign(payload, config.secret, { expiresIn: config.refreshExpiresIn });
      }

      static verifyToken(token) {
        try {
          return jwt.verify(token, config.secret);
        } catch (error) {
          return null;
        }
      }
}

module.exports = JWTService;