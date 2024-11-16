const { authenticateUser } = require("../services/ldapService");

// Handle login requests
const login = async (username, password) =>{
    if(!username || !password){
        throw new Error("Username and password are required.");
    }

    try {
        const user = await authenticateUser(username, password);
        return user;
    } catch (err) {
        throw new Error("Authentication failed: " + err.message);
    }
}

module.exports = { login };