append __string "<!DOCTYPE HTML>
<html>
<head>
<meta charset=\"utf-8\">
<title>Ideal Media Logo</title>
<style type=\"text/css\">
p, #target \{
	background-color: black;
    color: white;
    border-color: red;
    border-width: 1px;
    border-style: solid;
    font-family: \"Courier New\", Courier, monospace;
}
</style>
<script type=\"text/javascript\" src=\"../html5/logger.js\"></script>

<script type=\"text/javascript\" >
	//setup logging element id
	Logger = \"logger2\";
</script>

<script type=\"text/javascript\">
	var X = new Array(5);
	var Y = new Array(5);
	var Matrix = new Array(5);
	var OriginalMatrix = new Array(5);
	var Count = 0;
	
	// original data
	//OriginalMatrix"
append __string "\[1] = \"matrix(1.18 0 -0.2 1 0 170.6)\"; // M
	//OriginalMatrix"
append __string "\[2] = \"matrix(2.19 0 -0.61 0.81 5 171)\"; //I
	//OriginalMatrix"
append __string "\[3] = \"matrix(1 0 0 1 112 49)\"; // Ideal
	//OriginalMatrix"
append __string "\[4] = \"matrix(1 0 0 1 19.5 77)\"; // Media
	OriginalMatrix"
append __string "\[1] = "
append __string "\[1.18, 0, -0.2, 1, 0, 170.6]; // M
	OriginalMatrix"
append __string "\[2] = "
append __string "\[2.19, 0, -0.61, 0.81, 5, 171]; //I
	OriginalMatrix"
append __string "\[3] = "
append __string "\[1, 0, 0, 1, 112, 49]; // Ideal
	OriginalMatrix"
append __string "\[4] = "
append __string "\[1, 0, 0, 1, 19.5, 77]; // Media
	
	// Starting coordinates
	X"
append __string "\[1] =    0;   Y"
append __string "\[1] = 170.6;
	X"
append __string "\[2] =    5;   Y"
append __string "\[2] = 171;
	X"
append __string "\[3] =  112;   Y"
append __string "\[3] =  49;
	X"
append __string "\[4] =   19.5; Y"
append __string "\[4] = 77;
	
	// width  = matrix width multiplier relative to 1 (0 to inf)
	// riseY  = matrix rise from posX/posY along Y axis (positive or negative)
	// runX   = distance matrix \"top\" leans (runs) along X axis  relative to 0 (pos to neg)
	// height = height of matrix relative to 1, negative height flips matrix
	// posX   = X position of lower left corner of matrix
	// posY   = Y position of lower left corner of matrix
	function createMatrix0 (width,rise,tiltX,height,posX,posY) \{
		return \"martix(\"+ width + \" \" + rise + \" \" + tiltX + \" \" + height + \" \" + posX + \" \" + posY + \")\";
	}
	function createMatrix2(array) \{
		return \"matrix(\" + array"
append __string "\[0] + \" \" + array"
append __string "\[1] + \" \" + array"
append __string "\[2] + \" \" + array"
append __string "\[3] + \" \" + array"
append __string "\[4] + \" \" + array"
append __string "\[5] + \")\";
	}
	function createMatrix() \{
		array = this.matrix;
		return \"matrix(\" + array"
append __string "\[0] + \" \" + array"
append __string "\[1] + \" \" + array"
append __string "\[2] + \" \" + array"
append __string "\[3] + \" \" + array"
append __string "\[4] + \" \" + array"
append __string "\[5] + \")\";
	}
	
	function changeIt() \{
		X"
append __string "\[1] += 20; Y"
append __string "\[1] += -5;
		X"
append __string "\[2] += 10; Y"
append __string "\[2] +=  5;
		X"
append __string "\[3] +=  5; Y"
append __string "\[3] += -2;
		X"
append __string "\[4] +=  5; Y"
append __string "\[4] +=  5;
		Matrix"
append __string "\[1] = \"matrix(1.18 0 -0.2 1 \" + X"
append __string "\[1] + \" \" + Y"
append __string "\[1] + \")\";
		Matrix"
append __string "\[2] = \"matrix(2.19 0 -0.61 0.81 \" + X"
append __string "\[2] + \" \" + Y"
append __string "\[2] + \")\";
		Matrix"
append __string "\[3] = \"matrix(1 0 0 1 \" + X"
append __string "\[3] + \" \" + Y"
append __string "\[3] + \")\";
		Matrix"
append __string "\[4] = \"matrix(1 0 0 1 \" + X"
append __string "\[4] + \" \" + Y"
append __string "\[4] + \")\";
		document.getElementById(\"M\").setAttribute(\"transform\",Matrix"
append __string "\[1]);
		document.getElementById(\"I\").setAttribute(\"transform\",Matrix"
append __string "\[2]);
		document.getElementById(\"Ideal\").setAttribute(\"transform\",Matrix"
append __string "\[3]);
		document.getElementById(\"Media\").setAttribute(\"transform\",Matrix"
append __string "\[4]);
		Count++;
	}
	// switches up numbers 1-4
	function loopIt(num) \{
		return ((num-1+Count)%4 + 1);
	}
	
	function changeItBack() \{
		document.getElementById(\"M\").setAttribute(\"transform\",createMatrix2(OriginalMatrix"
append __string "\[loopIt(1)]));
		document.getElementById(\"I\").setAttribute(\"transform\",createMatrix2(OriginalMatrix"
append __string "\[loopIt(2)]));
		document.getElementById(\"Ideal\").setAttribute(\"transform\",createMatrix2(OriginalMatrix"
append __string "\[loopIt(3)]));
		document.getElementById(\"Media\").setAttribute(\"transform\",createMatrix2(OriginalMatrix"
append __string "\[loopIt(4)]));
	}
	
	var myArr = new Array(6);
	myArr = "
append __string "\[1.18, 0, -0.2, 1, 0, 170.6];
	
	function setWidth(newWidth) \{
		this.width = newWidth;
		array = this.matrix;
		array"
append __string "\[0] = newWidth;
		this.matrix = array;
		Log(\"Notice\", \"New width = \" + this.width);
	}
	
	function Mat (width,rise,tiltX,height,posX,posY) \{
		this.width = width;
		this.rise = rise;
		this.tiltX = tiltX;
		this.height = height;
		this.posX = posX;
		this.posY = posY;
		this.matrix = "
append __string "\[width, rise, tiltX, height, posX, posY];
		this.getMatrix = createMatrix;
		this.setWidth = setWidth;
	}
	
	var myMat = new Mat(1.18, 0, -.2, 1, 0, 1);

</script>

</head>

<body onload=\"myMat.setWidth(1.5);\">


<svg version=\"1.1\"
     id=\"Layer1\"
     xmlns=\"http://www.w3.org/2000/svg\"
     xmlns:xlink=\"http://www.w3.org/1999/xlink\"
     xml:space=\"preserve\">

<text id=\"I\" transform=\"matrix(2.19 0 -0.61 0.81 5 171)\"
 fill=\"#FBB040\"
 font-family=\"'PalatinoLinotype-Bold'\"
 font-size=\"215.3546\">I</text>
<text id=\"M\" transform=\"matrix(1.18 0 -0.2 1 0 170.6)\"
 fill=\"#ED1C24\"
 font-family=\"'PalatinoLinotype-Bold'\"
 font-size=\"131.876\">M</text>
<text id=\"Ideal\" transform=\"matrix(1 0 0 1 112 49)\"
 fill=\"#FBB040\"
 font-family=\"'PalatinoLinotype-Roman'\"
 font-size=\"63.859\">Ideal</text>
<text id=\"Media\" transform=\"matrix(1 0 0 1 19.5 77)\"
 fill=\"#ED1C24\"
 font-family=\"'PalatinoLinotype-Roman'\"
 font-size=\"52.0535\">Media</text>

</svg>
<p id=\"test\"></p>
<p onMouseOver=\"changeIt()\" onMouseOut=\"changeItBack()\">Hit Me.</p>

<p onMouseOver=\"this.innerHTML = eval ('createMatrix0(' + myArr.toString() + ')');\">Some Stuff</p>
<p onMouseOver=\"Log('Notice', 'myMat.matrix = ' + myMat.matrix);\">Some Other Stuff</p>

<p id=\"logger2\">Logging info</p>
</body>
</html>
"
