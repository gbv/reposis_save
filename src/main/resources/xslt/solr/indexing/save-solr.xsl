<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="mods">

  <xsl:import href="xslImport:solr-document:solr/indexing/save-solr.xsl"/>

  <xsl:template match="mycoreobject[contains(@ID,'_mods_')]">
    <xsl:apply-imports />

    <xsl:variable name="mods" select="metadata/def.modsContainer/modsContainer/mods:mods" />

    <xsl:for-each select="$mods/mods:originInfo[@eventType='creation']/mods:dateCreated[@encoding='w3cdtf']">
      <xsl:if test="position() = 1">
        <field name="mods.dateCreated">
          <xsl:value-of select="." />
        </field>
        <xsl:variable name="yearCreated">
          <xsl:choose>
            <xsl:when test="contains(.,'-')">
              <xsl:value-of select="substring-before(.,'-')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="."/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:if test="not (string(number($yearCreated)) = 'NaN')">
          <field name="mods.yearCreated">
            <xsl:value-of select="$yearCreated" />
          </field>
        </xsl:if>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
