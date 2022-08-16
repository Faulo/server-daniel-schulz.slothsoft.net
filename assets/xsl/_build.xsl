<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:sfs="http://schema.slothsoft.net/farah/sitemap"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/*">
		<xsl:variable name="build" select="//build-info[@name]" />
		<xsl:variable name="pages"
			select="*[@name='sites']//sfs:page" />
		<xsl:variable name="requestedPage"
			select="$pages[@current]" />
		<xsl:variable name="relatedPage"
			select="$pages[@name = $build/@project][not(descendant-or-self::*/@current)]" />
		<xsl:variable name="title">
			<xsl:value-of select="$build/@name" />
			<xsl:if test="$build/@version">
				<xsl:text> v</xsl:text>
				<xsl:value-of select="$build/@version" />
			</xsl:if>
			<xsl:text> (</xsl:text>
			<xsl:value-of select="$build/@datetime" />
			<xsl:text>)</xsl:text>
		</xsl:variable>
		<xsl:variable name="credits">
			<xsl:text> © </xsl:text>
			<xsl:value-of select="$build/@credits" />
		</xsl:variable>

		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html class="build">
			<head>
				<title>
					<xsl:value-of select="$title" />
					<xsl:value-of select="$credits" />
				</title>
				<meta name="viewport"
					content="width=device-width, initial-scale=1" />
				<meta name="author" content="Daniel Schulz" />
				<xsl:for-each select="$build//link">
					<link>
						<xsl:copy-of select="@*" />
					</link>
				</xsl:for-each>
			</head>
			<body>
				<xsl:choose>
					<xsl:when test="$build/@unityVersion = '2019'">
						<div id="unity-container" class="unity-desktop webgl-content">
							<h1 class="myBody">
								<xsl:value-of select="$title" />
							</h1>
							<div id="{$build//*[@style]/@id}"
								style="{$build//*[@style]/@style}"></div>
							<div class="footer">
								<div class="webgl-logo"></div>
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
								<div class="fullscreen"
									onclick="{$build//*[@onclick]/@onclick}"></div>
							</div>
						</div>
					</xsl:when>
					<xsl:when test="$build/@unityVersion = '2020'">
						<div id="unity-container" class="unity-desktop">
							<h1 class="myBody">
								<xsl:value-of select="$title" />
							</h1>
							<canvas id="unity-canvas"></canvas>
							<div id="unity-loading-bar">
								<div id="unity-logo"></div>
								<div id="unity-progress-bar-empty">
									<div id="unity-progress-bar-full"></div>
								</div>
							</div>
							<div id="unity-footer">
								<div id="unity-webgl-logo"></div>
								<div id="unity-build-title">
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
								<div id="unity-fullscreen-button"></div>
							</div>
						</div>
					</xsl:when>
					<xsl:when test="$build/@unityVersion = '2021'">
						<div id="unity-container" class="unity-desktop">
							<h1 class="myBody">
								<xsl:value-of select="$title" />
							</h1>
							<xsl:for-each select="$build//canvas">
								<canvas>
									<xsl:copy-of select="@*" />
								</canvas>
							</xsl:for-each>
						</div>
					</xsl:when>
				</xsl:choose>
				<xsl:for-each select="$build//script">
					<script type="application/javascript">
						<xsl:copy-of select="@*" />
						<xsl:value-of select="." />
					</script>
				</xsl:for-each>
			</body>
		</html>

	</xsl:template>
</xsl:stylesheet>