<?php

$build = '00014';

$display_form = 0;
if( isset($_POST['output'] ) )
{
 if( $_POST['output'] == "html" ) {	

	$xsl_path = './data/output_html.xsl';
	
	// generate xsl transformation	
	genOutput($xsl_path);
	
 } 
   else {  $display_form = 1; }
} else { $display_form = 1; }


if( $display_form  != 0 ) {
// display form
echo '<html>
	<head>
	<title>OSM tagging schema (build '.$build.')</title> 
	<style type="text/css">
	 body { font-family: verdana,tahoma ; font-size: 10px ; }
	 form { font-size: 12px; }
	</style>
	<body id="top">
	<h2>OSM tagging schema (build '.$build.')</h2><br/>
	<form name="input" action="" method="post" enctype="multipart/form-data">
	
	  <input type="radio" name="output" value="html" checked="checked" /> 
	   HTML output  <br />	   
	  <input type="radio" name="output" value="svg" />  
	   SVG poster <br />

	  <hr width="30%" align="left" /> <br />   
      
	  <!-- <input type="checkbox" name="include_txt" value="1" checked="checked" />Pokaż tekst wpisu<br /> -->
	  Column width<input type="text" name="col_width" value="600" />px<br />
	  
	  <hr width="30%" align="left" />  	  
	   <input type="submit" name="submit" value="Generate " />
	</form> 

	</body>
	</html>';
    
}

function genOutput($xsl_path)
{

//	$include_txt = isset($_POST['include_txt']) ? "1" : "0" ;
	
	
	
	
	// Load the XML source
	$xml = new DOMDocument;
	$xml->load('./data/defaultpresets.xml');

	$xsl = new DOMDocument;
	$xsl->load($xsl_path);
		
	// Configure the transformer
	$proc = new XSLTProcessor;
	
	// set parameters

//	$proc->setParameter( '', 'include_txt',  $include_txt);	
	if( isset($_POST['log_width']) ) {
		$proc->setParameter( '', 'log_width',  $_POST['log_width'] );
	}		
		
	$proc->importStyleSheet($xsl); // attach the xsl rules
	echo $proc->transformToXML($xml);
}


?>
