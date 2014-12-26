function GM_bootstrap(GM) {

  GM.remote.urlNoProtocol = "//"+GM.remote.domain+GM.remote.suffix;
  GM.remote.url           = "http:"+GM.remote.urlNoProtocol;
  GM.remote.stylesheet    = GM.remote.url + "/" + GM.name.system + ".css";
  GM.remote.script        = GM.remote.url + "/" + GM.name.system + ".js";

  var div = document.createElement("div");

  div.id = "GM_load_block";

  var css = {
    "position": "fixed",
    "top": "0px",
    "right": "0px",
    "bottom": "0px",
    "left": "0px",
    "background": "#ffffff",
    "z-index": "999999"
  };

  for (var prop in css) {
    div.style[prop] = css[prop];
  }

  document.getElementsByTagName("html")[0].appendChild(div);

  //console.log(GM_info);
  //var GM_script_name = 
  //unsafeWindow.GM_script_name = "

  (function GM_initializeWhenjQueryReady() { 
    if (unsafeWindow.$){
      
      $(document).ready(function() {
        
        // Inject Script
        var s = document.createElement("script");
        
        s.type = "text/javascript";
        s.src  = GM.remote.script;
        
        $("head").append(s);
        
        // Inject Stylesheet
        $("head").append("<link rel=\"stylesheet\" href=\""+ GM.remote.stylesheet + "\" type=\"text/css\" />");

        GM_main()
        GM_post()
        
      });
      
      return true;
    }
    
    setTimeout(GM_initializeWhenjQueryReady, 1);
  })();

  return GM;
}

