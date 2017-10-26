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
<h1 class="biaoti">人机对战五子棋</h1>
<input type="button" class="button2" onclick="newgame()" value="restart"></input>
<canvas  class="canvasplace" id="canvas" width="450" height="450"></canvas>
</div>
	<a href="#" class="am-show-sm-only admin-me
	
	nu" data-am-offcanvas="{target: '#admin-offcanvas'}">
    <span class="am-icon-btn am-icon-th-list"></span></a>
    <jsp:include page="view/include/footer.jsp"/>
</div>
<script>

	var chess=document.getElementById("canvas");
	var context=chess.getContext("2d");
	context.strokeStyle="#d3d3d3"
	/*var logo=new Image();
	logo.src="e://s1.jpg";
	logo.onload=function()
	{
		context.drawImage(logo,80,80,256,256);
	}*/
		
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

		console.log("应下的地方:"+i+j);
		docheck(i,j);
		/*if(chessboard[i][j]==0)
		{
		console.log(i,j);
		if(me==true)
		{
		chessboard[i][j]=1;
		onStep(i,j,me);
		iswin(i,j,me);
		}
		else if(me==false)
		{
		chessboard[i][j]=2;
		onStep(i,j,me);
		iswin(i,j,me);
		AIplay();

		}

		me=!me;
		}*/
	
		}
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
		drawchess(color,x,y);
	}
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
				AIplay();
				
			}
	    }
	}
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
	newgame=function()
	{
		if(confirm("开始新的游戏？"))
		{
			location.reload();
			}
	}
	
}	
//AI

function getposition()
{
	var a=new Array(2);
	var score=0;
	for(var x=0;x<15;x++)
		for(var y=0;y<15;y++)
		{
			if(chessboard[x][y]==0)
			{
				if(judge(x,y)>score)
				{
					score=judge(x,y);
					a[0]=x;
					a[1]=y;
				}
			}
		}
	return a;
}
function AIplay()
{
	var str=getposition();
	docheck(str[0],str[1]);
}
function judge(x,y)
{
	var a=parseInt(leftRight(x,y,1))+parseInt(topBottom(x,y,1))+parseInt(rightBottom(x,y,1))+parseInt(rightTop(x,y,1));
	var b=parseInt(leftRight(x,y,2))+parseInt(topBottom(x,y,2))+parseInt(rightBottom(x,y,2))+parseInt(rightTop(x,y,2));
	var result=a+b;
	return result;
}
function leftRight(x,y,num)
{
	var death=0;
	var live=0;
	var count=0;
	var arr=new Array(15);
	for(var i=0;i<15;i++)
	{
		arr[i]=new Array(15);
		for(var j=0;j<15;j++)
		{
			arr[i][j]=chessboard[i][j];
		}
	}
	arr[x][y]=num;
	for(var i=x;i>=0;i--)
	{
		if(arr[i][y]==num)
		{
			count++;
		}
			else if(arr[i][y]==0)
		{
				live+=1;
				i=-1;
		}
			else
		{
			death+=1;
			i=-1;
		}
	}
	for(var i=x;i<=14;i++)
	{
		if(arr[i][y]==num)
		{
			count++;
		}
		else if(arr[i][y]==0)
		{
			live+=1;
			i=100;
		}
		else
		{
		death+=1;
		i=100;
		}
	}
	count-=1;
	return model(count,death);
}
function topBottom(x,y,num)
{
	var death=0;
	var live=0;
	var count=0;
	var arr=new Array(15);
	for(var i=0;i<15;i++)
	{
		arr[i]=new Array(15);
		for(var j=0;j<15;j++)
		{
			arr[i][j]=chessboard[i][j];
		}
	}
	arr[x][y]=num;
	for(var i=y;i>=0;i--)
	{
		if(arr[x][i]==num)
		{
			count++;
		}
			else if(arr[x][i]==0)
		{
				live+=1;
				i=-1;
		}
			else
		{
			death+=1;
			i=-1;
		}
	}
	for(var i=y;i<=14;i++)
	{
		if(arr[x][i]==num)
		{
			count++;
		}
		else if(arr[x][i]==0)
		{
			live+=1;
			i=100;
		}
		else
		{
		death+=1;
		i=100;
		}
	}
	count-=1;
	return model(count,death);
}
function rightBottom(x,y,num)
{
	var death=0;
	var live=0;
	var count=0;
	var arr=new Array(15);
	for(var i=0;i<15;i++)
	{
		arr[i]=new Array(15);
		for(var j=0;j<15;j++)
		{
			arr[i][j]=chessboard[i][j];
		}
	}
	arr[x][y]=num;
	for(var i=x,j=y;i>=0&&j>=0;)
	{
		if(arr[i][j]==num)
		{
			count++;
		}
			else if(arr[i][j]==0)
		{
				live+=1;
				i=-1;
		}
			else
		{
			death+=1;
			i=-1;
		}
		i--;
		j--;
	}
	for(var i=x,j=y;i<=14&&j<=14;)
	{
		if(arr[i][j]==num)
		{
			count++;
		}
		else if(arr[i][j]==0)
		{
			live+=1;
			i=100;
		}
		else
		{
		death+=1;
		i=100;
		}
	i++;
	j++;
	}
	count-=1;
	return model(count,death);
}
function rightTop(x,y,num)
{
	var death=0;
	var live=0;
	var count=0;
	var arr=new Array(15);
	for(var i=0;i<15;i++)
	{
		arr[i]=new Array(15);
		for(var j=0;j<15;j++)
		{
			arr[i][j]=chessboard[i][j];
		}
	}
	arr[x][y]=num;
	for(var i=x,j=y;i>=0&&j<=14;)
	{
		if(arr[i][j]==num)
		{
			count++;
		}
			else if(arr[i][j]==0)
		{
				live+=1;
				i=-1;
		}
			else
		{
			death+=1;
			i=-1;
		}
		i--;
		j++;
	}
	for(var i=x,j=y;i<=14&&j>=0;)
	{
		if(arr[i][j]==num)
		{
			count++;
		}
		else if(arr[i][j]==0)
		{
			live+=1;
			i=100;
		}
		else
		{
		death+=1;
		i=100;
		}
		i++;
		j--;
	}
	count-=1;
	return model(count,death);
}
function model(count,death)
{
	var level_one=0;
	var level_two=1;
	var level_three=1500;
	var level_four=4000;
	var level_five=10000;
	var level_six=100000;
	if(count==1&&death==1)
	{
		return level_one;
	}
	else if(count==2)
	{
		if(death==0)
		{
			return level_three;
		}
		if(death==1)
		{
			return level_two;
		}
		if(death==0)
		{
			return level_one;
		}
	}
	else if(count==3)
	{
		if(death==0)
		{
			return level_four;
		}
		else if(death==1)
		{
			return level_three;
		}
		else
		{
			return level_one;
		}
	}
	else if(count==4)
	{
		if(death==0)
		{
			return level_five;
		}
		else if(death==1)
		{
			return level_four;
		}
		else 
		{
			return level_one;
		}
	}
	else if(count==5)
	{
		return level_six;
	}
	return level_one;
}	
</script>
</body>
</html>