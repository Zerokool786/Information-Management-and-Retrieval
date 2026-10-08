using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class CustomerService : ICustomerService
    {
        public CustomerContext _cDbContext;
        public CustomerService(CustomerContext cDbContext)
        {
            _cDbContext = cDbContext;
        }
        public List<Customers> GetAllCustomer()
        {
            var customers = _cDbContext.Customer.FromSqlRaw("[dbo].[UspGetAllCustomer]").ToList();
            return customers;
        }
        public int InsertUpdateCustomer(Customers param, int? Id)
        {
            var sqlParameterOut = new SqlParameter
            {
                ParameterName = "@outputparam",
                DbType = DbType.Int32,
                Direction = ParameterDirection.Output
            };
            _cDbContext.Database.ExecuteSqlRaw("Exec dbo.UspInsertUpdateCustomer @CustomerID,@Title,@FirstName,@LastName,@PhoneNumber, @outputparam OUT",
             new SqlParameter("@CustomerID", Id),
             new SqlParameter("@Title", param.Title),
             new SqlParameter("@FirstName", param.FirstName),
             new SqlParameter("@LastName", param.LastName),
             new SqlParameter("@PhoneNumber", param.PhoneNumber), sqlParameterOut);
            return  Convert.ToInt32(sqlParameterOut.Value);
        }

        public int DeleteCustomer(int Id)
        {
            var sqlParameterOut = new SqlParameter
            {
                ParameterName = "@pOutputParam",
                DbType = DbType.Int32,
                Direction = ParameterDirection.Output
            };
            _cDbContext.Database.ExecuteSqlRaw("Exec [dbo].[UspDeleteCustomer] @pCustomerId,@pOutputParam OUT",
             new SqlParameter("@pCustomerId", Id), sqlParameterOut);
            return Convert.ToInt32(sqlParameterOut.Value);
        }
    }
}
