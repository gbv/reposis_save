<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all">

  <xsl:import href="xslImport:solr-document:save/solr/indexing/fields.xsl"/>

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

    <xsl:for-each select="$mods/mods:subject[matches(@valueURI, '^https?://d-nb\.info/gnd/')]/mods:topic">
      <field name="mods.objectName">
        <xsl:value-of select="." />
      </field>
    </xsl:for-each>
    <xsl:for-each select="$mods/mods:subject[contains(@valueURI, '://obg.vocnet.org/')]/mods:topic">
      <field name="mods.subjectGroup">
        <xsl:value-of select="." />
      </field>
    </xsl:for-each>
    <xsl:for-each select="$mods/mods:subject[not(@valueURI)]/mods:topic">
      <field name="mods.keyword">
        <xsl:value-of select="." />
      </field>
    </xsl:for-each>
    <xsl:for-each select="$mods/mods:physicalDescription/mods:form[@type = ('material', 'technique')]">
      <field name="mods.{@type}">
        <xsl:value-of select="." />
      </field>
    </xsl:for-each>

    <xsl:variable name="dating-years" as="xs:integer*" select="
      $mods/mods:originInfo/(mods:dateCreated | mods:dateIssued | mods:dateOther)[@encoding = ('w3cdtf', 'iso8601')]
      ! replace(normalize-space(.), '^(-?\d{1,4}).*$', '$1')[matches(., '^-?\d{1,4}$')] ! xs:integer(.)
    " />
    <xsl:if test="exists($dating-years)">
      <field name="mods.datingStart">
        <xsl:value-of select="min($dating-years)" />
      </field>
      <field name="mods.datingEnd">
        <xsl:value-of select="max($dating-years)" />
      </field>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
