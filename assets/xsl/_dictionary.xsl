<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sfm="http://schema.slothsoft.net/farah/module" xmlns:sfd="http://schema.slothsoft.net/farah/dictionary" xmlns:ssp="http://schema.slothsoft.net/schema/presskit">

    <xsl:import href="farah://slothsoft@schema/xsl/presskit.functions" />
    <xsl:import href="farah://slothsoft@farah/xsl/dictionary" />

    <xsl:template match="/*">
        <sfd:dictionary version="1.0">
            <xsl:apply-templates select="sfm:document-info" />
        </sfd:dictionary>
    </xsl:template>

    <xsl:template match="sfm:document-info/sfd:dictionary">
        <xsl:copy-of select="*" />
    </xsl:template>

    <xsl:template match="sfm:document-info/ssp:game">
        <sfd:fragment>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="../@name" />
                <xsl:text>.credits</xsl:text>
            </xsl:attribute>
            <article>
                <h2>Credits</h2>
                <dl class="tabled-list">
                    <xsl:for-each select="ssp:credits/ssp:credit">
                        <xsl:sort select="ssp:person" />
                        <dt>
                            <sfd:lookup key="{sfd:sanitize-key(ssp:person)}" />
                        </dt>
                        <xsl:for-each select="ssp:role">
                            <dd>
                                <xsl:value-of select="." />
                            </dd>
                        </xsl:for-each>
                    </xsl:for-each>
                </dl>
            </article>
        </sfd:fragment>
    </xsl:template>
</xsl:stylesheet>