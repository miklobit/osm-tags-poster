<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:gpx="http://www.topografix.com/GPX/1/0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
<xsl:param name="log_width" select="400"/>

<xsl:template match="/">
  <xsl:apply-templates select="gpx:gpx"/>
</xsl:template>

<xsl:template match="gpx:gpx">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
<title>Logbook rekonstruktor</title>       
<style type="text/css">
 table  { border-collapse:collapse; }
 #list * { font-family: verdana,tahoma ; font-size: 10px ; }
 #list table, td, th 
  { border-top: 1px solid black; text-align: left ;
    vertical-align: top; } 
 td.finder  { padding-left: 5px; font-weight: bold; background-color: #F8F8F8 ;}  
 td.icon    { padding-left: 10px; padding-right: 10px; background-color: #F8F8F8 ; }
 td.fdate   { padding-right: 5px; font-weight: bold; background-color: #F8F8F8 ;}
 td.text    { border: 0px; }
</style>
</head>
<body>
<div id="list">
   <xsl:attribute name="style">
      width: <xsl:value-of select="$log_width"/>px ; height: 100%;
   </xsl:attribute>
   <xsl:apply-templates select="gpx:wpt"/>
</div>
<div id="message"></div>
</body>
</html>
</xsl:template>

<xsl:template match="gpx:wpt">
 <xsl:if test="count(groundspeak:cache/groundspeak:logs/groundspeak:log) &gt; 0">
   <xsl:if test="$include_nam = '1'">
      <h><xsl:value-of select="groundspeak:cache/groundspeak:name"/></h><br/><br/>
   </xsl:if>  
 <!-- <p>Position: <xsl:value-of select="@lat"/>, <xsl:value-of select="@lon"/> </p><br/> -->
  <table>
     <xsl:if test="$show_dat = '1'">
       <tr><td>
            <xsl:attribute name="class">fdate</xsl:attribute>
             <xsl:value-of select="substring(gpx:time,1,10)"/>
           </td>
            <xsl:if test="$show_icon = '1'">
             <td></td>
            </xsl:if> 
           <td>
             <xsl:attribute name="class">finder</xsl:attribute>
             Założenie skrzynki
           </td>
       </tr>    
     </xsl:if>  
     <xsl:for-each select="groundspeak:cache/groundspeak:logs/groundspeak:log">
      <xsl:sort select="groundspeak:date"/>
      <xsl:if test="groundspeak:finder != $system">
        <xsl:if test="groundspeak:type = $found">
          <xsl:call-template name="log_entry"/>    
        </xsl:if>  
        <xsl:if test="groundspeak:type = $dnf  and $include_dnf = '1'">
          <xsl:call-template name="log_entry"/>    
        </xsl:if>              
      </xsl:if>
    </xsl:for-each>
   </table>
   <br /><br /><br />
 <!--  
 <p>Name: <xsl:value-of select="gpx:name"/>  </p><br/>
 <p>Desc: <xsl:value-of select="gpx:desc"/>  </p><br/>
 -->
 </xsl:if>
</xsl:template>


<xsl:template name="log_entry">
          <xsl:variable name="color">
          <xsl:choose>
             <xsl:when test="groundspeak:type = $found">gre</xsl:when>
             <xsl:when test="groundspeak:type = $dnf">red</xsl:when>
             <xsl:otherwise>yel</xsl:otherwise>
          </xsl:choose>   
          </xsl:variable>   
          <xsl:variable name="smile">
          <xsl:choose>
             <xsl:when test="groundspeak:type = $found">http://opencaching.pl/tpl/stdstyle/images/log/16x16-found.png</xsl:when>
             <xsl:when test="groundspeak:type = $dnf">http://opencaching.pl/tpl/stdstyle/images/log/16x16-dnf.png</xsl:when>
             <xsl:otherwise>http://opencaching.pl/tpl/stdstyle/images/log/16x16-note.png</xsl:otherwise>
          </xsl:choose>   
          </xsl:variable>            
      <tr>
        <td>
        <xsl:attribute name="class">fdate</xsl:attribute>
        <xsl:value-of select="substring(groundspeak:date,1,10)"/></td>
        <xsl:if test="$show_icon = '1'">
          <td>
            <xsl:attribute name="class">icon</xsl:attribute>
            <img>
            <xsl:attribute name="src"> <xsl:value-of select="$smile" /> </xsl:attribute>
            </img>
          </td>
        </xsl:if>
        <td>
          <xsl:attribute name="class">finder</xsl:attribute>
          <xsl:value-of select="groundspeak:finder"/>
        </td>
      </tr>   
        <xsl:if test="$include_txt = '1'">
         <tr>
          <td>
            <xsl:attribute name="class">text</xsl:attribute>
            <xsl:attribute name="colspan">
                       <xsl:if test="$show_icon = '1'">3</xsl:if>
                       <xsl:if test="$show_icon = '0'">2</xsl:if>
            </xsl:attribute>
            <xsl:value-of select="groundspeak:text"/>
          </td>
         </tr> 
        </xsl:if>     
</xsl:template>


</xsl:stylesheet>