<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:mcracl="http://www.mycore.de/xslt/acl"
  xmlns:mirnotes="http://www.mycore.de/xslt/mirnotes"
  xmlns:mirobject="http://www.mycore.de/xslt/mirobject"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all">

  <xsl:template match="field[@name='note']" mode="metadata-box-field" priority="1">
    <xsl:param name="object" as="element(mycoreobject)" />
    <xsl:variable name="mods" select="mirobject:mods($object)" />
    <xsl:variable name="is-guest" select="mcracl:is-current-user-guest-user()" />

    <xsl:for-each select="
      $mods/mods:note[not(@type) or mirnotes:visible(., 'guest')][not($is-guest and @type = 'ownership')]
    ">
      <xsl:call-template name="mods-meta-row">
        <xsl:with-param name="nodes" select="." />
        <xsl:with-param name="label" select="if (@type) then mirnotes:label(.) else ()" />
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
