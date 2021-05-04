import * as mssql from 'mssql';

const sqlConfig = {
    user: `${process.env.AZURESQL_USER}`,
    password: `${process.env.AZURESQL_PASSWORD}`,
    server: `${process.env.AZURESQL}.database.windows.net`,
    database: `${process.env.AZURESQL_DB}`,
    options: {
        enableArithAbort: true
    }
}
const sleep = (delay) => new Promise((resolve) => setTimeout(resolve, delay));

export class EmployeeTable {
    // public data: Array<Employee>;

    public async getTable() {
        try {
            let pool = await this.connectToSQL(0);
            let resultSet = await pool.request().query('SELECT TOP 10 [WWI Employee ID], [Employee], [Preferred Name] FROM Dimension.Employee');
            let outputRecord = resultSet.recordset;

            return outputRecord;

        } catch (err) {
            console.error('Failed to retrieve record from SQL database.');
            console.error(err);
        }
    }

    // private SQL handler function
    private async connectToSQL(retryCount) {
        if (retryCount < 10) {
            try {
                let pool = await mssql.connect(sqlConfig);
                return pool;
            } catch (err) {
                console.log('retrying sql connection');
                console.log(retryCount);
                retryCount = retryCount + 1;
                console.error(err);
                await sleep(10000);
                return await this.connectToSQL(retryCount);
            }
        }
    }
}