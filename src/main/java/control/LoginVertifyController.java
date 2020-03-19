package control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import org.wf.jwtp.provider.Token;
import javax.servlet.http.HttpServletRequest;
import org.wf.jwtp.provider.TokenStore;
import org.wf.jwtp.util.JacksonUtil;
import server.LogRecordImp;

import java.util.HashMap;
import java.util.Map;

class ResultMap extends HashMap<String, Object> {
    public ResultMap() {
        put("state", true);
        put("code", 0);
        put("msg", "success");
    }

    public static ResultMap error(int code, String msg) {
        ResultMap r = new ResultMap();
        r.put("state", false);
        r.put("code", code);
        r.put("msg", msg);
        return r;
    }



    public static ResultMap ok(String msg) {
        ResultMap r = new ResultMap();
        r.put("code", 200);
        r.put("msg", msg);
        return r;
    }

    public static ResultMap ok(Map<String, Object> par) {
        ResultMap r = new ResultMap();
        r.put("code", 200);
        r.putAll(par);
        return r;
    }

    public static ResultMap ok() {
        return new ResultMap();
    }

    public ResultMap put(String key, Object value) {
        super.put(key, value);
        return this;
    }

}

@Controller
public class LoginVertifyController {

    @Autowired
    private TokenStore tokenStore;
    @Autowired
    private LogRecordImp LoginRecord;


    @PostMapping("/login")
    public ModelAndView login(String userName, String password, HttpServletRequest request) {
        String userId = userName;
        if(userName.equals("rwj")&&password.equals("123")){
            String[] permissions = {"admin"};
            String[] roles = {"dsfs"};
            System.out.println("验证成功");
            Token token = tokenStore.createNewToken(userId, permissions, roles, 60 * 60 * 24 * 30);
            ResultMap map=ResultMap.ok("登录成功").put("access_token",token.getAccessToken());
            System.out.println("录入成功");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }else {
            ResultMap map = ResultMap.error(0, "登录失败");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }
    }

    @RequestMapping("/")
    public String index() {
        return "index";
    }

    @RequestMapping("/write")
    public String sucess() {
        return "write";
    }

    @RequestMapping("/test")
    public String test() {
        return "test";
    }

    @PostMapping("/record")
    public ModelAndView record(String title, String context, HttpServletRequest request)
    {
        this.LoginRecord.logstore(JacksonUtil.toJSONString(title),JacksonUtil.toJSONString(context));
        ResultMap map=ResultMap.ok("写入成功");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
