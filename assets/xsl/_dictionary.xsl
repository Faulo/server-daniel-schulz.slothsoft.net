<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:sfm="http://schema.slothsoft.net/farah/module" xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:svg="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/*">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-us">
			<xsl:for-each select=".//sfm:manifest-info">
				<xsl:copy-of select="document(@url)/html:html/html:p" />
			</xsl:for-each>
			<xsl:for-each select=".//sfm:document-info">
				<xsl:copy-of select="html:html/html:p" />
			</xsl:for-each>
		</html>
	</xsl:template>
</xsl:stylesheet>