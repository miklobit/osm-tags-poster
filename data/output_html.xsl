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
<xsl:variable name="sort_name"  > 
	<xsl:choose>
		<xsl:when test="$lang = 'en'" >name</xsl:when> 
		<xsl:otherwise>
	       <xsl:value-of select="concat($lang,'.name')"/>		   
		</xsl:otherwise>
	</xsl:choose>   
</xsl:variable> 


<xsl:param name="build" select="0019"/>
<xsl:param name="col_width" select="400"/>
<xsl:param name="lang" select="pl"/>
<xsl:param name="group" select="0"/>

<xsl:template match="/">
	<html xmlns="http://www.w3.org/1999/xhtml">
	   <xsl:call-template name="doc_header"/>
	<body>
        <xsl:choose>
          <xsl:when test="$group = '1'">
               <!-- tag groups with group headers -->
			   <xsl:apply-templates/> 
          </xsl:when>
          <xsl:otherwise>
             <!-- tags alone with sorting -->
	   		<xsl:call-template name="items_alone"/>
          </xsl:otherwise>
        </xsl:choose>  	
	</body>
	</html>
</xsl:template>

<xsl:template match="presets:presets">
    <xsl:call-template name="list_header"/>
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

<xsl:template name="items_alone">
  <!-- item lisy without group headers -->
     <xsl:for-each select="/presets:presets">          
       <xsl:call-template name="list_header"/>
     </xsl:for-each>    
	<div id="list">
	     <xsl:for-each select="//presets:item">
	       <xsl:sort select="@*[local-name()=$sort_name]" lang="pl" />           
	       <xsl:call-template name="item"/>
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
       <xsl:sort select="@*[local-name()=$sort_name]" lang="pl"/>           
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
			   <!--  info about wiki local translation available -->
			   <xsl:if test="presets:link/@*[local-name()=$lang_href]">
			      <b class="local_wiki">
			      	<xsl:value-of select="concat(' -> Wiki(',$lang,')')" /> 
			      </b>
			   </xsl:if>   		   
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

<xsl:template name="doc_header">
	<head>
	  <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
	<title>OSM Tagging schema <xsl:value-of select="$lang"/> (build <xsl:value-of select="$build"/>)</title>       
	<style type="text/css">
	@font-face {
	    font-family: 'UbuntuMedium';
	    src: url('fonts/ubuntu-web/ubuntu-m.eot');
	    src: url('fonts/ubuntu-web/ubuntu-m.eot') format('embedded-opentype'),
	         url('fonts/ubuntu-web/ubuntu-m.woff') format('woff'),
	         url('fonts/ubuntu-web/ubuntu-m.ttf') format('truetype'),
	         url('fonts/ubuntu-web/ubuntu-m.svg#UbuntuMedium') format('svg');	
	 }
	 body { font-family: 'UbuntuMedium',verdana,tahoma ; font-size: 14px ; }
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
	 .local_wiki { color: #A00000; }

	</style>
	</head>
</xsl:template>

<xsl:template name="list_header">
	<h2>
	  <xsl:call-template name="name"/><!-- (test build <xsl:value-of select="$build"/>) -->
	</h2>
	<br/><br/>
</xsl:template>

</xsl:stylesheet>
