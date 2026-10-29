<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:mcracl="http://www.mycore.de/xslt/acl"
  xmlns:mirobject="http://www.mycore.de/xslt/mirobject"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all">

  <!-- Splits mods:physicalLocation by @type into location.physical.creation and .discovery -->
  <xsl:template match="field[@name = ('location.physical.creation', 'location.physical.discovery')]"
    mode="metadata-box-field">
    <xsl:param name="object" as="element(mycoreobject)" />
    <xsl:variable name="mods" select="mirobject:mods($object)" />
    <xsl:variable name="type" select="substring-after(@name, 'location.physical.')" />

    <!-- discovery locations are only visible to logged-in users -->
    <xsl:if test="not($type = 'discovery' and mcracl:is-current-user-guest-user())">
      <xsl:call-template name="meta-row-from-nodes">
        <xsl:with-param name="label-key" select="concat('save.physicalLocation.', $type)" />
        <xsl:with-param name="nodes" select="
          $mods/mods:location/mods:physicalLocation[@type = $type][not(starts-with(@xlink:href, '#'))]
        " />
        <xsl:with-param name="sep" select="', '" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
