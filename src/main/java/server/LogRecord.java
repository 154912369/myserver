package server;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.util.Assert;
import org.wf.jwtp.util.JacksonUtil;

import javax.sql.DataSource;
import java.text.SimpleDateFormat;
import java.util.Date;

public class LogRecord implements LogRecordImp {

    private final JdbcTemplate jdbcTemplate;
    public LogRecord(DataSource dataSource1) {
        Assert.notNull(dataSource1, "DataSource required");
        this.jdbcTemplate = new JdbcTemplate(dataSource1);
    }
    public int logstore(String title,String context){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        int rs = jdbcTemplate.update("insert logrecord (time, title, context) VALUES (?,?,?)", new Object[] {df.format(new Date()),title, context});
        return rs;
    }
}
