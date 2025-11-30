<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:sfs="http://schema.slothsoft.net/farah/sitemap" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sfm="http://schema.slothsoft.net/farah/module" xmlns:ssp="http://schema.slothsoft.net/schema/presskit" xmlns:sfd="http://schema.slothsoft.net/farah/dictionary">

    <xsl:import href="farah://slothsoft@schema/xsl/presskit.functions" />

    <xsl:template match="/*">
        <xsl:variable name="requestedPage" select="*[@name='sites']//*[@current]" />
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <title>
                    <xsl:value-of select="$requestedPage/@title" />
                    <xsl:text> | Daniel Schulz</xsl:text>
                </title>
                <link rel="icon" type="image/png" href="/favicon.ico" />
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <meta name="author" content="Daniel Schulz" />
            </head>
            <body>
                <div class="page">
                    <nav>
                        <!-- <h2 class="hidden">Navigation</h2> -->
                        <xsl:copy-of select="*[@name='navi']/node()" />
                    </nav>
                    <main>
                        <xsl:variable name="documentURI" select="sfm:param[@name = 'document']/@value" />
                        <xsl:variable name="content" select="sfm:document-info[@name='content']" />

                        <xsl:choose>
                            <xsl:when test="$documentURI">
                                <xsl:apply-templates select="document($documentURI)" mode="content">
                                    <xsl:with-param name="header" select="*[@name='images']//sfm:manifest-info[@name = $requestedPage/@name]" />
                                    <xsl:with-param name="images" select="*[@name='images']//sfm:manifest-info[starts-with(@name, concat($requestedPage/@name, '.'))]" />
                                    <xsl:with-param name="downloads" select="*[@name='downloads']//sfm:manifest-info[starts-with(@name, $requestedPage/@name)]" />
                                    <xsl:with-param name="videos" select="*[@name='videos']//sfm:manifest-info[starts-with(@name, $requestedPage/@name)]" />
                                </xsl:apply-templates>
                            </xsl:when>
                            <xsl:when test="$content">
                                <xsl:copy-of select="$content/*/node()" />
                            </xsl:when>
                            <xsl:otherwise>
                                <h1 sfd:dict="">
                                    <xsl:value-of select="$requestedPage/@title" />
                                </h1>
                                <div sfd:dict=".">
                                    <xsl:value-of select="$requestedPage/@name" />
                                    <xsl:text>.content</xsl:text>
                                </div>
                            </xsl:otherwise>
                        </xsl:choose>
                    </main>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="ssp:jam" mode="content">
        <xsl:param name="header" select="/.." />
        <xsl:param name="images" select="/.." />
        <xsl:param name="videos" select="/.." />
        <xsl:param name="downloads" select="/.." />

        <xsl:variable name="jam" select="." />
        <xsl:variable name="game" select=".//ssp:game" />

        <h1>
            <xsl:value-of select="$jam/ssp:title" />
            <xsl:text>: </xsl:text>
            <xsl:value-of select="$game/ssp:title" />
        </h1>

        <xsl:for-each select="$header">
            <figure>
                <img src="{@href}" alt="{@name}" />
            </figure>
        </xsl:for-each>

        <xsl:for-each select="$game/ssp:description">
            <article class="about">
                <h2>About</h2>
                <p>
                    <xsl:copy-of select="node()" />
                </p>
            </article>
        </xsl:for-each>

        <article class="jam">
            <h2>Jam Details</h2>
            <p>
                <xsl:call-template name="ssp:link">
                    <xsl:with-param name="link" select="$jam/ssp:website" />
                    <xsl:with-param name="name" select="$jam/ssp:title" />
                    <xsl:with-param name="rel" select="'external'" />
                </xsl:call-template>
            </p>
            <dl class="tabled-list">
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
                <xsl:for-each select="$jam/ssp:theme">
                    <dd>
                        <xsl:choose>
                            <xsl:when test="*">
                                <xsl:copy-of select="node()" />
                            </xsl:when>
                            <xsl:when test="@xml:lang and @xml:lang != 'en-us'">
                                <q lang="{@xml:lang}">
                                    <xsl:value-of select="." />
                                </q>
                                <xsl:text> </xsl:text>
                                <span>
                                    <xsl:text>[</xsl:text>
                                    <q sfd:dict=".">
                                        <xsl:value-of select="." />
                                    </q>
                                    <xsl:text>]</xsl:text>
                                </span>
                            </xsl:when>
                            <xsl:otherwise>
                                <q>
                                    <xsl:value-of select="." />
                                </q>
                            </xsl:otherwise>
                        </xsl:choose>
                    </dd>
                </xsl:for-each>
            </dl>
        </article>

        <xsl:for-each select="$game/ssp:credits">
            <article class="credits">
                <h2>Credits</h2>
                <dl class="tabled-list">
                    <xsl:for-each select="ssp:credit">
                        <xsl:sort select="ssp:person" />
                        <dt sfd:dict="">
                            <xsl:call-template name="ssp:link">
                                <xsl:with-param name="link" select="ssp:website" />
                                <xsl:with-param name="name" select="ssp:person" />
                                <xsl:with-param name="rel" select="'external'" />
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

        <xsl:if test="$game/ssp:trailers | $videos">
            <article class="videos">
                <h2>Videos</h2>
                <xsl:for-each select="$game/ssp:trailers/ssp:trailer">
                    <figure>
                        <iframe width="800" height="450" src="https://www.youtube.com/embed/{ssp:youtube}" title="YouTube video player" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="allowfullscreen" />
                        <figcaption>
                            <xsl:value-of select="ssp:name" />
                        </figcaption>
                    </figure>
                </xsl:for-each>
                <xsl:for-each select="$videos">
                    <figure>
                        <video width="800" height="450" controls="controls">
                            <source src="{@href}" type="video/mp4" />
                        </video>
                        <figcaption sfd:dict="">
                            <xsl:value-of select="@name" />
                        </figcaption>
                    </figure>
                </xsl:for-each>
            </article>
        </xsl:if>

        <xsl:if test="$images">
            <article class="screenshots">
                <h2>Screenshots</h2>
                <xsl:for-each select="$images">
                    <figure>
                        <img src="{@href}" alt="{@name}" />
                        <figcaption sfd:dict="">
                            <xsl:value-of select="@name" />
                        </figcaption>
                    </figure>
                </xsl:for-each>
            </article>
        </xsl:if>

        <xsl:for-each select="$game/ssp:additionals">
            <article class="links">
                <h2>Links</h2>
                <ul>
                    <xsl:for-each select="ssp:additional">
                        <li>
                            <xsl:call-template name="ssp:link">
                                <xsl:with-param name="link" select="ssp:link" />
                                <xsl:with-param name="name" select="ssp:title" />
                                <xsl:with-param name="rel" select="'external'" />
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

        <xsl:if test="$downloads">
            <article class="downloads">
                <h2>Downloads</h2>
                <ul>
                    <xsl:for-each select="$downloads">
                        <li>
                            <xsl:call-template name="ssp:link">
                                <xsl:with-param name="link" select="@href" />
                                <xsl:with-param name="name" select="concat(@name, '.zip')" />
                                <xsl:with-param name="rel" select="'me'" />
                            </xsl:call-template>
                        </li>
                    </xsl:for-each>
                </ul>
            </article>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>