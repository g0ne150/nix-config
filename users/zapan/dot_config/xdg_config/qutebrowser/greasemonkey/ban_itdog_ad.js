// ==UserScript==
// @name         Ban ITDOG ads
// @namespace    http://tampermonkey.net/
// @version      2025-01-10
// @description  Ban itdog.cn ads
// @author       You
// @match        *://*.itdog.cn/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

(function () {
  "use strict";
  $(".gg_link").remove();
})();
