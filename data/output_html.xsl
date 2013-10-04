<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:presets="http://josm.openstreetmap.de/tagging-preset-1.0">
<xsl:output method = "xml" version="1.0"
    cdata-section-elements=""
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

<xsl:variable name="dnf">Didn't find it</xsl:variable>
<xsl:variable name="found">Found it</xsl:variable>
<xsl:variable name="system">SYSTEM</xsl:variable>

<xsl:param name="show_dat" select="1"/>
<xsl:param name="include_nam" select="1"/>
<xsl:param name="include_dnf" select="1"/>
<xsl:param name="show_icon" select="1"/>
<xsl:param name="include_txt" select="1"/>
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
         .group { padding-left: 10px; font-weight: bold; background-color: #F8F8F8 ;}  	
	 .item  { padding-left: 20px; font-weight: normal; background-color: #F8F8F8 ;}  
	 td.icon    { padding-left: 10px; padding-right: 10px; background-color: #F8F8F8 ; }
	 td.fdate   { padding-right: 5px; font-weight: bold; background-color: #F8F8F8 ;}
	 td.text    { border: 0px; }
	</style>
	</head>
	<body>
	<h>OSM tagging schema (build 0006)</h>
	<div id="list">
	   <xsl:attribute name="style">
               width: <xsl:value-of select="$col_width"/>px; height: 100%;
	   </xsl:attribute>
	   <xsl:for-each select="presets:presets/presets:group">
              <xsl:value-of select="@name"/>
              <br/>
              <xsl:apply-templates/>  
           </xsl:for-each>
	</div>
	<div id="message"></div>
	</body>
	</html>
</xsl:template>


<xsl:template match="presets:group">
     <xsl:value-of select="@name"/>
     <br/>
     <xsl:for-each select="presets:item">
       <p>
       	 <xsl:attribute name="class">
            item
	 </xsl:attribute>
         <xsl:value-of select="@name"/>
       </p>
     </xsl:for-each>
</xsl:template>



</xsl:stylesheet>
