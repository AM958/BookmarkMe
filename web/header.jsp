
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <jsp:useBean id="random" class="java.util.Random" scope="application" />
    <title>${param.title}</title> <!-- this we get it from <c:param name="title" value="Picture Squirrel Home"></c:param> in home.jsp -->
    
    <style>
        body{
            background: url("images/bg${random.nextInt(9)}.jpg") no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }

    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="style.css" type="text/css"  />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script> 
    <script src="http://malsup.github.com/jquery.form.js"></script>
</head>

<body>
<div class="container">
    <div id="wrapper">
  
        <nav role="navigation" id="access">
            <a class="skip-link icon-reorder" title="Menu" href="#menu">Menu</a>
            <ul id="menu">
                <li class="${param.home}"><a class="icon-home" href="home.jsp" onmouseover="logo.src='images/bmlogoBrown4.gif'" 
                 onmouseout="logo.src='images/bmlogoWhite2.gif'"
                 border="0" alt="a fancy logo" >
                  <img style="height:auto; width:auto; max-width:300px; max-height:30px;" src="images/bmlogoWhite2.gif" id="logo"/> Home</a></li><!-- whitespace
             --><li class="${param.profile}"><a class="icon-group" href="#">My Friends</a></li><!-- whitespace
             --><li><a class="icon-leaf" href="public.me">Public Collections</a></li><!-- whitespace
             --><li><a class="icon-picture" href="#portfolio">Info</a></li><!-- whitespace
             --><li><a class="icon-envelope-alt" href="mailto:spirosscafidas@yahoo.gr?Subject=BookmarkMe%20Contact">Contact</a></li><!-- whitespace
             --><li>
                    <form action="people.jsp" method="post" class="form-inline icon-home" role="form">
                        <div class="form-group">&nbsp
                            <input type="text" name="name" placeholder="Search people" class="form-control">
                            <button type="submit" class="btn btn-default btn-md">
                                 &nbsp<span class="glyphicon glyphicon-search"></span>&nbsp
                            </button>
                         </div>            
                    </form></li>
            </ul>
        </nav>
    </div>
    <div >
	<div><br/>
            <img style="height:auto; width:auto; max-width:191px; max-height:37px;" src="images/logo.gif" />
            <span  ></span>
	</div>
    <br/>
    </div>

