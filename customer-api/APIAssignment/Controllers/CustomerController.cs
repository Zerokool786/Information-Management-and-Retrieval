using DataAccessLayer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


namespace APIAssignment.Controllers
{
    [ApiController]
    // [Route("[controller]")]
    public class CustomerController : ControllerBase
    {
        private readonly ILogger<CustomerController> _logger;
        private readonly ICustomerService _customerService;

        public CustomerController(ILogger<CustomerController> logger, ICustomerService customerService)
        {
            _logger = logger;
            _customerService = customerService;
        }

        [HttpPost]
        [Route("Customer")]
        public IActionResult SaveCustomer([FromBody] Customers _postData)
        {
            int i = _customerService.InsertUpdateCustomer(_postData, 0);
            if (i == 1)
                return Ok("Customer saved successfully");
            if (i == -1)
                return BadRequest("Customer already exists");
            else
                return BadRequest("Unable to save customer");
        }

        [HttpGet]
        [Route("Customer")]
        public IActionResult GetAllCustomer()
        {
            var customers = _customerService.GetAllCustomer();
            if (customers.Any())
                return Ok(customers);
            else
                return BadRequest("No customer exist");
        }

        [HttpPut]
        [Route("Customer/{id}")]
        public IActionResult UpdateCustomer([FromBody] Customers _postData, int id)
        {
            int i = _customerService.InsertUpdateCustomer(_postData, id);
            if (i == 2)
                return Ok("Customer updated successfully");
            if (i == -1)
                return BadRequest("Customer already exists");
            if (i == -2)
                return BadRequest("No customer exists");
            else
                return BadRequest("Unable to save customer");
        }

        [HttpDelete]
        [Route("Customer/{id}")]
        public IActionResult DeleteCustomer(int id)
        {
            if(id <= 0)
                return BadRequest("Id should be greator than zero");
            int i = _customerService.DeleteCustomer(id);
            if (i == 1)
                return Ok("Customer deleted successfully");
            else if (i == -1)
                return BadRequest("Customer not exists");
            else
                return BadRequest("Unable to delete customer");
        }
    }
}
