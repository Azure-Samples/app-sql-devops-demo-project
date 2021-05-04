import { AzureFunction, Context, HttpRequest } from "@azure/functions";
import {EmployeeTable} from './display-table';

const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
    let employeeData: EmployeeTable = new EmployeeTable();
    let resultSet = await employeeData.getTable();

    context.res = {
        // status: 200, /* Defaults to 200 */
        body: resultSet
    };

};

export default httpTrigger;