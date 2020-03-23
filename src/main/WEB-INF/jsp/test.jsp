<%--
  Created by IntelliJ IDEA.
  User: 154912369
  Date: 20/3/17
  Time: 15:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="js/jquery.min.js"></script>
    <script src="js/jquery.cookie.js"></script>
    <script>
        token=$.cookie("token")
        function test() {
            $.get("/sucess", {access_token: token}, function (data) {
            });
        }
    </script>
    <title>Title</title>
</head>
<body>
test
</body>
</html>
