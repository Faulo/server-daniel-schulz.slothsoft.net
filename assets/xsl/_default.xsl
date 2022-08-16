<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:sfs="http://schema.slothsoft.net/farah/sitemap"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/*">
		<xsl:variable name="requestedPage"
			select="*[@name='sites']//*[@current]" />
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<head>
				<title>
					<p data-dict=".">
						<xsl:value-of select="$requestedPage/@title" />
					</p>
					<xsl:text> | Daniel Schulz</xsl:text>
				</title>
				<link rel="icon" type="image/png"
					href="/slothsoft@daniel-schulz.slothsoft.net/static/favicon" />
				<meta name="viewport"
					content="width=device-width, initial-scale=1" />
				<meta name="author" content="Daniel Schulz" />
			</head>
			<body>
				<div class="page">
					<nav>
						<h2 class="hidden">Navigation</h2>
						<xsl:copy-of select="*[@name='navi']/node()" />
					</nav>
					<main>
						<h1 data-dict="">
							<xsl:value-of select="$requestedPage/@title" />
						</h1>
						<div data-dict="">
							<xsl:value-of select="$requestedPage/@name" />
							<xsl:text>/content</xsl:text>
						</div>
						<xsl:copy-of select="*[@name='content']/node()" />
					</main>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>