package backEndAPI.Controllers.Api;

import backEndAPI.Controllers.BaseController;
import backEndAPI.Model.Employee;
import backEndAPI.Model.User;
import backEndAPI.Services.EmployeeService;
import backEndAPI.Services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api/v1/user")
public class HomeController extends BaseController {

    @Autowired
    EmployeeService employeeService;

    @GetMapping("/profile")
    public ResponseEntity<User> profile(){
        User user=getCurrentUser();
        return new ResponseEntity<>(user, HttpStatus.OK);
    }


    @PostMapping("/addEmployee")
    public String addEmployee(@RequestBody Employee employee){
        User user=getCurrentUser();
        return employeeService.save(employee,user);
    }
    @GetMapping("/getEmployee/{id}")
    public ResponseEntity<Employee> getEmployee(@PathVariable  String id){
        Employee employee=employeeService.findById(Integer.valueOf(id));
        return new ResponseEntity<>(employee, HttpStatus.OK);
    }
    @GetMapping("/Employees")
     public   ResponseEntity<List<Employee>> getEmployees(){
        User user=getCurrentUser();
        List<Employee> employees=employeeService.findByUser(user);
        return new ResponseEntity<>(employees, HttpStatus.OK);
    }
    @GetMapping("/delete/{id}")
    public   ResponseEntity<List<Employee>> delete(@PathVariable  int id){
        employeeService.delete(id);
        User user=getCurrentUser();
        List<Employee> employees=employeeService.findByUser(user);
        return new ResponseEntity<>(employees, HttpStatus.OK);
    }

}
