<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:sfs="http://schema.slothsoft.net/farah/sitemap" xmlns:sfm="http://schema.slothsoft.net/farah/module"
	xmlns:html="http://www.w3.org/1999/xhtml" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl" xmlns:lio="http://slothsoft.net"
	xmlns:func="http://exslt.org/functions" extension-element-prefixes="func">

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

				<link rel="preconnect" href="https://fonts.googleapis.com" />
				<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="crossorigin" />
				<link href="https://fonts.googleapis.com/css2?family=Lexend:wght@100..900&amp;family=Oswald:wght@200..700&amp;display=swap" rel="stylesheet" />
			</head>
			<body>
				<div class="page">
					<xsl:apply-templates select="$source" mode="resume" />
				</div>
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
					<p class="important">
						<xsl:value-of select="job" />
					</p>
				</hgroup>
				<article>
					<h2>Profile</h2>
					<xsl:copy-of select="profile/node()" />
				</article>

				<xsl:apply-templates select="section" mode="resume" />
			</section>
			<section class="sidebar">
				<h2>Contact</h2>
				<p>
					<xsl:value-of select="name" />
				</p>
				<xsl:apply-templates select="address" mode="resume" />
				<p>
					<xsl:value-of select="phone" />
				</p>
				<p>
					<a href="mailto:{name} &lt;{email}>">
						<xsl:value-of select="email" />
					</a>
				</p>

				<xsl:apply-templates select="skills" mode="resume" />

				<h2>Links</h2>
				<xsl:for-each select="link">
					<p>
						<a href="{@href}>" rel="external" target="_blank">
							<xsl:value-of select="." />
						</a>
					</p>
				</xsl:for-each>
			</section>
		</main>
	</xsl:template>

	<xsl:template match="section" mode="resume">
		<article>
			<h2>
				<xsl:value-of select="@name" />
			</h2>
			<xsl:for-each select="occupation">
				<article>
					<h3>
						<xsl:choose>
							<xsl:when test="function">
								<xsl:value-of select="function" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="job" />
								<xsl:text>, </xsl:text>
								<xsl:value-of select="employer" />
								<xsl:text>, </xsl:text>
								<xsl:value-of select="location" />
							</xsl:otherwise>
						</xsl:choose>
					</h3>
					<p class="important">
						<xsl:call-template name="date">
							<xsl:with-param name="date" select="start" />
						</xsl:call-template>
						<xsl:text> - </xsl:text>
						<xsl:call-template name="date">
							<xsl:with-param name="date" select="end" />
						</xsl:call-template>
					</p>
					<div>
						<xsl:copy-of select="description/node()" />
					</div>
				</article>
			</xsl:for-each>
		</article>
	</xsl:template>

	<xsl:template match="skills" mode="resume">
		<h2>
			<xsl:value-of select="@name" />
		</h2>
		<dl class="skills">
			<xsl:for-each select="skill">
				<dt>
					<xsl:value-of select="." />
				</dt>
				<dd>
					<div style="width: {@level div 0.05}%" />
				</dd>
			</xsl:for-each>
		</dl>
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

	<xsl:template name="date">
		<xsl:param name="date" select="/.." />
		<xsl:choose>
			<xsl:when test="$date">
				<xsl:if test="$date/@month">
					<xsl:value-of select="php:functionString('date', 'F', number(php:functionString('mktime', 0, 0, 0, number($date/@month), 10)))" />
					<xsl:text> </xsl:text>
				</xsl:if>
				<xsl:value-of select="$date/@year" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>present</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>