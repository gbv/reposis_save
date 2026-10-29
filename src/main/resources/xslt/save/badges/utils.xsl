<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:mcrclassification="http://www.mycore.de/xslt/classification"
  xmlns:mcri18n="http://www.mycore.de/xslt/i18n"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all">

  <xsl:include href="resource:xslt/mir/badges/utils.xsl" />

  <!--
    Outputs a badge for each category of the given classification assigned to the current solr doc.
    category.top also contains all ancestors of an assigned category, so these are filtered out.
  -->
  <xsl:template name="output-classification-badge">
    <xsl:param name="classification" as="xs:string" />
    <xsl:param name="class" as="xs:string?" />
    <xsl:param name="tooltip-key" as="xs:string?" />

    <xsl:variable name="prefix" select="concat($classification, ':')" />
    <xsl:variable name="category-ids" as="xs:string*" select="distinct-values(
      (arr | field)[@name = 'category.top']/str[starts-with(., $prefix)] ! substring-after(., $prefix)
    )" />
    <xsl:variable name="ancestor-ids" as="xs:string*" select="
      for $id in $category-ids
      return document(concat('classification:metadata:0:parents:', $classification, ':', encode-for-uri($id)))
        //category[descendant::category]/@ID
    " />

    <xsl:for-each select="$category-ids[not(. = $ancestor-ids)]">
      <xsl:variable name="category" select="mcrclassification:category($classification, .)" />
      <xsl:if test="$category">
        <xsl:call-template name="output-badge">
          <xsl:with-param name="class" select="$class" />
          <xsl:with-param name="label" select="mcrclassification:current-label-text($category)" />
          <xsl:with-param name="link" select="
            concat($ServletsBaseURL, 'solr/find?condQuery=*&amp;fq=category.top:%22', encode-for-uri($prefix || .), '%22')
          " />
          <xsl:with-param name="tooltip" select="if ($tooltip-key) then mcri18n:translate($tooltip-key) else ()" />
        </xsl:call-template>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
