<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:presets="http://josm.openstreetmap.de/tagging-preset-1.0">
<xsl:output method = "xml" version="1.0"
    cdata-section-elements=""
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

<xsl:variable name="v1">default language ISO</xsl:variable>



<xsl:param name="build" select="0013"/>
<xsl:param name="col_width" select="400"/>

<xsl:template match="/">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	  <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
	<title>OSM Tagging schema</title>       
	<style type="text/css">
	 body { font-family: verdana,tahoma ; font-size: 10px ; }
	 h2 { font-size: 12px; }
	 table  { border-collapse:collapse; }
	 #list * { font-family: verdana,tahoma ; font-size: 10px ; }
	 #list table, td, th 
	  { border-top: 1px solid black; text-align: left ;
		vertical-align: top; } 
	 .group0 { padding-left: 10px; font-weight: bold; background-color: #F8A8A8 ;} 	
         .group1 { padding-left: 20px; font-weight: bold; background-color: #F8F8A8 ;}  	
	 .item  { padding-left: 30px; font-weight: normal; background-color: #A8F8A8 ;}  
	 .item a {text-decoration:none;}
	 td.icon    { padding-left: 10px; padding-right: 10px; background-color: #F8F8F8 ; }
	 td.fdate   { padding-right: 5px; font-weight: bold; background-color: #F8F8F8 ;}
	 td.text    { border: 0px; }
	</style>
	</head>
	<body>
	<h2>OSM tagging schema (build 0013)</h2><br/><br/>
	<div id="list">
	   <xsl:attribute name="style">width:<xsl:value-of select="$col_width"/>px;height:100%;</xsl:attribute>
	   <xsl:for-each select="presets:presets/presets:group">
	    <p>
	      <xsl:attribute name="class">group0</xsl:attribute>
              <xsl:value-of select="@name"/>
            </p>
              <xsl:apply-templates/>  
           </xsl:for-each>
	</div>
	<div id="message"></div>
	</body>
	</html>
</xsl:template>


<xsl:template match="presets:group">
     <p>
       <xsl:attribute name="class">group1</xsl:attribute>
       <xsl:value-of select="@name"/>
     </p>
     <xsl:for-each select="presets:item">
       <p>
       	 <xsl:attribute name="class">item</xsl:attribute>
       	  <a >
       	   
       	   <xsl:attribute name="href"><xsl:value-of select="presets:link/@href"/></xsl:attribute>
       	  
           <xsl:value-of select="@name"/>
         </a>
       </p>
     </xsl:for-each>
</xsl:template>



</xsl:stylesheet>
