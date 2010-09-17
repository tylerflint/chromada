
function setCookie($name, $value, $path, $secure, $expires, $domain)
{
	document.cookie = $name + "=" + escape($value) +
       ((!$expires) ? "" : ("; expires=" + $expires.toGMTString())) +
       ((!$path) ? "; path=/" : ("; path=" + $path)) +
       ((!$domain) ? "" : ("; domain=" + $domain)) +
       (($secure === true /*|| SSL*/) ? "; secure" : "");
} 
 
function loadScript($url) 
{
    var el = $("body").first()
    if (el) {
        script = document.createElement("script");
        script.type = "text/javascript";
        script.src = $url + "?" + parseInt(Math.random() * 1000000000);
        el.append(script);
    }
}

// http://www.themaninblue.com/writing/perspective/2005/08/29/
function footerPush (bodyElement)
{
    /* Title:       Footer Push v3.01
     * Modified:    October 16th, 2008
     *
     * Description: This function will push page's footer down to the bottom of the browser 
     *              on pages where content does not fill the page.  This prevents the footer 
     *              from 'floating' in the middle of the page.  Requires jQuery 1.2.6
     *              
     *              bodyElement = ID of element you want to extend to full length of the page.
     *
     * Tested on:   Microsoft IE v6.0.2900.5512.xpsp.080413-2111 w/ SP3
     *              Mozilla's Firefox v3.0.3 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3)
     *              Apple's Safari Windows v3.1.2 (525.21)
     *              Opera v9.60 Build 10447 (Opera/9.60 (Windows NT 5.1; U; en) Presto/2.1.1)
     *              Google's Chrome v0.2.149.30 (Official Build 2200 Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.30 Safari/525.13)
     *
     * NOT TESTED:  Microsoft IE 7
     *              Microsoft IE 8 beta 2
     *              Apple's Safari Mac 
     *
     * Notes:       jQuery 1.2.6 identifies Google's Chrome browser as Safari. This footer push currently works for both
     *              Firefox *may* render the footer too short/long -- unable to pinpoint.  When doing a hard refresh (Shift + Refresh) in Firefox, the footer is sometimes pushed down too far.
     *              Opera requires a different method to determine browser/viewport height
     *
     * Resources:   jQuery Browser Detection: http://docs.jquery.com/Utilities/jQuery.browser
     *              Browser detection for Google's Chrome: http://javascriptly.com/2008/09/javascript-to-detect-google-chrome/
     *              Opera/IE unique way of finding viewport size: http://andylangton.co.uk/articles/javascript/get-viewport-size-javascript/
     *
     *Todo:         Hide / minimize the footer 'jump' effect
     *              Test on more current IE browsers
     */
	
	/*
    if ( $(window).height() > $(document.body).height() ) {
        if ( $.browser.msie ) {             //If Microsoft's IE
            $(bodyElement).height( $(bodyElement).height() + ( $(window).height() - $(document.body).height()) - 0);
        } else if ($.browser.mozilla) {     //If Mozilla's Firefox
            $(bodyElement).height( $(bodyElement).height() + ( $(window).height() - $(document.body).height()) - 0);
        } else if ($.browser.safari) {      //If Apple's Safari *or* Google's Chrome
            $(bodyElement).height( $(bodyElement).height() + ( $(window).height() - $(document.body).height()) - 0);
        } else {                            //Any other browser, default to 'standard' implementation
            $(bodyElement).height( $(bodyElement).height() + ( $(window).height() - $(document.body).height()) - 0);
        };
    };
    if ( $.browser.opera ) {     //If Opera
        if ( window.innerHeight > $(document.body).height() ) {
            $(bodyElement).height( $(bodyElement).height() + ( window.innerHeight - $(document.body).height()) - 0 );
        };
    };
	*/
};

//window.onresize = footerPush("#bd");
//window.onload = footerPush("#bd");
