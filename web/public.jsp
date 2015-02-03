<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page import="com.bm.model.User"%>

<c:import url="header.jsp">
    <c:param name="title" value="BookmarkMe My Profile"></c:param>
</c:import>
       <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
            url="${initParam.dbURL}"
            user="${initParam.dbUser}"  password="${initParam.dbPassword}"/>
 
            
       
        <h2 class="elem2" style="color:#5a4741 ; ">Latest Public Collections</h2><br/>
        <sql:transaction dataSource="${ds}">
        <sql:update  var="row">
                    SET @row=-1; </sql:update>
        <sql:query  var="result">
            SELECT * FROM (
                SELECT @row := @row +1 AS rownum, name, collectionID, add_ts
                FROM (
                    SELECT * FROM collections WHERE PRIVILEGES = "Public"
                            ORDER BY collections.add_ts DESC LIMIT 20
                ) AS sorted
           ) AS ranked WHERE rownum %3 =0;
        </sql:query>

        <sql:update  var="row">
                    SET @row=-1; </sql:update>
        <sql:query  var="result1">
            SELECT * FROM (
                SELECT @row := @row +1 AS rownum, name, collectionID, add_ts
                FROM (
                    SELECT * FROM collections WHERE PRIVILEGES = "Public"
                            ORDER BY collections.add_ts DESC LIMIT 20
                ) AS sorted
           ) AS ranked WHERE rownum %3 =1;
        </sql:query>

        <sql:update  var="row">
                    SET @row=-1; </sql:update>
        <sql:query  var="result2">
            SELECT * FROM (
                SELECT @row := @row +1 AS rownum, name, collectionID, add_ts
                FROM (
                    SELECT * FROM collections WHERE PRIVILEGES = "Public"
                            ORDER BY collections.add_ts DESC LIMIT 20
                ) AS sorted
           ) AS ranked WHERE rownum %3 =2;
        </sql:query>
        </sql:transaction>     
        <div class="row"   >
            <div class="col-xs-12 col-md-4" style="background-color:#689384;">
                <br/>
                <c:forEach var="row" items="${result.rows}" varStatus="loopCount">
                    <div class="panel-group swing" id="accordion" >
                        <div class="panel panel-default"  >   
                            <div class="panel-heading" >
                                <h5 class="panel-title" >
                                       <a id="wrapper" data-toggle="collapse" data-parent="#accordion" href="#collapse${loopCount.count}" class="btn btn-default btn-block icon-home swing" style="color:#5a4741 ; " >
                                        <c:out value="${row.name}"/><br/> 
                                        <small >added on <c:out value="${row.add_ts}"/> by user <c:out value="${row.ownerID}"/></small></a> 
                                    </h5>
                                <sql:query dataSource="${ds}" var="show_url">
                                    SELECT * from urls WHERE collectionID="${row.collectionID}";
                                </sql:query>
                                </div>
                                <div id="collapse${loopCount.count}" class="panel-collapse collapse">
                                    <div class="panel-body" >
                                        <c:forEach var="url_row" items="${show_url.rows}">  
                                            <table class="table table-hover">
                                            <tr>
                                                <td><c:out value="${url_row.description}"/></td>
                                                
                                                <td><a href="<c:out value="${url_row.url}"/>" target="_blank"  ><c:out value="${url_row.url}"/></a></td>
                                            </tr>
                                            </table>
                                        </c:forEach>
                                    </div>

                                </div>
                                
                            </div>
                        </div>
                </c:forEach>
            </div>
            <div class="col-xs-12 col-md-4" style="background-color:#689384;">
                <br/>
                <c:forEach var="row" items="${result1.rows}" varStatus="loopCount">
                    <div class="panel-group swing" id="accordion" >
                        <div class="panel panel-default"  >   
                            <div class="panel-heading" >
                                <h5 class="panel-title" >
                                       <a id="wrapper" data-toggle="collapse" data-parent="#accordion" href="#collapse1${loopCount.count}" class="btn btn-default btn-block icon-home swing" style="color:#5a4741 ; " >
                                        <c:out value="${row.name}"/><br/> 
                                        <small >added on <c:out value="${row.add_ts}"/> by user <c:out value="${row.ownerID}"/></small></a> 
                                    </h5>
                                <sql:query dataSource="${ds}" var="show_url">
                                    SELECT * from urls WHERE collectionID="${row.collectionID}";
                                </sql:query>
                                </div>
                                <div id="collapse1${loopCount.count}" class="panel-collapse collapse">
                                    <div class="panel-body" >
                                        <c:forEach var="url_row" items="${show_url.rows}">  
                                            <table class="table table-hover">
                                            <tr>
                                                <td><c:out value="${url_row.description}"/></td>
                                                
                                                <td><a href="<c:out value="${url_row.url}"/>" target="_blank"  ><c:out value="${url_row.url}"/></a></td>
                                            </tr>
                                            </table>
                                        </c:forEach>
                                    </div>

                                </div>
                                
                            </div>
                        </div>
                </c:forEach>
            </div>
            <div class="col-xs-12 col-md-4" style="background-color:#689384;">
                <br/>
                <c:forEach var="row" items="${result2.rows}" varStatus="loopCount">
                    <div class="panel-group swing" id="accordion" >
                        <div class="panel panel-default"  >   
                            <div class="panel-heading" >
                                <h5 class="panel-title" >
                                       <a id="wrapper" data-toggle="collapse" data-parent="#accordion" href="#collapse2${loopCount.count}" class="btn btn-default btn-block icon-home swing" style="color:#5a4741 ; " >
                                        <c:out value="${row.name}"/><br/> 
                                        <small >added on <c:out value="${row.add_ts}"/> by user <c:out value="${row.ownerID}"/></small></a> 
                                    </h5>
                                <sql:query dataSource="${ds}" var="show_url">
                                    SELECT * from urls WHERE collectionID="${row.collectionID}";
                                </sql:query>
                                </div>
                                <div id="collapse2${loopCount.count}" class="panel-collapse collapse">
                                    <div class="panel-body" >
                                        <c:forEach var="url_row" items="${show_url.rows}">  
                                            <table class="table table-hover">
                                            <tr>
                                                <td><c:out value="${url_row.description}"/></td>
                                                
                                                <td><a href="<c:out value="${url_row.url}"/>" target="_blank"  ><c:out value="${url_row.url}"/></a></td>
                                            </tr>
                                            </table>
                                        </c:forEach>
                                    </div>

                                </div>
                                
                            </div>
                        </div>
                </c:forEach>
            </div>
        </div>        
    </div>
<c:import url="footer.jsp">
    
</c:import>