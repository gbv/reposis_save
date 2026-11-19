<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all">

  <xsl:import href="xslImport:modsmeta:save/object-page/boxes/citation.xsl" />

  <xsl:template match="mods:note[@type='ownership']" mode="dc" />

</xsl:stylesheet>
