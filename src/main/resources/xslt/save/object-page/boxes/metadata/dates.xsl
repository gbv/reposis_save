<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:mirdates="http://www.mycore.de/xslt/mirdates"
  xmlns:mirobject="http://www.mycore.de/xslt/mirobject"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all">

  <!--
    Outputs exactly one row for mods:dateCreated.
    An unencoded date (kuniweb free text, LIDO displayDate) is the display form and is output as is.
    Otherwise the encoded start/end range or the single encoded date is rendered; the encoded values
    are used for search and the date badge.
  -->
  <xsl:template match="field[@name='dates.created']" mode="metadata-box-field">
    <xsl:param name="object" as="element(mycoreobject)" />
    <xsl:variable name="dates" select="
      mirobject:mods($object)/mods:originInfo[@eventType='creation']/mods:dateCreated
    " />
    <xsl:variable name="display" select="$dates[not(@encoding)][normalize-space() != ''][1]" />
    <xsl:variable name="encoded" select="
      if ($dates[@point]) then ($dates[@point='start'][1], $dates[@point='end'][1]) else $dates[@encoding][1]
    " />

    <xsl:call-template name="meta-row">
      <xsl:with-param name="label-key" select="'component.mods.metaData.dictionary.dateCreated'" />
      <xsl:with-param name="value" select="
        if ($display)
        then normalize-space($display)
        else string-join(distinct-values($encoded ! mirdates:format(.)), ' - ')
      " />
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
