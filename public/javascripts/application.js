
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