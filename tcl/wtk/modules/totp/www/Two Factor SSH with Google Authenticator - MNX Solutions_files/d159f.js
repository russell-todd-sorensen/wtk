function q2w3_sidebar_init(){for(var e=0;e<q2w3_sidebar_options.length;e++)q2w3_sidebar(q2w3_sidebar_options[e]);jQuery(window).on("resize",function(){for(var e=0;e<q2w3_sidebar_options.length;e++)q2w3_sidebar(q2w3_sidebar_options[e])});var i=function(){for(var e=["WebKit","Moz","O","Ms",""],i=0;i<e.length;i++)if(e[i]+"MutationObserver"in window)return window[e[i]+"MutationObserver"];return!1}();0==q2w3_sidebar_options[0].disable_mo_api&&i?(q2w3Refresh=!1,new i(function(e){e.forEach(function(e){-1!=q2w3_exclude_mutations_array(q2w3_sidebar_options).indexOf(e.target.id)||e.target.className&&"function"==typeof e.target.className.indexOf&&-1!=e.target.className.indexOf("q2w3-fixed-widget-container")||(q2w3Refresh=!0)})}).observe(document.body,{childList:!0,attributes:!0,attributeFilter:["style","class"],subtree:!0}),setInterval(function(){if(q2w3Refresh){for(var e=0;e<q2w3_sidebar_options.length;e++)q2w3_sidebar(q2w3_sidebar_options[e]);q2w3Refresh=!1}},300)):(console.log("MutationObserver not supported or disabled!"),q2w3_sidebar_options[0].refresh_interval>0&&setInterval(function(){for(var e=0;e<q2w3_sidebar_options.length;e++)q2w3_sidebar(q2w3_sidebar_options[e])},q2w3_sidebar_options[0].refresh_interval))}function q2w3_exclude_mutations_array(e){for(var i=new Array,o=0;o<e.length;o++)if(e[o].widgets.length>0)for(var t=0;t<e[o].widgets.length;t++)i.push(e[o].widgets[t]),i.push(e[o].widgets[t]+"_clone");return i}function q2w3_sidebar(e){if(!e)return!1;if(!e.widgets)return!1;if(e.widgets.length<1)return!1;function i(){}e.sidebar||(e.sidebar="q2w3-default-sidebar");var o=new Array,t=jQuery(window).height(),n=jQuery(document).height(),r=e.margin_top;jQuery("#wpadminbar").length&&(r=e.margin_top+jQuery("#wpadminbar").height()),jQuery(".q2w3-widget-clone-"+e.sidebar).remove();for(var s=0;s<e.widgets.length;s++)widget_obj=jQuery("#"+e.widgets[s]),widget_obj.css("position",""),widget_obj.attr("id")?(o[s]=new i,o[s].obj=widget_obj,o[s].clone=widget_obj.clone(),o[s].clone.children().remove(),o[s].clone_id=widget_obj.attr("id")+"_clone",o[s].clone.addClass("q2w3-widget-clone-"+e.sidebar),o[s].clone.attr("id",o[s].clone_id),o[s].clone.css("height",widget_obj.height()),o[s].clone.css("visibility","hidden"),o[s].offset_top=widget_obj.offset().top,o[s].fixed_margin_top=r,o[s].height=widget_obj.outerHeight(!0),o[s].fixed_margin_bottom=r+o[s].height,r+=o[s].height):o[s]=!1;var d,a=0;for(s=o.length-1;s>=0;s--)o[s]&&(o[s].next_widgets_height=a,o[s].fixed_margin_bottom+=a,a+=o[s].height,d||((d=widget_obj.parent()).addClass("q2w3-fixed-widget-container"),d.css("height",""),d.height(d.height())));jQuery(window).off("scroll."+e.sidebar);for(s=0;s<o.length;s++)o[s]&&_(o[s]);function _(i){var o,r=i.offset_top-i.fixed_margin_top,s=n-e.margin_bottom;e.stop_id&&jQuery("#"+e.stop_id).length&&(s=jQuery("#"+e.stop_id).offset().top-e.margin_bottom),o=e.width_inherit?"inherit":i.obj.css("width");var d=!1,a=!1,_=!1;jQuery(window).on("scroll."+e.sidebar,function(n){if(jQuery(window).width()<=e.screen_max_width||jQuery(window).height()<=e.screen_max_height)_||(i.obj.css("position",""),i.obj.css("top",""),i.obj.css("bottom",""),i.obj.css("width",""),i.obj.css("margin",""),i.obj.css("padding",""),widget_obj.parent().css("height",""),jQuery("#"+i.clone_id).length>0&&jQuery("#"+i.clone_id).remove(),_=!0,d=!1,a=!1);else{var w=jQuery(this).scrollTop();w+i.fixed_margin_bottom>=s?(a||(i.obj.css("position","fixed"),i.obj.css("top",""),i.obj.css("width",o),jQuery("#"+i.clone_id).length<=0&&i.obj.before(i.clone),a=!0,d=!1,_=!1),i.obj.css("bottom",w+t+i.next_widgets_height-s)):w>=r?d||(i.obj.css("position","fixed"),i.obj.css("top",i.fixed_margin_top),i.obj.css("bottom",""),i.obj.css("width",o),jQuery("#"+i.clone_id).length<=0&&i.obj.before(i.clone),d=!0,a=!1,_=!1):_||(i.obj.css("position",""),i.obj.css("top",""),i.obj.css("bottom",""),i.obj.css("width",""),jQuery("#"+i.clone_id).length>0&&jQuery("#"+i.clone_id).remove(),_=!0,d=!1,a=!1)}}).trigger("scroll."+e.sidebar)}}"undefined"!=typeof q2w3_sidebar_options&&q2w3_sidebar_options.length>0?window.jQuery?q2w3_sidebar_options[0].window_load_hook?jQuery(window).load(q2w3_sidebar_init):"loading"!=document.readyState?q2w3_sidebar_init():document.addEventListener("DOMContentLoaded",q2w3_sidebar_init):console.log("jQuery is not loaded!"):console.log("q2w3_sidebar_options not found!");
;jQuery(document).ready(function($){var animationDelay=2500,barAnimationDelay=3800,barWaiting=barAnimationDelay-3000,lettersDelay=50,typeLettersDelay=150,selectionDuration=500,typeAnimationDelay=selectionDuration+800,revealDuration=600,revealAnimationDelay=1500;initHeadline();function initHeadline(){singleLetters($('.cd-headline.letters').find('b'));animateHeadline($('.cd-headline'));}
function singleLetters($words){$words.each(function(){var word=$(this),letters=word.text().split(''),selected=word.hasClass('is-visible');for(i in letters){if(word.parents('.rotate-2').length>0)letters[i]='<em>'+letters[i]+'</em>';letters[i]=(selected)?'<i class="in">'+letters[i]+'</i>':'<i>'+letters[i]+'</i>';}
var newLetters=letters.join('');word.html(newLetters).css('opacity',1);});}
function animateHeadline($headlines){var duration=animationDelay;$headlines.each(function(){var headline=$(this);if(headline.hasClass('loading-bar')){duration=barAnimationDelay;setTimeout(function(){headline.find('.cd-words-wrapper').addClass('is-loading')},barWaiting);}else if(headline.hasClass('clip')){var spanWrapper=headline.find('.cd-words-wrapper'),newWidth=spanWrapper.width()+10
spanWrapper.css('width',newWidth);}else if(!headline.hasClass('type')){var words=headline.find('.cd-words-wrapper b'),width=0;words.each(function(){var wordWidth=$(this).width();if(wordWidth>width)width=wordWidth;});headline.find('.cd-words-wrapper').css('width',width);};setTimeout(function(){hideWord(headline.find('.is-visible').eq(0))},duration);});}
function hideWord($word){var nextWord=takeNext($word);if($word.parents('.cd-headline').hasClass('type')){var parentSpan=$word.parent('.cd-words-wrapper');parentSpan.addClass('selected').removeClass('waiting');setTimeout(function(){parentSpan.removeClass('selected');$word.removeClass('is-visible').addClass('is-hidden').children('i').removeClass('in').addClass('out');},selectionDuration);setTimeout(function(){showWord(nextWord,typeLettersDelay)},typeAnimationDelay);}else if($word.parents('.cd-headline').hasClass('letters')){var bool=($word.children('i').length>=nextWord.children('i').length)?true:false;hideLetter($word.find('i').eq(0),$word,bool,lettersDelay);showLetter(nextWord.find('i').eq(0),nextWord,bool,lettersDelay);}else if($word.parents('.cd-headline').hasClass('clip')){$word.parents('.cd-words-wrapper').animate({width:'2px'},revealDuration,function(){switchWord($word,nextWord);showWord(nextWord);});}else if($word.parents('.cd-headline').hasClass('loading-bar')){$word.parents('.cd-words-wrapper').removeClass('is-loading');switchWord($word,nextWord);setTimeout(function(){hideWord(nextWord)},barAnimationDelay);setTimeout(function(){$word.parents('.cd-words-wrapper').addClass('is-loading')},barWaiting);}else{switchWord($word,nextWord);setTimeout(function(){hideWord(nextWord)},animationDelay);}}
function showWord($word,$duration){if($word.parents('.cd-headline').hasClass('type')){showLetter($word.find('i').eq(0),$word,false,$duration);$word.addClass('is-visible').removeClass('is-hidden');}else if($word.parents('.cd-headline').hasClass('clip')){$word.parents('.cd-words-wrapper').animate({'width':$word.width()+10},revealDuration,function(){setTimeout(function(){hideWord($word)},revealAnimationDelay);});}}
function hideLetter($letter,$word,$bool,$duration){$letter.removeClass('in').addClass('out');if(!$letter.is(':last-child')){setTimeout(function(){hideLetter($letter.next(),$word,$bool,$duration);},$duration);}else if($bool){setTimeout(function(){hideWord(takeNext($word))},animationDelay);}
if($letter.is(':last-child')&&$('html').hasClass('no-csstransitions')){var nextWord=takeNext($word);switchWord($word,nextWord);}}
function showLetter($letter,$word,$bool,$duration){$letter.addClass('in').removeClass('out');if(!$letter.is(':last-child')){setTimeout(function(){showLetter($letter.next(),$word,$bool,$duration);},$duration);}else{if($word.parents('.cd-headline').hasClass('type')){setTimeout(function(){$word.parents('.cd-words-wrapper').addClass('waiting');},200);}
if(!$bool){setTimeout(function(){hideWord($word)},animationDelay)}}}
function takeNext($word){return(!$word.is(':last-child'))?$word.next():$word.parent().children().eq(0);}
function takePrev($word){return(!$word.is(':first-child'))?$word.prev():$word.parent().children().last();}
function switchWord($oldWord,$newWord){$oldWord.removeClass('is-visible').addClass('is-hidden');$newWord.removeClass('is-hidden').addClass('is-visible');}});
;!function(c,d){"use strict";var e=!1,n=!1;if(d.querySelector)if(c.addEventListener)e=!0;if(c.wp=c.wp||{},!c.wp.receiveEmbedMessage)if(c.wp.receiveEmbedMessage=function(e){var t=e.data;if(t)if(t.secret||t.message||t.value)if(!/[^a-zA-Z0-9]/.test(t.secret)){for(var r,a,i,s=d.querySelectorAll('iframe[data-secret="'+t.secret+'"]'),n=d.querySelectorAll('blockquote[data-secret="'+t.secret+'"]'),o=0;o<n.length;o++)n[o].style.display="none";for(o=0;o<s.length;o++)if(r=s[o],e.source===r.contentWindow){if(r.removeAttribute("style"),"height"===t.message){if(1e3<(i=parseInt(t.value,10)))i=1e3;else if(~~i<200)i=200;r.height=i}if("link"===t.message)if(a=d.createElement("a"),i=d.createElement("a"),a.href=r.getAttribute("src"),i.href=t.value,i.host===a.host)if(d.activeElement===r)c.top.location.href=t.value}}},e)c.addEventListener("message",c.wp.receiveEmbedMessage,!1),d.addEventListener("DOMContentLoaded",t,!1),c.addEventListener("load",t,!1);function t(){if(!n){n=!0;for(var e,t,r=-1!==navigator.appVersion.indexOf("MSIE 10"),a=!!navigator.userAgent.match(/Trident.*rv:11\./),i=d.querySelectorAll("iframe.wp-embedded-content"),s=0;s<i.length;s++){if(!(e=i[s]).getAttribute("data-secret"))t=Math.random().toString(36).substr(2,10),e.src+="#?secret="+t,e.setAttribute("data-secret",t);if(r||a)(t=e.cloneNode(!0)).removeAttribute("security"),e.parentNode.replaceChild(t,e)}}}}(window,document);