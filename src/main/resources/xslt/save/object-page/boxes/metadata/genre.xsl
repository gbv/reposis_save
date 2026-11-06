<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:mcrclass="http://www.mycore.de/xslt/classification"
  xmlns:mirobject="http://www.mycore.de/xslt/mirobject"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all">

  <xsl:template match="field[@name='genre']" mode="metadata-box-field">
    <xsl:param name="object" as="element(mycoreobject)" />
    <xsl:variable name="mods" select="mirobject:mods($object)" />

    <xsl:call-template name="meta-row-from-nodes">
      <xsl:with-param name="nodes" select="$mods/mods:genre" />
      <xsl:with-param name="label-key" select="'component.mods.genre'" />
      <xsl:with-param name="sep" select="', '" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="mods:genre[@type='intern']" mode="value-content">
    <xsl:variable name="category-id" select="substring-after(@valueURI, '#')" />
    <xsl:variable name="category" select="
      if ($category-id != '') then mcrclass:category('mir_genres', $category-id) else ()
    " />
    <xsl:variable name="label" select="if ($category) then mcrclass:current-label-text($category) else ()" />

    <xsl:choose>
      <xsl:when test="$label != ''">
        <xsl:sequence select="$label" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:next-match />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
