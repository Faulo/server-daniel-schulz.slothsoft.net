<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:sfs="http://schema.slothsoft.net/farah/sitemap" xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:svg="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/*">
		<xsl:variable name="build" select="//build-info[@name]" />
		<xsl:variable name="pages" select="*[@name='sites']//sfs:page" />
		<xsl:variable name="requestedPage" select="$pages[@current]" />
		<xsl:variable name="relatedPage" select="$pages[not(@current)][@name = $build/@project]" />
		<xsl:variable name="title">
			<xsl:value-of select="$build/@name" />
			<xsl:if test="$build/@version">
				v
				<xsl:value-of select="$build/@version" />
			</xsl:if>
			(
			<xsl:value-of select="$build/@datetime" />
			)
		</xsl:variable>
		<xsl:variable name="credits">
			©
			<xsl:value-of select="$build/@credits" />
		</xsl:variable>

		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html class="build">
			<head>
				<title>
					<xsl:value-of select="$title" />
					<xsl:text> © </xsl:text>
					<xsl:value-of select="$build/@credits" />
				</title>
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<meta name="author" content="Daniel Schulz" />
				<xsl:for-each select="$build//link">
					<link>
						<xsl:copy-of select="@*" />
					</link>
				</xsl:for-each>
				<xsl:for-each select="$build//script">
					<script type="application/javascript">
						<xsl:copy-of select="@*" />
						<xsl:value-of select="." />
					</script>
				</xsl:for-each>
			</head>
			<body>
				<div class="webgl-content">
					<h1>
						<xsl:value-of select="$title" />
					</h1>
					<div id="{$build//*[@style]/@id}" style="width: 960px; height: 600px"></div>
					<div class="footer">
						<div class="webgl-logo"></div>
						<div class="fullscreen" onclick="{$build//*[@onclick]/@onclick}"></div>
						<div class="title">
							<xsl:choose>
								<xsl:when test="$relatedPage">
									<a href="{$relatedPage/@uri}">
										<xsl:value-of select="$credits" />
									</a>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$credits" />
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</div>
				</div>
			</body>
		</html>

	</xsl:template>
</xsl:stylesheet>