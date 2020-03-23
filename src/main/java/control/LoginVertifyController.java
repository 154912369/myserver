package control;

import back.ResultMap;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import org.wf.jwtp.annotation.Logical;
import org.wf.jwtp.provider.Token;
import javax.servlet.http.HttpServletRequest;
import org.wf.jwtp.provider.TokenStore;
import org.wf.jwtp.util.CheckPermissionUtil;
import org.wf.jwtp.util.SubjectUtil;
import org.wf.jwtp.util.TokenUtil;
import server.LogRecordImp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import server.Password;


@Controller
public class LoginVertifyController {

    @Autowired
    private TokenStore tokenStore;
    @Autowired
    private LogRecordImp LoginRecord;


    @PostMapping("/login")
    public ModelAndView login(String userName, String password, HttpServletRequest request) throws Exception {
        HashMap<String,String> user=LoginRecord.userinfo(userName);
        if(user.get("password")==null){
            ResultMap map = ResultMap.error(301, "不存在用户");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }
        String result = Password.GetMD5Code(user.get("password")+user.get("randm_code"));
        if(result.equals(password)){
            String[] permissions = {"admin"};
            String[] roles = {"dsfs"};
            Token token = tokenStore.createNewToken(userName, permissions, roles, 60 * 60 * 24 * 30);
            ResultMap map=ResultMap.ok("登录成功").put("access_token",token.getAccessToken());
            map.put("user",userName);
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }else {
            ResultMap map = ResultMap.error(302, "登录失败");
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

    @RequestMapping("/register")
    public String register() {
        return "register";
    }

    @PostMapping("/record")
    public ModelAndView record(String title, String context, String user, HttpServletRequest request)
    {
        Token token = SubjectUtil.getToken(request);
        if(token.getUserId().equals(user)){
            LoginRecord.logstore(title,context,user);
            ResultMap map=ResultMap.ok("写入成功");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }else{
            ResultMap map=ResultMap.error(301,"用户与token验证失败");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }

    }

    @RequestMapping("/alllog")
    public String logs() {
        return "alllog";
    }

    @GetMapping("/readlog")
    public ModelAndView login(String user, HttpServletRequest request) {
        Token token = SubjectUtil.getToken(request);
        List<Map<String, Object>> logs=LoginRecord.readlog(token.getUserId());
        ResultMap map=ResultMap.ok("写入成功");
        map.put("numoflogs",logs.size());
        for(int i=0;i<logs.size();i++){
            map.put("title"+String.valueOf(i), logs.get(i).get("title"));
            map.put("context"+String.valueOf(i), logs.get(i).get("context"));
            map.put("id"+String.valueOf(i), logs.get(i).get("id"));
        }

        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @PostMapping("/delete")
    public ModelAndView delete(String id,String user, HttpServletRequest request)
    {
        Token token = SubjectUtil.getToken(request);
        int id_int=Integer.parseInt(id.substring(2));
        HashMap<String,String> result=LoginRecord.readonelog(id_int);
        if(result.get("user").equals(user)){
            int rs=LoginRecord.delete(id_int);
            ResultMap map=ResultMap.ok("写入成功");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }else{
            ResultMap map=ResultMap.error(301,"用户与token不符合");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }

    }

    @RequestMapping("/modify_index")
    public  String modify_index(ModelMap map, String id,String user){
        int id_int=Integer.parseInt(id.substring(2));
        HashMap<String,String> result=LoginRecord.readonelog(id_int);
        if(result.get("user").equals(user)) {
            map.put("title",result.get("title"));
            map.put("context",result.get("context"));
            map.put("id",id);
        }else{
            map.put("title","你他妈的输错了");
            map.put("context","你他妈的输错了");
            map.put("id","id-1");
        }
        return "modify_index";
    }

    @PostMapping("/modify")
    public ModelAndView modify(String title,String context,String id,String user,HttpServletRequest request){
        Token token = SubjectUtil.getToken(request);
        int id_int=Integer.parseInt(id.substring(2));
        if(token.getUserId().equals(user)){
            LoginRecord.update(id_int,title,context);
            ResultMap map=ResultMap.ok("写入成功");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }else{
            ResultMap map=ResultMap.error(301,"用户与token验证失败");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }


    }

    @GetMapping("/verify")
    public ModelAndView modify(){
            ResultMap map=ResultMap.ok("验证成功");
            return new ModelAndView(new MappingJackson2JsonView(), map);

    }

    @GetMapping("/random_code")
    public ModelAndView RandomCodey(String user){
        String  random_code= RandomStringUtils.randomAlphanumeric(10);
        int rs=LoginRecord.updaterandom_code(user, random_code);
        if(rs==0){
            ResultMap map = ResultMap.error(301, "不存在用户");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }else{
            ResultMap map = ResultMap.ok("成功修改");
            map.put("random_code",random_code);
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }

    }

    @PostMapping("/registeruser")
    public ModelAndView registeruser(String userName, String password, HttpServletRequest request) throws Exception {

        if(LoginRecord.checkusername(userName)){
            LoginRecord.insertuser(userName,password);
            String[] permissions = {"admin"};
            String[] roles = {"dsfs"};
            Token token = tokenStore.createNewToken(userName, permissions, roles, 60 * 60 * 24 * 30);
            ResultMap map=ResultMap.ok("登录成功").put("access_token",token.getAccessToken());
            map.put("user",userName);
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }else {
            ResultMap map = ResultMap.error(302, "注册失败，用户名重复");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }
    }

    @PostMapping("/logout")
    public ModelAndView logout(String user, String access_token, HttpServletRequest request){

        if(tokenStore.removeToken(user, access_token)!=0){
            ResultMap map=ResultMap.ok("注销成功");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }else {
            ResultMap map = ResultMap.error(302, "注销失败");
            return new ModelAndView(new MappingJackson2JsonView(), map);
        }
    }
}
