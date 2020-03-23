package server;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface LogRecordImp {
    public int logstore(String title,String context,String user);
    public List<Map<String, Object>> readlog(String user);
    public  int delete(int id);
    public HashMap<String,String> readonelog(int id);
    public int update(int id,String title,String context);
    public HashMap<String,String> userinfo(String user);
    public int updaterandom_code(String user,String random_code);
    public int insertuser(String user,String password);
    public boolean checkusername(String user) ;

}
