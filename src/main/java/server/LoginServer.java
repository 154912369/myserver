package server;

import org.springframework.beans.factory.annotation.Autowired;
import org.wf.jwtp.provider.Token;
import org.wf.jwtp.provider.TokenStore;

import javax.servlet.http.HttpServletRequest;

public class LoginServer {
    @Autowired
    private TokenStore tokenStore;

    public String login(String account, String password, HttpServletRequest request) {
        String userId = "renweijie";
        String[] permissions = {"admin"};
        String[] roles = {"dsfs"};
        Token token = tokenStore.createNewToken(userId, permissions, roles, 60 * 60 * 24 * 30);
//        return ResultMap.ok("登录成功").put("access_token",token.getAccessToken());
        return "sucess";
    }
}
