<%--
Created by IntelliJ IDEA.
User: 154912369
Date: 20/3/16
Time: 13:33
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>写入日志</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="ajax方式">
    <script src="js/jquery.min.js"></script>
    <script src="js/jquery.cookie.js"></script>
    <script type="text/javascript">
        try{
            $.ajax({
                //几个参数需要注意一下
                type: "GET",//方法类型
                url: "/verify" ,//url
                data: {"access_token":$.cookie("token")},
                success: function (data) {
                    console.log(data);//打印服务端返回的数据(调试用)
                    if (data.code != 200) {
                        window.open("/",'_self');
                    }
                    ;
                    //
                },
                error : function() {
                    console.log("Failed!");
                    window.open("/",'_self');
                }
            });
        }catch (e) {
            console.log("验证失败")
        }
        function reset(){
            var a=window.confirm("您确定要删除记录吗");
            if(!a)  //判断用户行为
            {
                return;//返回
            }

            document.getElementById("Context").value=""
            document.getElementById("Title").value=""
        }
        function record() {
            token=$.cookie("token");
            $.ajax({
                //几个参数需要注意一下
                type: "POST",//方法类型
                url: "/record" ,//url
                data: $('#form1').serialize()+"&"+$('#form2').serialize()+"&user="+$.cookie("user"),
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("Authorization", 'Bearer '+ token);
                },
                success: function (data) {
                    console.log(data);//打印服务端返回的数据(调试用)
                    if (data.code == 200) {
                        document.getElementById("returnvalue").innerHTML="写入成功";
                    }else{
                        document.getElementById("returnvalue").innerHTML="你的用户和cookie不符合，所以失败";
                    }
                    ;
                    //
                },
                error : function() {
                    document.getElementById("returnvalue").innerHTML="由于未知原因失败了";
                }
            });
        }
        function logs() {
            window.open("/alllog",'_self');
        }
    </script>
    <meta id="viewport" name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
    <style>
        input[type=text]{outline-style: none ;
            border: 1px solid #ccc;
            border-radius: 3px;
            padding: 14px;
            width: 99%;
            height:5%;
            font-size: 24px;
            font-family: "Microsoft soft";}
        textarea[type=text]{outline-style: none ;
            border: 1px solid #ccc;
            border-radius: 3px;
            padding: 14px;
            width: 99%;
            height:80%;
            font-size: 20px;
            font-family: "SimSun";}
    </style>
</head>
<body>

<div id="form-div">
    <form id="form1">
        <p>标题:<input name="title" type="text" id="Title" tabindex="1" size="16" value=""/></p>
    </form>
    <form id="form2" onsubmit="return false" action="##" method="post">
        <p>内容:<textarea name="context" type="text" id="Context" tabindex="2" size="5" value=""></textarea></p>
    </form>
    <p> <div style="width: 60px;float: left;margin-left: 20px"><input type="button" value="录入" onclick="record()">&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div style="width: 60px;float: left;margin-left: 20px"><input type="button" value="重置" onclick="reset()">&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div style="width: 60px;float: left;margin-left: 20px"><input type="button" value="日志" onclick="logs()"></div>
    <div id="returnvalue" style="color: red"></div>
    </p>
</div>

</body>
</html>