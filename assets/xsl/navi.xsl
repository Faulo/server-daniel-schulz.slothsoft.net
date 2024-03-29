<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:sfs="http://schema.slothsoft.net/farah/sitemap"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/*">
		<xsl:variable name="domain"
			select="*[@name='sites']/sfs:domain" />
		<xsl:variable name="pageList"
			select="$domain | $domain//sfs:page[@status-active][@status-public or @current][@ref]" />
		<xsl:variable name="row1"
			select="$pageList[count(ancestor::sfs:page) = 0]" />
		<xsl:variable name="row2"
			select="$pageList[count(ancestor::sfs:page) = 1][../@current or ../*/@current]" />

		<div>
			<xsl:if test="count($row1)">
				<div class="navi">
		            <figure>
		                <img src="/slothsoft@daniel-schulz.slothsoft.net/static/face" />
		                <figcaption>Daniel Schulz</figcaption>
		            </figure>
					<xsl:apply-templates select="$row1" />
				</div>
			</xsl:if>
			<xsl:if test="count($row2)">
				<div class="navi"
					data-section="{$pageList[@current]/ancestor-or-self::sfs:page/@name}">
					<xsl:apply-templates select="$row2" />
				</div>
			</xsl:if>
		</div>
	</xsl:template>

	<xsl:template match="sfs:domain | sfs:page">
		<xsl:param name="createImage" select="false()" />
		<xsl:variable name="childPages"
			select="sfs:page[@status-active][@status-public or descendant-or-self::sfs:page[@current]]" />
		<a href="{@uri}">
			<xsl:if test="self::sfs:page or @current">
				<xsl:attribute name="class">
					<xsl:if
					test="$childPages and (descendant-or-self::*[@current])">
						<xsl:text>open</xsl:text>
					</xsl:if>
					<xsl:if
					test="$childPages and not(descendant-or-self::*[@current])">
						<xsl:text>close</xsl:text>
					</xsl:if>
					<xsl:if test="@ext">
						<xsl:text>extern</xsl:text>
					</xsl:if>
                    <xsl:if test="$childPages">
                        <xsl:text> category</xsl:text>
                    </xsl:if>
					<xsl:if test="descendant-or-self::*[@current]">
						<xsl:text> current</xsl:text>
					</xsl:if>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="self::sfs:page/sfs:page">
				<xsl:choose>
					<xsl:when test="descendant-or-self::*[@current]">
						<span class="pointer">⮟</span>
					</xsl:when>
					<xsl:otherwise>
						<span class="pointer">⮞</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<span data-dict="">
				<xsl:value-of select="@title" />
			</span>
		</a>
	</xsl:template>
</xsl:stylesheet>
