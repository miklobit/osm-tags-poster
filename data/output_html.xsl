<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:presets="http://josm.openstreetmap.de/tagging-preset-1.0">
<xsl:output method = "xml" version="1.0"
    cdata-section-elements=""
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

<!-- this file is part of osm-tag-poster project: github.com/miklobit/osm-tags-poster  -->
<!-- created by miklobit 2013.10.01 -->

<xsl:variable name="lang_href" select="concat($lang,'.href')" />	
<xsl:variable name="lang_name" select="concat($lang,'.name')" /> 

<xsl:param name="build" select="0019"/>
<xsl:param name="col_width" select="400"/>
<xsl:param name="lang" select="pl"/>

<xsl:template match="/">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	  <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
	<title>OSM Tagging schema <xsl:value-of select="$lang"/> (build <xsl:value-of select="$build"/>)</title>       
	<style type="text/css">
	 body { font-family: verdana,tahoma ; font-size: 12px ; }
	 h2 { font-size: 14px; }
	 #list {
		position: relative;
		float: left ;
		width: <xsl:value-of select="$col_width"/>px;
		border: 1px solid #405F72;
		padding: 5px 5px 5px 5px ;	
		display: table; 
	 }
 
	 .line {
		position: relative;
		float: left ;
		width: 100%;	
		display: table-cell; 
		vertical-align: middle;		 
	  }			
	 .icon { 
	    padding-left: 10px;
		float: left ;
		clear: both ;
		width: 10%;
		display: table-cell; 
		vertical-align: middle;				 
	  }	
	 .content {
	    padding-left: 10px;
	    padding-top: 7px;
	    padding-bottom: 7px;
		float: left ;
		width: 85%;
		display: table-cell; 
		vertical-align: middle;			
	  }
	 .group0 { font-weight: bold; background-color: #FFE0E0 ;} 	
     .group1 { font-weight: bold; background-color: #FFFFE0 ;}  	
	 .item  {  font-weight: normal; background-color: #E0FFE0 ;}  
	 .item a {text-decoration:none;}

	</style>
	</head>
	<body>
       <xsl:apply-templates/> 
	</body>
	</html>
</xsl:template>

<xsl:template match="presets:presets">
	<h2>
	  <xsl:call-template name="name"/><!-- (test build <xsl:value-of select="$build"/>) -->
	</h2>
	<br/><br/>
	<div id="list">
	   <xsl:for-each select="presets:group">
	      <div class="line group0">
		     <div class="icon">
		        <xsl:call-template name="icon"/>
		     </div>   
		     <div class="content">
		        <xsl:call-template name="name"/> 
		     </div>
		  </div>  
          <xsl:apply-templates/>  
       </xsl:for-each>
	</div>
</xsl:template>


<xsl:template match="presets:group">
     <div class="line group1">
	     <div class="icon">
	        <xsl:call-template name="icon"/>
	     </div>    
	     <div class="content">
	        <xsl:call-template name="name"/> 
	     </div>
     </div>
     <xsl:for-each select="presets:item">
       <xsl:sort select="@name"/>
       <xsl:call-template name="item"/>
     </xsl:for-each>
</xsl:template>

<xsl:template name="item">
       <div class="line item">
	       <div class="icon">
	          <xsl:call-template name="icon"/>
	       </div>    
	       <div class="content" >
	       	  <a>  <!--  wikipedia link -->     	   
	       	   <!--  first try language translation, then default  -->       	   
	       	   <xsl:attribute name="href">
			        <xsl:choose>
			          <xsl:when test="presets:link/@*[local-name()=$lang_href]">
						<xsl:value-of select="presets:link/@*[local-name()=$lang_href]"/>
			          </xsl:when>
			          <xsl:otherwise>
			          	<xsl:value-of select="presets:link/@href"/>  <!-- default link -->
			          </xsl:otherwise>
			        </xsl:choose>       	      
	       	   </xsl:attribute>       	  
	           <xsl:call-template name="name"/>
	         </a>
	       </div>
       </div>
</xsl:template>

<xsl:template name="icon">
	 <img>
	   <xsl:attribute name="src">images/<xsl:value-of select="@icon"/></xsl:attribute>
	 </img>
</xsl:template>

<xsl:template name="name">
	<xsl:choose>
		<xsl:when test="@*[local-name()=$lang_name]">
			<xsl:value-of select="@*[local-name()=$lang_name]"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="@name"/>  <!-- default name -->
		</xsl:otherwise>
	</xsl:choose>        
</xsl:template>

</xsl:stylesheet>
