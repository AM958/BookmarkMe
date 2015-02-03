<script type="text/javascript" src="scripts.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page import="com.bm.model.User"%>

    <c:import url="header.jsp">
        <c:param name="title" value="BookmarkMe My Profile"></c:param>
    </c:import>
<!--    <script> 
        // wait for the DOM to be loaded 
        $(document).ready(function() { 
        // bind 'myForm' and provide a simple callback function 
            $('#new_url').ajaxForm(function() { 
                alert("URL successfully added"); 
                window.location.reload();
            }); 
        }); 
    </script>-->

 <c:if test="${not empty ReqError}">
    <script>
        window.addEventListener("load",function(){
             alert("${ReqError}");
        });
    </script>
</c:if>
    
<c:if test="${not empty ReqSuccess}">
    <script>
        window.addEventListener("load",function(){
             alert("${ReqSuccess}");
        });
    </script>
</c:if>

    <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
        url="${initParam.dbURL}"
        user="${initParam.dbUser}"  password="${initParam.dbPassword}"/>
    <sql:transaction dataSource="${ds}">
            <sql:query  var="result">
                SELECT * from collections WHERE ownerID="${User.id}";
            </sql:query>
                         
            <sql:query var="resultPb">
                SELECT * from collections WHERE ownerID="${User.id}" and privileges="Public" ORDER BY collections.add_ts DESC;
            </sql:query>
                        
            <sql:query var="resultPr">
                SELECT * from collections WHERE ownerID="${User.id}" and privileges="Private" ORDER BY collections.add_ts DESC;
            </sql:query>    

            <sql:query var="show_url">
                SELECT * from urls WHERE ownerID="${User.id}";
            </sql:query>    
    </sql:transaction>

    
    <jsp:useBean id="User" class="com.bm.model.User" scope="session"/>
    <div class="row" >
        <div class="col-sm-5" style="border-radius:20px;">
            <h3 class="elem2">My Private Bookmarks <span class="glyphicon glyphicon-lock"></span></h3>
            <div class="row" >
                <c:forEach var="row" items="${resultPr.rows}" varStatus="loopCount">
                    <c:import url="my_lists.jsp">
                        <c:param name="counter" value="${loopCount.count}"></c:param>
                        <c:param name="rowname" value="${row.name}"></c:param>
                        <c:param name="addts" value="${row.add_ts}"></c:param>
                        <c:param name="privs" value="${row.privileges}"></c:param>
                        <c:param name="collap" value="collapseA"></c:param>
                    </c:import>
                <c:forEach var="url_row" items="${show_url.rows}">
                    <c:import url="my_lists2.jsp">
                        <c:param name="rowurl" value="${url_row.url}"></c:param>
                        <c:param name="userid" value="${User.id}"></c:param>
                        <c:param name="urlid" value="${url_row.urlID}"></c:param>
                        <c:param name="collectionid" value="${row.collectionID}"></c:param>
                        <c:param name="urlcollectionid" value="${url_row.collectionID}"></c:param>
                        <c:param name="descr" value="${url_row.description}"></c:param>
                        <c:param name="respJsp" value="/home.jsp"></c:param>
                    </c:import>
                </c:forEach>
                </div>
                </div>
                </div>
                </div>
                
                </c:forEach>
            </div>
        </div>
        
        <div class="col-sm-5" style="border-radius:20px;">
            <h3 class="elem2">My Public Bookmarks <span class="glyphicon glyphicon-globe"></span></h3>
            <div class="row" >
                <c:forEach var="row" items="${resultPb.rows}" varStatus="loopCount2">
                    <c:import url="my_lists.jsp">
                        <c:param name="counter" value="${loopCount2.count}"></c:param>
                        <c:param name="rowname" value="${row.name}"></c:param>
                        <c:param name="addts" value="${row.add_ts}"></c:param>
                        <c:param name="privs" value="${row.privileges}"></c:param>
                        <c:param name="collap" value="collapseB"></c:param>
                    </c:import>
                    <c:forEach var="url_row" items="${show_url.rows}">
                    <c:import url="my_lists2.jsp">
                        <c:param name="rowurl" value="${url_row.url}"></c:param>
                        <c:param name="userid" value="${User.id}"></c:param>
                        <c:param name="urlid" value="${url_row.urlID}"></c:param>
                        <c:param name="collectionid" value="${row.collectionID}"></c:param>
                        <c:param name="urlcollectionid" value="${url_row.collectionID}"></c:param>
                        <c:param name="descr" value="${url_row.description}"></c:param>
                        <c:param name="respJsp" value="/home.jsp"></c:param>
                    </c:import>
                    </c:forEach>
                    </div>
                    </div>
                    </div>
                    </div>

                </c:forEach>
            </div>
        </div>
        <div class="col-sm-2" style="background-color:#689384; border-radius:20px;">
            <h3>Hi 
                <jsp:getProperty name="User" property="name"  /> 
            </h3>
            <strong>Your Email</strong>: <jsp:getProperty name="User" property="email"  /> 
            <hr/>
            <form action="Logout" method="post">
                <input type="submit" value="Logout" class="btn btn-danger btn-block">
            </form>
        
            <form action="people.jsp" method="post" class="form-horizontal" role="form">
                <div class="row" >
                    <div class="form-group col-sm-11">
                        <input type="text" name="name" placeholder="Search people" class="form-control">
                    </div>
                    <div class="col-sm-1">
                        <button type="submit" class="btn btn-default btn-md btn-block">
                            &nbsp<span class="glyphicon glyphicon-search"></span>&nbsp
                        </button>
                    </div>
                </div>
            </form>
            <button type="button" class="btn btn-success btn-block dropdown-toggle" data-toggle="collapse " data-target="#addurl">
                Add url to collection
            </button>
            <div id="addurl" class="collapse in">
                <form id="new_url" action="new_url" method="post" class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="sr-only" for="email">URL</label>
                        <input type="url" name="name" id="url_name" placeholder="Enter url" class="form-control">
                    </div>
                        
                    <div class="form-group">
                        <label class="sr-only" for="email">Description</label>
                        <input type="text" name="descr" id="url_description" placeholder="Enter decription" class="form-control">
                    </div>
                    
                    <input type="hidden" name="uid" value="${User.id}">
                    <input type="hidden" name="jsp" value="/home.jsp">
                    <span class="help-block">Select Collection</span>
                    <div class="form-group">
                        <label class="sr-only" for="sel2">Collection</label>  
                        <select name="colid" class="form-control" id="sel2">
                            <c:forEach var="row" items="${result.rows}">
                                <option value="${row.collectionID}">${row.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <input type="submit" value="Create" id="submit_url">
                </form>
            </div>
            <hr/>
            <button type="button" class="btn btn-primary btn-block dropdown-toggle" data-toggle="collapse" data-target="#newcollection">
                Create new collection
            </button>
            <div id="newcollection" class="collapse">
                <form id="new_col" action="new_collection" method="post" class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="sr-only" for="email">Name</label>
                        <input type="text" name="name"  placeholder="Enter name" class="form-control">
                    </div>
                    <input type="hidden" name="uid" value="${User.id}"> 
                    <input type="hidden" name="jsp" value="/home.jsp">
                    <div class="form-group">
                        <label class="sr-only" for="email">Access</label>
                        <strong>Access</strong>:
                        <select name="privileges" class="form-control" id="sel1">
                            <option value="Private">Owner</option>
                            <option value="Public">Public</option>
                            <option value="Friends">Friends</option>
                        </select>
                    </div>   
                    <input type="submit" value="Create">
                </form>
            </div>
            <hr/>
            <sql:query dataSource="${ds}" var="result">
                SELECT * from collections WHERE ownerID="${User.id}";
            </sql:query>
      
            <button type="button" class="btn btn-warning btn-block dropdown-toggle" data-toggle="collapse" data-target="#rmcollection">
                Remove Collection
            </button>
            <div id="rmcollection" class="collapse">
                <form id="rm_col" action="del_collection" method="post" class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="sr-only" for="rm_col">Remove Collection</label>  
                        <select name="colid" class="form-control" id="rm_col">
                            <c:forEach var="row" items="${result.rows}">
                                <option value="${row.collectionID}">${row.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <input type="hidden" name="uid" value="${User.id}">
                    <input type="hidden" name="jsp" value="/home.jsp">    
                    <input type="submit" value="Create">
                </form>
            </div>
        <br/><br/><br/>
        </div>

        
        </div>
        
    </body>
    
</html>
