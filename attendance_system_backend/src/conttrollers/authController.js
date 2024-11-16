const JWTService = require("../services/jwtService");
const { authenticateUser } = require("../services/ldapService");

class AuthController{
    static async login(username, password){
        if(!username || !password){
            throw new Error("Username and password are required.");
        }
        try {
            const user = await authenticateUser(username, password);
            //generate jwt token
            const accessToken = JWTService.generateToken(user);
            const refreshToken = JWTService.generateRefreshToken(user);
            return {
                accessToken,
                refreshToken
              };
        } catch (err) {
            throw new Error("Authentication failed: " + err.message);
        }
    }

    // keeping it for future use
    static async refreshToken(req, res) {
        const { refreshToken } = req.body;
        
        const decoded = JWTService.verifyToken(refreshToken);
        if (!decoded) {
          return res.status(401).json({ message: 'Invalid refresh token' });
        }
    
        const accessToken = JWTService.generateToken({
            username:decoded.username, 
            dn: decoded.dn
        });
    
        res.json({ accessToken });
      }
}


module.exports = AuthController;