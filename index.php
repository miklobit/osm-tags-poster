﻿<?php

$build = '00015';

$output = "";
if( isset($_GET['output'] ) )
{
 $output =	$_GET['output'];
 if( $output == "html" ) {	

	$xsl_path = './data/output_html.xsl';	
	// generate xsl transformation	
	genOutput($xsl_path);	
 } 
 else if ( $output == "svg" ) {
	echo '<html>
	       <body>Under contruction...</body>
	      </html>' ;   	
 }

} 


if( $output  == "" ) {
// display form
echo '<html>
	<head>
	<title>OSM tagging schema (build '.$build.')</title> 
	<style type="text/css">
	 body { font-family: verdana,tahoma ; font-size: 10px ; }
	 form { font-size: 12px; }
	</style>
	<body id="top">
	<h2>OSM tagging schema</h2><br/>
	<form name="input" action="" method="get" enctype="multipart/form-data">
	
	  <input type="radio" name="output" value="html" checked="checked" /> 
	   HTML output  <br />	   
	  <input type="radio" name="output" value="svg" />  
	   SVG output (poster) <br />

	  <hr width="30%" align="left" /> <br />   
      
	  <input type="checkbox" name="group" value="1" checked="checked" />Group tags<br />
	  Column width&nbsp;<input type="text" name="col_width" value="600" />px<br />
	  <!-- language translation -->
	  Language&nbsp;<select name="lang">
                <option value="pl">PL</option>
                <option value="en">EN</option>
             </select>
	  
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
	if( isset($_GET['col_width']) ) {
		$proc->setParameter( '', 'col_width',  $_GET['col_width'] );
	}
	if( isset($_GET['lang']) ) {
		$proc->setParameter( '', 'lang',  $_GET['lang'] );
	}				
	if( isset($_GET['group']) ) {
		$proc->setParameter( '', 'group',  $_GET['group'] );
	}			
	$proc->importStyleSheet($xsl); // attach the xsl rules
	echo $proc->transformToXML($xml);
}


?>
