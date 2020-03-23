package back;


import java.util.HashMap;
import java.util.Map;

public class ResultMap extends HashMap<String, Object> {


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