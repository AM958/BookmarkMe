
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:import url="header.jsp">
    <c:param name="title" value="BookmarkMe"></c:param>
</c:import>
    <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
        url="${initParam.dbURL}"
        user="${initParam.dbUser}"  password="${initParam.dbPassword}"/>
    <div class="row" >
            
        <div class="col-xs-12  col-md-3"><br/><br/>   
            <blockquote id="blq">
                <p class="text-left">Manage and share your favorite links with the world or with your friends!</p>
            </blockquote>
        </div>
        <div class="col-xs-12  col-md-1"></div>
        <div class="col-xs-12  col-md-4">
            <div class="elem3">
                <h3>Login with email and password</h3>
                <form action="Login" method="post" class="form-inline" role="form">
                    <div class="form-group">
                        <span class="glyphicon glyphicon-envelope"></span>
                        <label class="sr-only" for="email">Email:</label>
                        <input type="text" name="email" placeholder="Enter email" class="form-control">
                    </div>
                    <div class="form-group">
                        <span class="glyphicon glyphicon-lock"></span>
                        <label class="sr-only" for="password">Password:</label>
                        <input type="password" name="password" placeholder="Enter password" class="form-control">
                    </div>
                    <br/>
                        <button type="submit" class="btn btn-primary" value="Login">Login</button>
                </form>
                <div>
                    <p class="text-warning">
                        If you are new user, please <a href="register.html">register</a>.
                    </p>
                </div>
                <br/>
            </div>
        </div>
        <div class="col-xs-12  col-md-1"></div>
        <div class="col-xs-12  col-md-3"><br/><br/>   
            <blockquote class="blockquote-reverse " id="blq">
                <p class="text-right">Create account, log in and get started now!</p>
            </blockquote>
        </div>
    </div>
    <hr/>
        
<c:import url="footer.jsp">
    <c:param name="pos" value="fixed"></c:param>
</c:import>
