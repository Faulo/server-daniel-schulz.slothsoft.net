<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:sfs="http://schema.slothsoft.net/farah/sitemap" xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:svg="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sfm="http://schema.slothsoft.net/farah/module" xmlns:ssp="http://schema.slothsoft.net/schema/presskit">

	<xsl:import href="farah://slothsoft@schema/xsl/presskit.functions" />

	<xsl:template match="/*">
		<xsl:variable name="requestedPage" select="*[@name='sites']//*[@current]" />
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<head>
				<title>
					<p data-dict=".">
						<xsl:value-of select="$requestedPage/@title" />
					</p>
					<xsl:text> | Daniel Schulz</xsl:text>
				</title>
				<link rel="icon" type="image/png" href="/slothsoft@daniel-schulz.slothsoft.net/static/favicon" />
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<meta name="author" content="Daniel Schulz" />
			</head>
			<body>
				<div class="page">
					<nav>
						<h2 class="hidden">Navigation</h2>
						<xsl:copy-of select="*[@name='navi']/node()" />
					</nav>
					<main>
						<xsl:variable name="documentURI" select="sfm:param[@name = 'document']/@value" />
						<xsl:variable name="content" select="sfm:document-info[@name='content']" />

						<xsl:choose>
							<xsl:when test="$documentURI">
								<xsl:apply-templates select="document($documentURI)" mode="content" />
							</xsl:when>
							<xsl:when test="$content">
								<xsl:copy-of select="$content/node()" />
							</xsl:when>
							<xsl:otherwise>
								<h1 data-dict="">
									<xsl:value-of select="$requestedPage/@title" />
								</h1>

								<div data-dict="">
									<xsl:value-of select="$requestedPage/@name" />
									<xsl:text>/content</xsl:text>
								</div>
							</xsl:otherwise>
						</xsl:choose>
					</main>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="ssp:jam" mode="content">
		<xsl:variable name="jam" select="." />
		<xsl:variable name="game" select=".//ssp:game" />

		<h1>
			<xsl:value-of select="$jam/ssp:title" />
			<xsl:text>: </xsl:text>
			<xsl:value-of select="$game/ssp:title" />
		</h1>

		<xsl:for-each select="$game/ssp:description">
			<article>
				<h2>About</h2>
				<p>
					<xsl:copy-of select="node()" />
				</p>
			</article>
		</xsl:for-each>

		<article>
			<h2>Jam Details</h2>
			<dl>
				<dt>
					<xsl:value-of select="$jam/ssp:title" />
				</dt>
				<dt>Date:</dt>
				<dd>
					<xsl:call-template name="ssp:date">
						<xsl:with-param name="date" select="$jam/ssp:start-date" />
					</xsl:call-template>
					<xsl:text> - </xsl:text>
					<xsl:call-template name="ssp:date">
						<xsl:with-param name="date" select="$jam/ssp:end-date" />
					</xsl:call-template>
				</dd>
				<dt>Site:</dt>
				<dd>
					<xsl:value-of select="$jam/ssp:site" />
				</dd>
				<dt>Theme:</dt>
				<dd>
					<xsl:copy-of select="$jam/ssp:theme/node()" />
				</dd>
			</dl>
		</article>

		<xsl:for-each select="$game/ssp:credits">
			<article>
				<h2>Credits</h2>
				<dl>
					<xsl:for-each select="ssp:credit">
						<dt>
							<xsl:call-template name="ssp:link">
								<xsl:with-param name="link" select="ssp:website" />
								<xsl:with-param name="name" select="ssp:person" />
							</xsl:call-template>
						</dt>
						<xsl:for-each select="ssp:role">
							<dd>
								<xsl:value-of select="." />
							</dd>
						</xsl:for-each>
					</xsl:for-each>
				</dl>
			</article>
		</xsl:for-each>

		<xsl:for-each select="$game/ssp:additionals">
			<article>
				<h2>Links</h2>
				<ul>
					<xsl:for-each select="ssp:additional">
						<li>
							<xsl:call-template name="ssp:link">
								<xsl:with-param name="link" select="ssp:link" />
								<xsl:with-param name="name" select="ssp:title" />
							</xsl:call-template>
							<xsl:if test="ssp:description">
								<br />
								<xsl:copy-of select="ssp:description/node()" />
							</xsl:if>
						</li>
					</xsl:for-each>
				</ul>
			</article>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>