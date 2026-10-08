using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public interface ICustomerService
    {
        List<Customers> GetAllCustomer();

        int InsertUpdateCustomer(Customers objCustomer, int? Id);

        int DeleteCustomer(int Id);
    }
}
