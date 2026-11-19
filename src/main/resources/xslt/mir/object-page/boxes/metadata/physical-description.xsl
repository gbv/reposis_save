<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:mcrclass="http://www.mycore.de/xslt/classification"
  xmlns:mirobject="http://www.mycore.de/xslt/mirobject"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all">

  <xsl:template match="field[@name='physical-description.form']" mode="metadata-box-field">
    <xsl:param name="object" as="element(mycoreobject)" />
    <xsl:variable name="mods" select="mirobject:mods($object)" />

    <!-- START save adaptions -->
    <!--
    <xsl:variable name="file-type-class" select="
      document('classification:metadata:-1:children:mir_filetype')/mycoreclass
    " />
    <xsl:variable name="form" select="$mods/mods:physicalDescription/mods:form[
      @type = 'file' and @authorityURI = $file-type-class/label[@xml:lang = 'x-uri']/@text
    ][1]" />
    <xsl:if test="$form">
      <xsl:variable name="category" select="
        $file-type-class/categories//category[@ID = substring-after($form/@valueURI, '#')]
      " />
      <xsl:if test="$category">
        <xsl:call-template name="meta-row">
          <xsl:with-param name="label-key" select="'mir.physical.description.form'" />
          <xsl:with-param name="value" select="mcrclass:current-label-text($category)" />
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
    -->
    <!-- one row per form type (material, technique, decoration), untyped forms keep the combined label -->
    <xsl:variable name="forms" select="$mods/mods:physicalDescription/mods:form" />
    <xsl:for-each select="'material', 'technique', 'decoration'">
      <xsl:call-template name="meta-row-from-nodes">
        <xsl:with-param name="label-key" select="'save.physicalDescription.form.' || ." />
        <xsl:with-param name="nodes" select="$forms[@type = current()]" />
        <xsl:with-param name="sep" select="', '" />
      </xsl:call-template>
    </xsl:for-each>
    <xsl:call-template name="meta-row-from-nodes">
      <xsl:with-param name="label-key" select="'save.physicalDescription.form'" />
      <xsl:with-param name="nodes" select="$forms[not(@type)]" />
      <xsl:with-param name="sep" select="', '" />
    </xsl:call-template>
    <!-- END save adaptions -->
  </xsl:template>

  <xsl:template match="field[@name='physical-description.note']" mode="metadata-box-field">
    <xsl:param name="object" as="element(mycoreobject)" />
    <xsl:variable name="mods" select="mirobject:mods($object)" />

    <xsl:call-template name="meta-row-from-nodes">
      <xsl:with-param name="label-key" select="'mir.physical.description.note'" />
      <xsl:with-param name="nodes" select="$mods/mods:physicalDescription/mods:note[@xlink:type = 'simple'][1]" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="field[@name='physical-description']" mode="metadata-box-field">
    <xsl:param name="object" as="element(mycoreobject)" />
    <xsl:variable name="mods" select="mirobject:mods($object)" />

    <!-- START save adaptions: one row for all extents (one mods:extent per measurement) -->
    <xsl:call-template name="meta-row">
      <xsl:with-param name="label-key" select="'component.mods.metaData.dictionary.extent'" />
      <xsl:with-param name="value">
        <xsl:for-each select="$mods/mods:physicalDescription/mods:extent">
          <xsl:if test="position() != 1">
            <br />
          </xsl:if>
          <xsl:call-template name="format-extent" />
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
    <!-- END save adaptions -->
  </xsl:template>

</xsl:stylesheet>
