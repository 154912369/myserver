package server;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.util.Assert;

import javax.sql.DataSource;
import java.text.SimpleDateFormat;
import java.util.*;

public class LogRecord implements LogRecordImp {

    private final JdbcTemplate jdbcTemplate;
    public LogRecord(DataSource dataSource1) {
        Assert.notNull(dataSource1, "DataSource required");
        this.jdbcTemplate = new JdbcTemplate(dataSource1);
    }
    public int logstore(String title,String context,String user){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        int rs = jdbcTemplate.update("insert logrecord (time, title, context,user) VALUES (?,?,?,?)", new Object[] {df.format(new Date()),title, context,user});
        return rs;
    }


    public List<Map<String, Object>> readlog(String user) {
        System.out.println("开始查询");
        return jdbcTemplate.queryForList("select id, time, title, context from logrecord where user=?",user);
    }

    public int delete(int id) {
        int rs = jdbcTemplate.update("delete from logrecord where id=?",id);
        return rs;
    }


    public HashMap<String,String> readonelog(int id) {
        SqlRowSet rs=jdbcTemplate.queryForRowSet("select * from logrecord where id=?",id);
        HashMap<String,String> map= new HashMap<>();
        if(rs.next()){
            map.put("title",rs.getString("title"));
            map.put("context",rs.getString("context"));
            map.put("user",rs.getString("user"));
        }
        return map;
    };
    public int update(int id, String title, String context) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        int rs = jdbcTemplate.update("update logrecord set title=?,context=?,time=? where id=?", title, context, df.format(new Date()), id);
        return rs;
    }


    public HashMap<String, String> userinfo(String user) {
        SqlRowSet rs=jdbcTemplate.queryForRowSet("select * from userinfo where user=?",user);
        HashMap<String,String> map= new HashMap<>();
        if(rs.next()){
            map.put("password",rs.getString("passwords"));
            map.put("randm_code",rs.getString("randm_code"));
        }
        return map;
    }


    public int updaterandom_code(String user, String random_code) {
        return jdbcTemplate.update("update userinfo set randm_code=? where user=?", random_code,user);

    }


    public int insertuser(String user, String password) {
        int rs = jdbcTemplate.update("insert userinfo (user, passwords, randm_code) VALUES (?,?,?)", new Object[] {user,password, "0000000000"});
        return rs;
    }


    public boolean checkusername(String user) {
        SqlRowSet rs=jdbcTemplate.queryForRowSet("select user from userinfo");
        if(rs.next()){
            if(rs.getString("user").equals(user)){
                return false;
            }
        }
        return true;
    }
}
