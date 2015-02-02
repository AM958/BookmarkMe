

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="2; url=/bm101/home.jsp" />
        <title>JSP Page</title>
    </head>
    <body>
        <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
            url="${initParam.dbURL}"
            user="${initParam.dbUser}"  password="${initParam.dbPassword}"/>
        
        <h1>You are not supposed to be here!</h1>
            
        <sql:update dataSource="${ds}">
             DELETE FROM collections WHERE ownerID="${param.uid}" AND collectionID="${param.colid}"; 
        </sql:update>
            
    </body>
</html>