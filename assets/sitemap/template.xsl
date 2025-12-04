<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://schema.slothsoft.net/farah/sitemap" xmlns:sfd="http://schema.slothsoft.net/farah/dictionary" xmlns:sfm="http://schema.slothsoft.net/farah/module" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ssp="http://schema.slothsoft.net/schema/presskit">

    <xsl:template match="/*">
        <domain name="daniel-schulz.slothsoft.net" title="daniel-schulz.slothsoft.net" vendor="slothsoft" module="daniel-schulz.slothsoft.net" ref="pages/default" status-active="" status-public="" sfd:languages="en-us" version="1.1" sfd:dict="@title">

            <page name="AboutMe" title="AboutMe" ref="pages/default" status-active="" status-public="">
                <xsl:apply-templates select="*[@name = 'resumes']" />
            </page>

            <page name="Projects" ref="pages/default" status-active="" status-public="">
                <page name="Ambermoon" ref="pages/default" status-active="" status-public="" />
                <page name="LODB" ref="pages/default" status-active="" status-public="" />
                <page name="Japanese" ref="pages/default" status-active="" status-public="" />
                <page name="MTG" ref="pages/default" status-active="" status-public="" />
                <page name="Unicode" ref="pages/default" status-active="" />
                <page name="Farah" ref="pages/default" status-active="" status-public="" />
                <page name="PowerFantasyVR" redirect="/Games/PowerFantasyVR" />
            </page>

            <xsl:apply-templates select="*[@name = 'games']" />

            <xsl:apply-templates select="*[@name = 'jam-games']" />

            <file name="favicon.ico" ref="static/favicon" status-active="" />
            <page name="sitemap" ref="//slothsoft@farah/sitemap-generator" status-active="" />

            <xsl:apply-templates select="*[@name = 'builds']" />

            <xsl:apply-templates select="*[@name = 'downloads']" />
        </domain>
    </xsl:template>

    <xsl:template match="*[@name = 'resumes']">
        <xsl:for-each select="sfm:fragment-info/sfm:manifest-info">
            <page name="{@name}" ref="pages/resume" status-active="">
                <sfm:param name="source" value="{@url}" />
            </page>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="*[@name = 'builds']">
        <xsl:for-each select="builds">
            <page name="Builds" redirect=".." status-active="">
                <xsl:for-each select="project">
                    <page name="{.}" status-active="">
                        <sfm:param name="project" value="{.}" />
                        <xsl:for-each select="../build-info[@project = current()]">
                            <page name="{@branch}" ref="pages/build" status-active="" status-public="">
                                <sfm:param name="branch" value="{@branch}" />
                            </page>
                        </xsl:for-each>
                    </page>
                </xsl:for-each>
            </page>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="*[@name = 'downloads']">
        <xsl:for-each select="sfm:fragment-info">
            <page name="Downloads" redirect=".." status-active="">
                <xsl:for-each select="sfm:manifest-info">
                    <file name="{@name}" ref="{@url}" status-active="" />
                </xsl:for-each>
            </page>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="*[@name = 'games']">
        <page name="Games" ref="pages/default" status-active="" status-public="">
            <xsl:for-each select=".//sfm:document-info">
                <xsl:sort select=".//ssp:release-date" data-type="number" />
                <xsl:variable name="title" select=".//ssp:title" />
                <page name="{@name}" title="{$title}" ref="pages/default" status-active="" status-public="" />
            </xsl:for-each>
        </page>
    </xsl:template>

    <xsl:template match="*[@name = 'jam-games']">
        <page name="GameJams" ref="pages/game-jams" status-active="" status-public="">
            <xsl:for-each select=".//sfm:document-info">
                <xsl:sort select=".//ssp:start-date/@datetime" />
                <xsl:variable name="title" select="concat(translate(.//ssp:jam/ssp:title, ' ', '&#160;'), ': ', translate(.//ssp:game/ssp:title, ' ', '&#160;'))" />
                <page name="{@name}" title="{$title}" ref="pages/game-jam?document={@url}" status-active="" status-public="" />
            </xsl:for-each>
        </page>
    </xsl:template>
</xsl:stylesheet>
				