<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:param name="napplUsername" select="'admin'"/>
  <xsl:param name="napplPassword" select="'40+/6G71UxYoO2FKcA'"/>
  <xsl:param name="dbUsername" select="'nscale'"/>
  <xsl:param name="dbPassword" select="'40+/6G71UxYoO2FKcA'"/>
  <xsl:param name="nstlUsername" select="'admin'"/>
  <xsl:param name="nstlPassword" select="'jBfA+BQVCI+YP8t5'"/>
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/COLD/ApplicationLayers/ApplicationLayerItem[@Enabled='true']/@UserName">
    <xsl:attribute name="UserName">
       <xsl:value-of select="$napplUsername"/>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="/COLD/ApplicationLayers/ApplicationLayerItem[@Enabled='true']/@Password">
    <xsl:attribute name="Password">
       <xsl:value-of select="$napplPassword"/>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="/COLD/ApplicationLayers/ApplicationLayerItem[@Enabled='true']/@DbUserName">
    <xsl:attribute name="DbUserName">
       <xsl:value-of select="$dbUsername"/>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="/COLD/ApplicationLayers/ApplicationLayerItem[@Enabled='true']/@DbPassword">
    <xsl:attribute name="DbPassword">
       <xsl:value-of select="$dbPassword"/>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="/COLD/Archives/ArchiveItem[@Enabled='true']/@LoginUsername">
    <xsl:attribute name="LoginUsername">
       <xsl:value-of select="$nstlUsername"/>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="/COLD/Archives/ArchiveItem[@Enabled='true']/@LoginPassword">
    <xsl:attribute name="LoginPassword">
       <xsl:value-of select="$nstlPassword"/>
    </xsl:attribute>
  </xsl:template>
</xsl:stylesheet>
