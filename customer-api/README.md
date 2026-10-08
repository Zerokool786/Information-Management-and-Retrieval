# Customer Management REST API

A REST API built in C# with ASP.NET Core that lets an administrator manage customer records without a front end. Customer data is sent and returned as JSON, and all reads and writes go through SQL Server stored procedures.

## Endpoints

| Method | Endpoint | What it does |
|---|---|---|
| GET | `/Customer` | Returns every customer |
| POST | `/Customer` | Adds a new customer |
| PUT | `/Customer/{id}` | Updates an existing customer |
| DELETE | `/Customer/{id}` | Deletes a customer |

Each endpoint returns a clear message for every outcome. For example, adding the same customer twice returns `Customer already exists`, and updating an ID that isn't in the database returns `No customer exists`.

## Example

**Request:** `POST /Customer`

```json
{
  "firstName": "Jane",
  "lastName": "Doe",
  "phoneNumber": "001245",
  "title": "Ms."
}
```

**Response:** `Customer saved successfully`

## How it's built

- **API layer:** an ASP.NET Core Web API project with one controller for the four endpoints.
- **Data access layer:** a separate project with the Entity Framework Core database context, the customer model and a customer service.
- **Dependency injection:** the controller depends on an `ICustomerService` interface, and the service is registered at startup.
- **Stored procedures:** `UspGetAllCustomer`, `UspInsertUpdateCustomer` and `UspDeleteCustomer` handle the database work. Output parameters tell the API whether each action succeeded, so it can return the right message.
- **Swagger:** documents the endpoints and lets you try them in the browser.

## Project structure

```
APIAssignment.sln
APIAssignment/        API project: controller, startup and settings
DataAccessLayer/      Database context, customer service and model
```

## Running it locally

1. Install the .NET Core 3.1 SDK and SQL Server Express.
2. Create a database called `CustomerDB` with a `Customers` table (CustomerID, FirstName, LastName, PhoneNumber, Title) and the three stored procedures listed above.
3. Check the connection string in `APIAssignment/appsettings.json` matches your SQL Server instance.
4. Run the `APIAssignment` project. Swagger opens at `/swagger/index.html`.

## Tech

C#, ASP.NET Core, Entity Framework Core, Microsoft SQL Server, Swagger
