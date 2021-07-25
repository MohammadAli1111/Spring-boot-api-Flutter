package backEndAPI.Services;

import backEndAPI.Model.Employee;
import backEndAPI.Model.User;
import backEndAPI.Repositories.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("EmployeeService")
public class EmployeeService {
    @Autowired
    EmployeeRepository employeeRepository;

    @Transactional
    public String save(Employee employee,User user){
        try {
            employee.setUser(user);
            employeeRepository.save(employee);
        }catch (Exception exception){
            return "Failure";
        }
        return "Successfully";
    }
    @Transactional
    public Employee findById(int id){
        return  employeeRepository.findById(id).get();
    }
    @Transactional
    public List<Employee> findByUser(User user){
        return employeeRepository.findByUser(user);
    }
    @Transactional
    public void delete(int id){
        employeeRepository.deleteById(id);
    }
}
