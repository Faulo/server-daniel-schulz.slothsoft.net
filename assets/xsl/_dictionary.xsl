<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:sfm="http://schema.slothsoft.net/farah/module" xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:svg="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sfd="http://schema.slothsoft.net/farah/dictionary">

    <xsl:template match="/*">
        <sfd:dictionary>
            <xsl:for-each select="sfm:manifest-info">
                <xsl:copy-of select="document(@url)/sfd:dictionary/*" />
            </xsl:for-each>
            <xsl:for-each select="sfm:document-info">
                <xsl:copy-of select="sfd:dictionary/*" />
            </xsl:for-each>
        </sfd:dictionary>
    </xsl:template>
</xsl:stylesheet>