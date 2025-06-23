<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:sfs="http://schema.slothsoft.net/farah/sitemap" xmlns:sfm="http://schema.slothsoft.net/farah/module"
	xmlns:html="http://www.w3.org/1999/xhtml" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="sourceURI" select="//sfs:page[@current]/sfm:param/@value" />
	<xsl:variable name="source" select="document($sourceURI)/resume" />

	<xsl:template match="/*">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<head>
				<title>
					<xsl:value-of select="$source/name" />
				</title>
				<link rel="icon" type="image/png" href="/slothsoft@daniel-schulz.slothsoft.net/static/favicon" />
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<meta name="author" content="Daniel Schulz" />

				<xsl:copy-of select="$source" />
			</head>
			<body>
				<xsl:apply-templates select="$source" mode="resume" />
			</body>
		</html>
	</xsl:template>

	<xsl:template match="resume" mode="resume">
		<main>
			<section>
				<hgroup>
					<img src="{photo}" />
					<h1>
						<xsl:value-of select="name" />
					</h1>
					<h2 class="important">
						<xsl:value-of select="job" />
					</h2>
				</hgroup>
				<h2>Employment History</h2>
				<xsl:for-each select="employment">
					<article>
						<h3>
							<xsl:value-of select="job" />
						</h3>
						<p class="important">
							<xsl:value-of select="start/@year" />
							<xsl:text> - </xsl:text>
							<xsl:choose>
								<xsl:when test="end">
									<xsl:value-of select="end/@year" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>present</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</p>
						<p>
							<xsl:copy-of select="description/node()" />
						</p>
					</article>
				</xsl:for-each>
			</section>
			<section>
				<h2>Details</h2>
				<xsl:apply-templates select="address" mode="resume" />
				<p>
					<xsl:value-of select="phone" />
				</p>
				<p>
					<a href="mailto:{name} &lt;{email}>">
						<xsl:value-of select="email" />
					</a>
				</p>
			</section>
		</main>
	</xsl:template>

	<xsl:template match="address" mode="resume">
		<p>
			<xsl:value-of select="street" />
			<br />
			<xsl:value-of select="city" />
			<xsl:text>, </xsl:text>
			<xsl:value-of select="postal-code" />
			<br />
			<xsl:value-of select="country" />
		</p>
	</xsl:template>
</xsl:stylesheet>