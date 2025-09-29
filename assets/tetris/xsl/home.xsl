<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="*">
		<div>
			<script type="application/javascript"><![CDATA[
function startGame(parentNode) {
	var game = new Tetris.Game();
	game.init(parentNode);
	game.dom.frame.focus();
	if (parentNode.lastChild.previousSibling) {
		parentNode.removeChild(parentNode.firstChild);
	}
}
			]]></script>
			<button type="button" onclick="startGame(this.parentNode.lastChild);">
				<code>Start Game</code>
			</button>
			<div id="Tetris" />
		</div>
	</xsl:template>
</xsl:stylesheet>