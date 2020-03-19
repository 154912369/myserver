<!DOCTYPE html>
<html>
<head>
    <title>login test</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="ajax方式">
    <script src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="js/jquery.cookie.js"></script>
    <script type="text/javascript">
        function login() {
            $.ajax({
                //几个参数需要注意一下
                type: "POST",//方法类型
                url: "/login" ,//url
                data: $('#form1').serialize(),
                success: function (data) {
                    $.cookie("token",data["access_token"])
                    console.log(data);//打印服务端返回的数据(调试用)
                    if (data.code == 200) {
                        newurl = "/write?access_token="+data["access_token"]
                        window.open(newurl,'_self');
                        console.log("SUCCESS");
                    }else{
                        console.log(data["msg"]);
                    }
                    ;
                    //
                },
                error : function() {
                    console.log("Failed!");
                }
            });
        }
    </script>
<%--    <script type="text/javascript">--%>
<%--        token=$.cookie("token")--%>
<%--        $.ajax({--%>
<%--            url: "/xxx",--%>
<%--            beforeSend: function(xhr) {--%>
<%--                xhr.setRequestHeader("Authorization", 'Bearer '+ token);--%>
<%--            },--%>
<%--            success: function(data){ }--%>
<%--        });--%>
<%--    </script>--%>
</head>
<body>
<div id="form-div">
    <form id="form1" onsubmit="return false" action="##" method="post">
        <p>User:<input name="userName" type="text" id="txtUserName" tabindex="1" size="15" value=""/></p>
        <p>Password:<input name="password" type="password" id="TextBox2" tabindex="2" size="16" value=""/></p>
        <p><input type="button" value="log in" onclick="login()">&nbsp;<input type="reset" value="reset"></p>
    </form>
</div>
</body>
</html>