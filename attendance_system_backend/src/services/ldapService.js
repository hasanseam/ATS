const LdapClient = require("ldapjs-client");

//LDAP Configuration

const LDAP_SERVER = "ldap://ldap.forumsys.com";
const BASE_DN = "dc=example,dc=com";
const BIND_DN = "cn=read-only-admin,dc=example,dc=com";
const BIND_PASSWORD = "password";


/**
 * Authenticate a user against the LDAP server.
 * @param {string} username - The username to authenticate.
 * @param {string} password - The user's password.
 * @returns {Promise<object>} - The user's information if authenticated.
 */

const authenticateUser = async (username, password) => {
  const client = new LdapClient({
    url: LDAP_SERVER,
   });
   
  try {

    await client.bind(BIND_DN, BIND_PASSWORD);
    console.log("In authenticate user");

    const searchOptions = {
      filter: `(uid=${username})`,
      scope: "sub",
      attributes: ["dn"], // Fetch only the distinguished name (dn)
    };

    const result = await client.search(BASE_DN, searchOptions);

    if (!result || result.length === 0) {
      throw new Error("User not found.");
    }

    // User DN (Distinguished Name)
    const userDn = result[0].dn;
    await client.bind(userDn, password);

    return { username, dn: userDn };
  } catch (err) {
    throw new Error(err.message || "LDAP authentication failed.");
  } finally {
    await client.unbind();
  }
};

module.exports = { authenticateUser };
