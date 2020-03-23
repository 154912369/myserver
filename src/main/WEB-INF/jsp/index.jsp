<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
    <title>登录</title>
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
            document.getElementById("TextBox2").value="";
            document.getElementById("userName").value="";
        }

                var cookieArray=document.cookie.split("; ");
                var whether_token=false;
                post_data={}
                for (var i=0;i<cookieArray.length;i++){
                    var arr=cookieArray[i].split("=");
                    if(arr[0]=='token'){
                        token=arr[1];
                       post_data["access_token"]=token;
                    }
                }
                $.ajax({
                    //几个参数需要注意一下
                    type: "GET",//方法类型
                    url: "/verify" ,//url
                    data: post_data,
                    success: function (data) {
                        console.log(data);//打印服务端返回的数据(调试用)
                        if (data.code == 200) {
                            window.open("/alllog",'_self');
                        }else{
                            console.log("Failed!");
                        };
                        //
                    },
                    error : function() {
                        console.log("Failed!");

                    }
                });
        function login() {
            post_data={}
            post_data["userName"]=document.getElementById("txtUserName").value;
            $.ajax({
                //几个参数需要注意一下
                type: "GET",//方法类型
                url: "/random_code" ,//url
                data: {"user": post_data["userName"]},
                async: false,
                success: function (data) {
                    console.log(data);//打印服务端返回的数据(调试用)
                    if (data.code == 200) {
                        $.cookie("random",data.random_code);
                        console.log(data.random_code);

                    }else{
                        console.log("没有该用户");
                        $.cookie("random","wrong");
                        document.getElementById("returnvalue").innerHTML="没有该用户";
                    };
                    //
                },
                error : function() {
                    console.log("Failed!");
                    $.cookie("random","wrong");
                    document.getElementById("returnvalue").innerHTML="服务器错误";

                }
            });
            if( $.cookie("random")!=undefined&& $.cookie("random")!="wrong"){
                post_data["password"]=hex_md5(hex_md5(document.getElementById("TextBox2").value)+$.cookie("random"));
                $.ajax({
                    //几个参数需要注意一下
                    type: "POST",//方法类型
                    url: "/login" ,//url
                    data: post_data,
                    async: false,
                    success: function (data) {
                        $.cookie("token",data["access_token"])
                        $.cookie("user",data["user"])
                        console.log(data);//打印服务端返回的数据(调试用)
                        if (data.code == 200) {
                            window.open("/alllog",'_self');
                            console.log("SUCCESS");
                        }else{
                            console.log(data["msg"]);
                            document.getElementById("returnvalue").innerHTML="登录失败，请重试";
                        }
                        ;
                        //
                    },
                    error : function() {
                        console.log("Failed!");
                        document.getElementById("returnvalue").innerHTML="登录失败，请重试";
                    }
                });
            }

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
        <p>密码:&nbsp;&nbsp;<input name="password"  style="width:200px;height:20px" type="password" id="TextBox2" tabindex="2"  value=""/></p>
        <div id="returnvalue" style="color: red"></div>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input style="float:left" type="button" value="登录" onclick="login()"><input style="float:left;margin-left:10%;"  type="button" value="重置" onclick="reset()"></p>
    </form>
</div>
</body>
</html>