<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>                                    
                                    <c:if test="${param.urlcollectionid eq param.collectionid}">
                                        <table class="table table-striped">
                                            <tr>
                                                <td><a href="<c:out value="${param.rowurl}"/>" target="_blank"><c:out value="${param.rowurl}"/></a><td/>
                                                <td><c:out value="${param.descr}"/><td/>
                                                <td >
                                                    <form id="rm_url" action="del_url.jsp" method="post" class="del" title="Delete URL">
                                                        <span title="">
                                                        <input type="hidden" name="uid" value="${param.userid}"/>
                                                        <input type="hidden" name="urlid" value="${param.urlid}"/>
                                                        <input type="hidden" name="collid" value="${param.urlcollectionid}"/>
                                                        <label for="mySubmit" class="btn" ><i class="glyphicon glyphicon-trash grow"></i></label>
                                                        <input id="mySubmit" type="submit" value="Go" class="hidden">
                                                        </span>
                                                    </form>
                                                </td>
                                            </tr>
                                        </table>
                                    </c:if>
                                