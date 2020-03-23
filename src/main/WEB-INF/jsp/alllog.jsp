<%--
  Created by IntelliJ IDEA.
  User: 154912369
  Date: 20/3/19
  Time: 19:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        pre{
            white-space: pre-wrap;white-space: -moz-pre-wrap; white-space: -pre-wrap;white-space: -o-pre-wrap;word-wrap: break-word;
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
    <title>你的日志</title>
    <script>
    function logs() {
        window.open("/write","_self");
    }
    function logout() {
        if(document.getElementById("login").value=="登录"){
            window.open("/write","_self");
        }else{
            token=$.cookie("token");
            user=$.cookie("user");
            post_data={"user":user,"access_token":token};
            $.ajax({
                //几个参数需要注意一下
                type: "POST",//方法类型
                url: "/logout" ,//url
                data: post_data,
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("Authorization", 'Bearer '+ token);
                },
                success: function (data) {
                    if (data.code == 200) {

                        document.getElementById("returnvalue").innerHTML="退出成功";
                        document.getElementById("login").value="登录";
                        $.cookie("token","");
                    }else{
                        $.cookie("token","");
                        document.getElementById("login").value="登录";
                        document.getElementById("returnvalue").innerHTML="退出算是成功了吧";

                    }
                    ;
                    //
                },
                error : function() {
                    $.cookie("token","");
                    document.getElementById("login").value="登录";
                    document.getElementById("returnvalue").innerHTML="退出算是成功了吧";

                }
            });
        }

    }
</script>
</head>
<body>
<input type="button" value="写日志" onclick="logs()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="退出" id="login" onclick="logout()"/>
<div id="returnvalue" style="color: red"></div>
<br/><br/><br/><br/>
<div id="all_articles">
</div>
</body>

<script src="js/jquery.min.js"></script>
<script src="js/jquery.cookie.js"></script>
<script>
    function modify(id) {
        if($.cookie("token")==""){
            document.getElementById("returnvalue").innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;请先登录";
        }else {
            window.open("/modify_index?access_token=" + $.cookie("token") + "&id=" + id+"&user="+$.cookie("user"), "_self");
        }
    }
    function del(id) {
        if($.cookie("token")==""){
            document.getElementById("returnvalue").innerHTML="  &nbsp;&nbsp;&nbsp;&nbsp;            请先登录";
        }else{
        var a=window.confirm("您确定要删除记录吗");
        if(a){
            token=$.cookie("token");
            $.ajax({
                //几个参数需要注意一下
                type: "POST",//方法类型
                url: "/delete" ,//url
                data: {"id":id,"user":$.cookie("user")},
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("Authorization", 'Bearer '+ token);
                },
                success: function (data) {
                    if (data.code == 200) {
                        ele=document.getElementById(id)
                        ele.remove();
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
        }
    }
    var start_num=1;
    function elementappend(list, title,body,id){

        var objE = document.createElement("div");
        var ele="<div id=\"id?\"><div style=\"font-size: 25px\"><div style=\"float:left;\">?</div>" +
            "<div style=\"float:right;\">" +
            "<input type=\"button\" value=\"修改\" onclick=\"modify(this.parentNode.parentNode.parentNode.id)\">&nbsp;&nbsp;&nbsp;&nbsp;"+
            "<input type=\"button\" value=\"删除\" onclick=\"del(this.parentNode.parentNode.parentNode.id)\"></div></div>"+
            "<br /><br /><hr /><div><pre width='100%'>?</pre></div><hr  /><br /><br /><br /></div>"
        ele=ele.replace("?",id.toString())
        ele=ele.replace("?",list.toString()+"."+title);
        ele=ele.replace("?",body);
        return ele;
    }
    function context(){
        var all_art=document.getElementById("all_articles");
        var elements="";
        $.ajax({
            //几个参数需要注意一下
            type: "GET",//方法类型
            url: "/readlog" ,//url
            data:{"access_token":$.cookie("token"),"user":$.cookie("user")},
            success: function (data) {
                if(data.code==200){
                    if(data["numoflogs"]!=0){
                        var elements="";
                        for(i=0;i<data["numoflogs"];i++){
                            elements+=elementappend(i+1, data["title"+i.toString()],data["context"+i.toString()],data["id"+i.toString()]);

                        }
                        all_art.innerHTML=elements;
                    }else{
                        all_art.innerHTML="还没有日记";
                    }
                }else{
                    window.open("/","_self")
                }

                //
            },
            error : function() {
                all_art.innerHTML="查询错误";
            }
        });



    }
    context();
</script>
</html>
