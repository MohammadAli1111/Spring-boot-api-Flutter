package backEndAPI.Repositories;


import backEndAPI.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository("UserRepository")
public interface UserRepository extends JpaRepository<User, Integer> {

    User findByEmail(String email);
}
