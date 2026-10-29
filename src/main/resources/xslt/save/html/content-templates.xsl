<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="contact-entry">
    <p class="contact-entry">
      <xsl:if test="name">
        <strong>
          <xsl:value-of select="name" />
        </strong>
        <br/>
      </xsl:if>
      <xsl:if test="contact-person">
        Ansprechpartner:
        <xsl:value-of select="string-join(contact-person, ', ')" />
        <br/>
      </xsl:if>
      <xsl:if test="address/street">
        <xsl:value-of select="address/street" />
        <br/>
      </xsl:if>
      <xsl:if test="address/additional">
        <xsl:value-of select="address/additional" />
        <br/>
      </xsl:if>
      <xsl:if test="address/postal-code or address/city">
        <xsl:value-of select="string-join((address/postal-code, address/city), ' ')" />
        <br/>
      </xsl:if>
      <xsl:if test="email">
        E-Mail:
        <a href="mailto:{email}">
          <span class="madress">
            <xsl:value-of select="email" />
          </span>
        </a>
        <br/>
      </xsl:if>
      <xsl:if test="phone">
        Telefon:
        <a href="tel:{translate(phone, ' +()-', '')}">
          <xsl:value-of select="phone" />
        </a>
        <br/>
      </xsl:if>
      <xsl:if test="website">
        Website:
        <a href="{website}">
          <xsl:value-of select="website" />
        </a>
      </xsl:if>
    </p>
  </xsl:template>

</xsl:stylesheet>
