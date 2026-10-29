<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all">

  <xsl:import href="xslImport:badges:save/badges/institution.xsl"/>
  <xsl:include href="resource:xslt/save/badges/utils.xsl" />

  <xsl:template match="doc" mode="badge">
    <xsl:apply-imports/>

    <xsl:call-template name="output-classification-badge">
      <xsl:with-param name="classification" select="'mir_institutes'" />
      <xsl:with-param name="class" select="'mir-badge-institution'" />
      <xsl:with-param name="tooltip-key" select="'mir.institution'" />
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
