package backEndAPI;

import backEndAPI.Model.User;
import backEndAPI.Services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class Initializer implements CommandLineRunner {
   @Autowired
   UserService userService;


    // Save User when Runtime
    @Override
    public void run(String... args) throws Exception {

        if(userService.findAll().isEmpty()) {
            userService.save(new User("Mohammad","Mohammad@gmail.com","12345"));
        }

    }
}
