<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<link href="${path}/css/bootstrap.css" rel="stylesheet" />

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>무한스크롤 예제</title>
  <style>
    html, body{ margin: 0; }
    h1 {position: fixed; top: 0; width: 100%; height: 60px; text-align: center; background: white; margin: 0; line-height: 60px;}
    section .box {height: 500px; background: red;}
    section .box p {margin: 0; color: white; padding: 80px 20px;}
    section .box:nth-child(2n) {background: blue;}
  </style>
</head>
<body>         
  <h1>무한스크롤</h1>
  <section>
    <div class="box">
      <p>
        1번째 블록
      </p>
    </div>
    <div class="box">
      <p>
        2번째 블록
      </p>
    </div>
  </section>
  <script>
    var count = 2;
    window.onscroll = function(e) {
      console.log(window.innerHeight , window.scrollY,document.body.offsetHeight)
      if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) { 
        setTimeout(function(){
          var addContent = document.createElement("div");
          addContent.classList.add("box")
          addContent.innerHTML = `<p>${++count}번째 블록</p>`
          document.querySelector('section').appendChild(addContent);
        }, 1000)  
      }
    }
  </script>
</body>
</html>