package backEndAPI.Controllers.Api;

import backEndAPI.Model.User;
import backEndAPI.Security.JwtResponse;
import backEndAPI.Security.SignInRequest;
import backEndAPI.Security.TokenUtil;
import backEndAPI.Services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping(value = "/api/v1/auth")
public class AuthController {

    @Autowired
    TokenUtil tokenUtil;

    @Autowired
    UserService userService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @PostMapping(value ="/login")
    public JwtResponse login(@RequestBody SignInRequest signInRequest) {

        final Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(signInRequest.getEmail(), signInRequest.getPassword())
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);

        UserDetails userDetails = userService.loadUserByUsername(signInRequest.getEmail());
        String token = tokenUtil.generateToken(userDetails);
        JwtResponse response = new JwtResponse(token);
        return response;
    }
    @PostMapping("/register")
    public String signUp(@RequestBody User user){

            if(userService.findByEmail(user.getEmail())==null) {
                userService.save(user);
            }else {
                return "This's Email Found";
            }

        return "Successfully";
    }

}
