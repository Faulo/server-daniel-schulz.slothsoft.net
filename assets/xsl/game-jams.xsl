<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:sfs="http://schema.slothsoft.net/farah/sitemap" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sfd="http://schema.slothsoft.net/farah/dictionary" xmlns:ssp="http://schema.slothsoft.net/schema/presskit"
    xmlns:sfm="http://schema.slothsoft.net/farah/module">

    <xsl:template match="/*">
        <xsl:variable name="requestedPage" select="*[@name='sites']//*[@current]" />
        <div>
            <h1 sfd:dict="">
                <xsl:value-of select="$requestedPage/@title" />
            </h1>

            <article>
                <h2>About</h2>
                <p>This is a catalog of every game jam game I've ever worked on.
                    It includes some screenshots, the game jam that inspired them, and the people that were involved in their creation.
                    It's become quite
                    a list.
                </p>
                <p>
                    <xsl:text>Most of these link to </xsl:text>
                    <a href="https://faulo.itch.io/" rel="external" target="_blank">my itch.io profile</a>
                    <xsl:text> (or someone else's), where they can be played, too.</xsl:text>
                </p>
            </article>

            <article class="collab">
                <h2>Collaborateurs</h2>
                <p>
                    I could not have made these games on my own.
                    Other than the games that I did make on my own.
                    Point is, I'm grateful for all the cool peeps that helped me along the way, and I want to make sure
                    their contributions are not forgotten.
                </p>
                <p>
                    <xsl:text>If you find yourself listed in the credits of one of these games and would like me to update the URL to your portfolio (or equivalent), let me know. My Discord tag is: </xsl:text>
                    <code>faulolio</code>
                </p>
                <p>Just for fun, here are my most frequent collaborateurs: (Thanks, Kadda ♥)</p>
                <dl class="tabled-list">
                    <xsl:for-each select="//ssp:person[not(. = following::ssp:person)]">
                        <xsl:sort select="count(//ssp:person[. = current()])" order="descending" data-type="number" />
                        <xsl:sort select="." />
                        <xsl:variable name="count" select="count(//ssp:person[. = current()])" />
                        <xsl:if test=". != 'Daniel Schulz' and $count &gt; 1">
                            <dt>
                                <sfd:lookup key="{.}" />
                                <xsl:text> with these </xsl:text>
                                <xsl:value-of select="$count" />
                                <xsl:text> games:</xsl:text>
                            </dt>
                            <xsl:for-each select="//ssp:game[.//ssp:person = current()]">
                                <dd>
                                    <a href="{../../../@name}/">
                                        <xsl:value-of select="ssp:title" />
                                    </a>
                                </dd>
                            </xsl:for-each>
                        </xsl:if>
                    </xsl:for-each>
                </dl>
            </article>
        </div>
    </xsl:template>
</xsl:stylesheet>
