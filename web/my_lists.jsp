<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
            
                <div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h5 class="panel-title" id="info" title="Click to view bookmarks"><i title="">
                                <a data-toggle="collapse" data-parent="#accordion" href="#${param.collap}${param.counter}" class="btn btn-default btn-block dropdown-toggle swing">
                                    <c:out value="${param.rowname}"/>  <br/>
                                <small>added on <c:out value="${param.addts}"/> with <c:out value="${param.privs}"/> privileges</small></a></i>
                            </h5>
                        </div>
                    <br/>
                        <div id="${param.collap}${param.counter}" class="panel-collapse collapse">
                            <div class="panel-body">
                                

