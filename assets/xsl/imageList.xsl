<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:sfm="http://schema.slothsoft.net/farah/module"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/*">
		<xsl:variable name="pics"
			select="*[@name='images']//sfm:resource" />
		<div>
			<dl>
				<xsl:for-each select="$pics">
					<xsl:sort select="@url" />
					<dt>
						<h1>
							<xsl:value-of select="@url" />
						</h1>
					</dt>
					<dd>
						<a href="{@href}" title="{@path}">
							<img src="{@href}" alt="{@path}" />
						</a>
					</dd>
				</xsl:for-each>
			</dl>
		</div>
	</xsl:template>
</xsl:stylesheet>
