<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:mcracl="http://www.mycore.de/xslt/acl"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all">

  <xsl:template match="mods:note[@type='ownership'] | mods:location/mods:shelfLocator | mods:identifier[@type='kuni']">
    <xsl:if test="not(mcracl:is-current-user-guest-user())">
      <xsl:next-match />
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
