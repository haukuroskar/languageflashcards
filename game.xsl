<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="questions">
		<html>
			<head>
				<meta http-equiv="content-type" content="text/html; charset=utf-8" />
				<style type="text/css">
					h1 { text-align:center; }
					#wrapper 	{ width:900px; margin:0 auto; position:relative; }
					#total		{ position:absolute; top:0px; right:0px; padding:20px; background:green; border-radius:10px; }
					#reset		{ cursor:pointer; position:absolute; top:0px; left:0px; padding:20px; background:blue; border-radius:10px; }
					#scores 	{ text-align:center; margin-bottom:20px; font-size:30px;}
					#scores div	{ padding:20px; border-radius:10px; }
					.correct	{ background:green; display:inline-block; }
					.wrong		{ background:red; display:inline-block; }
					#vote div	{ cursor:pointer; display:inline-block; margin-right:20px; padding:20px; font-size:20px; }
					#stage .slide 	{ text-align:center;  } 
					#stage .slide .text { font-size:40px; margin-bottom:30px; }
					#vote { text-align:center; margin-top:80px; }
					#show-answer 	{ text-align:center; font-size:20px; margin-top:20px; }
					#show-answer span { display:inline-block; padding:20px; background:yellow; cursor:pointer; }
					#stage .slide .answer { font-size:30px; }
					#stage .slide.selected { display:block; }
					
					.hidden { display:none; }
				</style>
			</head>
			<body>
				<div id="wrapper">
					<div id="total"><span></span>%</div>
					<div id="reset">Reset</div>
					<h1><xsl:value-of select="appsettings/name" /></h1>
					<div id="scores">
						<div class="correct">
							
						</div>
						<div class="wrong">
							
						</div>
					</div>
					<div id="stage">
						<xsl:for-each select="question">
							<div class="slide hidden">
								<xsl:choose>
									<xsl:when test="images/image != ''">
										<div class="images">
											<xsl:for-each select="images/image">
												<img src="{.}" />
											</xsl:for-each>
										</div>
									</xsl:when>
									<xsl:otherwise>
										<div class="text">
											<xsl:value-of select="text" />
										</div>
									</xsl:otherwise>
								</xsl:choose>
								<div class="answer hidden">
									<xsl:value-of select="answer" />
								</div>					
							</div>
						</xsl:for-each>			
						
					</div>
					<div id="show-answer"><span>Show answer!</span></div>
					<div id="vote" class="hidden">
						<div class="correct">
							I was right
						</div>
						<div class="wrong">
							I was wrong
						</div>				
					</div>
				</div>
				<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
				<script type="text/javascript">
										/**
					 * jQuery Shuffle (http://mktgdept.com/jquery-shuffle)
					 * A jQuery plugin for shuffling a set of elements
					 *
					 * v0.0.1 - 13 November 2009
					 *
					 * Copyright (c) 2009 Chad Smith (http://twitter.com/chadsmith)
					 * Dual licensed under the MIT and GPL licenses.
					 * http://www.opensource.org/licenses/mit-license.php
					 * http://www.opensource.org/licenses/gpl-license.php
					 *
					 * Shuffle elements using: $(selector).shuffle() or $.shuffle(selector)
					 *
					 **/
					(function(d){d.fn.shuffle=function(c){c=[];return this.each(function(){c.push(d(this).clone(true))}).each(function(a,b){d(b).replaceWith(c[a=Math.floor(Math.random()*c.length)]);c.splice(a,1)})};d.shuffle=function(a){return d(a).shuffle()}})(jQuery);
				</script>
				<script type="text/javascript">
					$(document).ready(function() {
						initGame();	
					});

					function initGame() {
						clickEvents();
						resetGame();
					}
					
					
					function resetGame() {
						//reset scores
						$("#scores .correct").text("0");
						$("#scores .wrong").text("0");
						//randomize slides
						$("#stage .slide").shuffle();
						$("#stage .slide").removeClass("selected");
						//show first slide
						$("#stage .slide:first").addClass("selected");
					}

					
					function clickEvents() {
						//When next slide 
						//When right or wrong
						$("#show-answer span").click(function() {
							$(this).parent().hide();
							$("#stage .slide .answer").show();
							$("#vote").show();
						});
						$("#vote div").click(function() {
							$(this).parent().hide();
							$("#stage .slide .answer").hide();
							$("#show-answer").show();	
							var correctScore = parseInt($("#scores .correct").text());
							var wrongScore = parseInt($("#scores .wrong").text())
							if($(this).hasClass("correct")) {
								correctScore = correctScore + 1;
								$("#scores .correct").text(correctScore);
							} else {
								wrongScore = wrongScore + 1;		
								$("#scores .wrong").text(wrongScore);						
							}
							$("#total span").text((correctScore / (correctScore+wrongScore)).toFixed(2)*100);
							changeSlide();
						});
						$("#reset").click(function() {
							resetGame();
						});						
						
					}
					
					function randomizeSlides() {
					}
					
					function changeSlide() {
						var currSlide = $("#stage .slide.selected");
						currSlide.removeClass("selected");
						if (currSlide.next().length == 0) {
							$("#stage .slide:first").addClass("selected");
						} else {
							currSlide.next().addClass("selected");
						}
					}
					
					function randomizePhoto() {
					}

					function updateScore(guessResult) {
						//guess is true or false
						//update either wrong or right class
						//changeSlide
					}

				</script>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
