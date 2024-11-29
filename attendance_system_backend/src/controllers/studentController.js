const { getDBConnection } = require('../database/db');

class StudentController{
    static async getStudent(id){
        const connection = await getDBConnection();
        try {
            const result = await connection.execute(
                `SELECT id, name FROM student WHERE id = :id`,
                [id],
                { outFormat: connection.OBJECT }
            );

            // Return the first student record
            return result.rows[0];
            
        } catch (error) {
            console.error('Error fetching student:', error);
            throw error;
        } finally {
            await connection.close();
        }
    }
}

module.exports = StudentController;