<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My WebSocket</title>
  </head>
  
  <body>
    Welcome<br/>
    <input id="text" type="text" /><button onclick="send()">Send</button>    <button onclick="closeWebSocket()">Close</button>
    <div id="message">
    </div>
  </body>
  
  <script type="text/javascript">
  	var websocket = null;
  	if('WebSocket' in window){
  		websocket = new WebSocket("ws://localhost:8080/MyWebSocket/websocket");
  	}
  	else if('MozWebSocket' in window){
  		websocket = new MozWebSocket('ws://localhost:8080/WebSocketTest/websocket');
  	}
  	else{
  		alert('Not support websocket')
  	}
  	
  	websocket.onerror = function(){
  		setMessageInnerHTML("error");
  	};
  	
  	websocket.onopen = function(event){
  		setMessageInnerHTML("open");
  	}
  	
  	websocket.onmessage = function(){
  		setMessageInnerHTML(event.data);
  	}
  	
  	websocket.onclose = function(){
  		setMessageInnerHTML("close");
  	}
  	
  	//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
  	window.onbeforeunload = function(){
  		websocket.close();
  	}
  	
  	function setMessageInnerHTML(innerHTML){
  		document.getElementById('message').innerHTML += innerHTML + '<br/>';
  	}
  	
  	function closeWebSocket(){
  		websocket.close();
  	}
  	
  	function send(){
  		var message = document.getElementById('text').value;
  		websocket.send(message);
  	}
  	
  	
  </script>
</html>
