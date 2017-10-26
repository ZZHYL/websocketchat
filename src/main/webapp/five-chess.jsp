<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="utf-8">
<meta name="Keywords" content="关键词">
<meta name="Description" content="描述信息">
<title>人工智能五子棋</title>
  <link href="${pageContext.request.contextPath }/static/source/css/chess.css" rel='stylesheet' type='text/css' />
 <jsp:include page="view/include/commonfile.jsp"/>
   <script src="${ctx}/plugins/sockjs/sockjs.js"></script>
</head>
<body >
<jsp:include page="view/include/header.jsp"/>
<div class="am-cf admin-main">
<jsp:include page="view/include/sidebar.jsp"/>
<div class="admin-content" >
<h1 class="biaoti">人人对战五子棋</h1>
<input type="button" class="button2" onclick="newgame()" value="restart"></input>
<div class="am-panel am-pa el-default" style="float:right;width: 20%;">
            <div class="am-panel-hd">
                <h3 class="am-panel-title">在线列表 [<span id="onlinenum"></span>]</h3>
            </div>
            <ul class="am-list am-list-static am-list-striped" id="list">
            </ul>       
        </div>
<canvas  class="canvasplace" id="canvas" width="450" height="450"></canvas>
</div>
	<a href="#" class="am-show-sm-only admin-me
	
	nu" data-am-offcanvas="{target: '#admin-offcanvas'}">
    <span class="am-icon-btn am-icon-th-list"></span></a>
    <jsp:include page="view/include/footer.jsp"/>
</div>
<script>
	//创建websocket
	var wsServer=null;
	var ws=null;
	wsServer = "ws://" + location.host+"${pageContext.request.contextPath}" + "/chessServer";
	ws=new WebSocket(wsServer);
	ws.onopen=function(evt){
		ws.send(JSON.stringify({
			type:"tishi"
		}))
	};
	ws.onmessage=function(evt){
		console.log(evt.data);
		getpanduan(evt.data);

	};
	 ws.onerror = function (evt) {  //错误提示
     };
     ws.onclose = function (evt) {//关闭提示
     };
     //画棋谱
	var chess=document.getElementById("canvas");
	var context=chess.getContext("2d");
	context.strokeStyle="#d3d3d3"	
	//开始画线
	context.beginPath();
	for(var i=0;i<15;i++)
	{
	context.moveTo(15+i*30,15);
	context.lineTo(15+i*30,435);
	context.stroke();
	context.moveTo(15,15+i*30);
	context.lineTo(435,15+i*30);
	context.stroke();
	context.closePath();
	}
	var iswhite=false;
	var temp;
	var chessboard=Array(14);
	for(var i=0;i<15;i++)
	{
		chessboard[i]=Array(14);
		for(var j=0;j<15;j++)
		{
		chessboard[i][j]=0;
		}
	}
	var onStep=function(color,i,j)
	{
	console.log("实下的位置:"+i+j);
	context.beginPath();
	context.arc(15+i*30,15+j*30,13,0,Math.PI*2);
	context.stroke();
	context.closePath();
	//设置渐变色 径向渐变
	var gradient=context.createRadialGradient(15+i*30,15+j*30,13,15+i*30,15+j*30,0);
	if(color=="black")
	{
		gradient.addColorStop(0,"#0a0a0a");
		gradient.addColorStop(1,"#636767");
		chessboard[i][j]=1;
	}
	else
	{
		gradient.addColorStop(0,"#d1d1d1");
		gradient.addColorStop(1,"#f9f9f9");
		chessboard[i][j]=2;
	}
	context.fillStyle=gradient;
	context.fill();
	
	
	}
	function newgame()
	{
		if(confirm("开始新的游戏？"))
		{
			location.reload();
			}
	}
// 	进行对后台发来的信息进行判断
	function getpanduan(message)
	{
		message=JSON.parse(message);
		if(message.type=="zuobiaoxy")          //是坐标则画棋子                                                     
			{
	 		var x1=parseInt(message.zuobiao.x);
	 		var y1=parseInt(message.zuobiao.y);
	 		docheck(x1,y1);
			}
		
		if(message.type=="tishi")//类型为提示
			{

			  layer.msg(message.message, { offset: 0});//展示信息
			  showonline(message.list);//显示在线人数名单
			  $("#onlinenum").text(message.list.length);  //显示在线人
				
			}
	
	}
	function showonline(list)
	{
		$("#list").html("");//清空在线名单
		$.each(list,function(index,item)//对名单进行便利，index为当前位置，item为内容
				{
				var li;
				if(index==0)
					{
				   li = "<li>"+item+" <img src=\"${ctx}/static/source/img/baizi.jpg\"  weight=\"30px\" height=\"30px\"></li>";
					}
				else if(index==1)
					{
				   li = "<li>"+item+" <img src=\"${ctx}/static/source/img/heizi.jpg\"  weight=\"30px\" height=\"30px\">(先手)</li>";
					}
				else
					{
					 li = "<li>"+item+" <button type=\"button\" class=\"am-btn am-btn-xs am-btn-primary am-round\">  观战</button></li>";
					}
				$("#list").append(li);
				})
	}
	//定义一个落子的方法
	chess.onclick=function(e)
	{
		var color;
		var x=e.offsetX;
		var y=e.offsetY;
		console.log(x,y);                            
		var i=parseInt(x/30);
		var j=parseInt(y/30);
		if(i<0||j<0||i>14||i>14||chessboard[i][j]!=0)
	    {
	     return;
	    }
		//有点击的棋子，像后台发送
// 		{
// 			zuobiao:{
// 				x:"xx",
// 				y:"yy"
// 			}
// 		type:"xxx"
// 		}
		ws.send(JSON.stringify({
		zuobiao:{x:i,y:j},
		type:"zuobiaoxy"	
		}
		))
		}
// 	对棋子进行判断
	function docheck(x,y)
	{
		if(iswhite)
		{
			color="white";
		}
		else
		{
			color="black";
		}
		//画棋
		drawchess(color,x,y);
	}
	//画棋
	function drawchess(color,x,y)
	{
	
		if(x>=0&&x<15&&y>=0&&y<15)
		{
			if(color=="white")
			{
				iswhite=false;
				onStep("white",x,y);
				iswin("white",x,y);
			}
			else
			{
				iswhite=true;
				onStep("black",x,y);
				iswin("black",x,y);
// 				AIplay();
				
			}
	    }
	}
	//判断是否赢了
	iswin=function(color,x,y)
	{
		if(color=="black")
		{
			temp=1;
		}
		else if(color=="white")
		{
			temp=2; 
		}
	lrcount(temp,x,y);
	tbcount(temp,x,y);
	rtcount(temp,x,y);
	rbcount(temp,x,y);
	}
	function lrcount(temp,x,y)//横向判断五子棋的个数
{
console.log(x,y,temp);
	var line=new Array(4);
	var count=0;
	for(var i=x;i>=0;i--)
	{
		line[0]=i;
		line[1]=y;
		if(chessboard[i][y]==temp)
		{
			count++;
			}
			else
		{
	i=-1;
		}
	}
	for(var i=x;i<=14;i++)
	{
		line[2]=i;
		line[3]=y;
		if(chessboard[i][y]==temp)
		{
			count++;
			}
		else
		{
	i=100;
		}
	}
	console.log("横向的个数:"+count);
	success(line[0],line[1],line[2],line[3],temp,--count);
}
	function tbcount(temp,x,y)//竖向判断五子棋的个数
	{
		var line=new Array(4);
	var count=0;
	for(var i=y;i>=0;i--)
	{
		line[0]=x;
		line[1]=i;
		if(chessboard[x][i]==temp)
		{
			count++;
			}
			else
		{
	i=-1;
		}
	}
	for(var i=y;i<=14;i++)
	{
		line[2]=x;
		line[3]=i;
		if(chessboard[x][i]==temp)
		{
			count++;
			}
		else
		{
	i=100;
		}
	}
	console.log("横向的个数:"+count);
	success(line[0],line[1],line[2],line[3],temp,--count);
}
	function  rtcount(temp,x,y)//右斜判断五子棋个数
	{
		var line=Array(4);
		var count=0;
		for(var i=x,j=y;i>=0&&j>=0;)
		{
			line[0]=i;
			line[1]=j;
			if(chessboard[i][j]==temp)
			{
				count++;
			}
			else
			{
				i=-1;
				j=-1;
			}
			i--;
			j--;
		}
		for(var i=x,j=y;i<=14&&j<=14;)
		{
			line[2]=i;
			line[3]=j;
			if(chessboard[i][j]==temp)
			{
				count++;
			}
			else
			{
				i=100;
				j=100;
			}
			i++;
			j++;
		}
		success(line[0],line[1],line[2],line[3],temp,--count)
	}
	function rbcount(temp,x,y)//左斜判断五子棋的个数
	{
		var line=Array(4);
		var count=0;
		for(var i=x,j=y;i>=0&&j<=14;)
		{
			line[0]=i;
			line[1]=j;
			if(chessboard[i][j]==temp)
			{
				count++;
			}
			else
			{
				i=-1;
				j=100;
			}
			i--;
			j++;
		}
		for(var i=x,j=y;i<=14&&j>=0;)
		{
			line[2]=i;
			line[3]=j;
			if(chessboard[i][j]==temp)
			{
				count++;
			}
			else
			{
				i=100;;
				j=-1;
			}
			i++;
			j--;
		}
		success(line[0],line[1],line[2],line[3],temp,--count)
	}
				
					
			
			
	function success(a,b,c,d,temp,count)//判断是否为5颗
{
	if(count==5)
	{
	context.beginPath();
	context.lineWidth=5;
	context.strokeStyle='black';
	context.moveTo(15+30*a,15+30*b);
	context.lineTo(15+30*c,15+30*d);
	context.closePath();
	context.stroke();
	winner="白棋胜利";
	if(temp==1)
	{
	winner="黑棋胜利";
	}
	alert(winner);
	}
	
}	
</script>
</body>
</html>