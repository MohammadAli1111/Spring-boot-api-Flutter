package backEndAPI.Repositories;

import backEndAPI.Model.Employee;
import backEndAPI.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("EmployeeRepository")
public interface EmployeeRepository extends JpaRepository<Employee,Integer> {

    List<Employee> findByUser(User user);
}
