
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
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
        
        
              
            <sql:update dataSource="${ds}">

                INSERT INTO urls(url, collectionID, ownerID, description) VALUES (?, ?, ?, ?);
                <sql:param value="${param.name}" />
                <sql:param value="${param.colid}" />
                <sql:param value="${param.uid}"/>
                <sql:param value="${param.descr}" />
            </sql:update>
       
    </body>
</html>
