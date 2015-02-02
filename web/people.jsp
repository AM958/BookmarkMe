
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page import="com.bm.model.User"%>

<c:import url="header.jsp">
    <c:param name="title" value="BookmarkMe My Profile"></c:param>
</c:import>
        <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
            url="${initParam.dbURL}"
            user="${initParam.dbUser}"  password="${initParam.dbPassword}"/>
        
        
        <ul class="elem">
            <li><p><b>Search Results for:</b>
                    ${param.name}
        </ul>
            
        <sql:query dataSource="${ds}" var="result">
            
            SELECT * FROM users WHERE username="${param.name}";
        </sql:query>
            
        <c:forEach var="row" items="${result.rows}">
            <form action="profile.jsp" method="post" class="elem2">
                    <input type="hidden" name="name" value="${row.username}">
                    <input type="hidden" name="uid" value="${row.UserID}">
                    <button type="submit" class="btn btn-link btn-md btn-block">
                        ${row.username}
                    </button>
                <br/>
            </form>
        </c:forEach>    
    </body>
</html>