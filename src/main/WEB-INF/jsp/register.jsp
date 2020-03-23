<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
    <title>login test</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="ajax方式">
    <script src="js/jquery.min.js"></script>
    <script src="js/jquery.cookie.js"></script>
    <script src="js/jquery.easyui.min.js"></script>
    <script src="js/md5.js"></script>
    <script type="text/javascript">
        function reset(){
            document.getElementById("password").value="";
            document.getElementById("userName").value="";
}


function register() {
    post_data={}
    post_data["password"]=hex_md5(document.getElementById("password").value);
    post_data["userName"]=document.getElementById("txtUserName").value;
    $.ajax({
        //几个参数需要注意一下
        type: "POST",//方法类型
        url: "/registeruser" ,//url
        data: post_data,
        success: function (data) {

            if (data.code == 200) {
                $.cookie("token",data["access_token"]);
                $.cookie("user",data["user"]);
                document.getElementById("returnvalue").innerHTML="注册成功";
                window.open("/alllog",'_self');
            }else{
                console.log(data["用户名重复"]);
                document.getElementById("returnvalue").innerHTML="用户名重复";
            }
            ;
            //
        },
        error : function() {
            console.log("Failed!");
            document.getElementById("returnvalue").innerHTML="注册失败，请重试";
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
    <p>用户:&nbsp;&nbsp;<input name="userName" style="width:200px;height:20px" type="text" id="txtUserName" tabindex="1" value=""/></p>
    <p>密码:&nbsp;&nbsp;<input name="password"  style="width:200px;height:20px" type="password" id="password" tabindex="2"  value=""/></p>
    <div id="returnvalue" style="color: red">恭喜你获得内测资格，现在注册只需输入用户和密码，无需任何认证。密码后台是加密保存的，所以数据库里没有原始密码。但注意账号注销现在支持管理员后台修改。</div>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="float:left" type="button" value="注册" onclick="register()"><input style="float:left;margin-left:10%;"  type="button" value="重置" onclick="reset()"></p>
    </form>
    </div>
    </body>
    </html>