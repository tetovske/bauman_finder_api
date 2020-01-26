/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/demo/css/style.css");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/demo/css/style.css":
/*!*************************************************!*\
  !*** ./app/javascript/packs/demo/css/style.css ***!
  \*************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var content = __webpack_require__(/*! !../../../../../node_modules/css-loader/dist/cjs.js??ref--6-1!../../../../../node_modules/postcss-loader/src??ref--6-2!./style.css */ "./node_modules/css-loader/dist/cjs.js?!./node_modules/postcss-loader/src/index.js?!./app/javascript/packs/demo/css/style.css");

if (typeof content === 'string') {
  content = [[module.i, content, '']];
}

var options = {}

options.insert = "head";
options.singleton = false;

var update = __webpack_require__(/*! ../../../../../node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js */ "./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js")(content, options);

if (content.locals) {
  module.exports = content.locals;
}


/***/ }),

/***/ "./node_modules/css-loader/dist/cjs.js?!./node_modules/postcss-loader/src/index.js?!./app/javascript/packs/demo/css/style.css":
/*!*********************************************************************************************************************************************!*\
  !*** ./node_modules/css-loader/dist/cjs.js??ref--6-1!./node_modules/postcss-loader/src??ref--6-2!./app/javascript/packs/demo/css/style.css ***!
  \*********************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

exports = module.exports = __webpack_require__(/*! ../../../../../node_modules/css-loader/dist/runtime/api.js */ "./node_modules/css-loader/dist/runtime/api.js")(true);
// Module
exports.push([module.i, "/* =============================================================================\n   HTML5 CSS Reset Minified - Eric Meyer\n   ========================================================================== */\n\nhtml,body,div,span,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,abbr,address,cite,code,del,dfn,em,img,ins,kbd,q,samp,small,strong,sub,sup,var,b,i,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,figcaption,figure,footer,header,hgroup,menu,nav,section,summary,time,mark,audio,video{margin:0;padding:0;border:0;outline:0;font-size:100%;vertical-align:baseline;background:transparent}\n\nbody{line-height:1}\n\narticle,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section{display:block}\n\nnav ul{list-style:none}\n\nblockquote,q{quotes:none}\n\nblockquote:before,blockquote:after,q:before,q:after{content:none}\n\na{margin:0;padding:0;font-size:100%;vertical-align:baseline;background:transparent;text-decoration:none}\n\nmark{background-color:#ff9;color:#000;font-style:italic;font-weight:bold}\n\ndel{text-decoration:line-through}\n\nabbr[title],dfn[title]{border-bottom:1px dotted;cursor:help}\n\ntable{border-collapse:collapse;border-spacing:0}\n\nhr{display:block;height:1px;border:0;border-top:1px solid #ccc;margin:1em 0;padding:0}\n\ninput,select{vertical-align:middle}\n\nli{list-style:none}\n\n/* =============================================================================\n   My CSS\n   ========================================================================== */\n\n/* ---- base ---- */\n\nhtml,body{ \n\twidth:100%;\n\theight:100%;\n\tbackground:#111;\n}\n\nhtml{\n  -webkit-tap-highlight-color: rgba(0, 0, 0, 0);\n}\n\nbody{\n  font:normal 75% Arial, Helvetica, sans-serif;\n}\n\ncanvas{\n  display:block;\n  vertical-align:bottom;\n}\n\n/* ---- stats.js ---- */\n\n.count-particles{\n  background: #000022;\n  position: absolute;\n  top: 48px;\n  left: 0;\n  width: 80px;\n  color: #13E8E9;\n  font-size: .8em;\n  text-align: left;\n  text-indent: 4px;\n  line-height: 14px;\n  padding-bottom: 2px;\n  font-family: Helvetica, Arial, sans-serif;\n  font-weight: bold;\n}\n\n.js-count-particles{\n  font-size: 1.1em;\n}\n\n#stats,\n.count-particles{\n  -webkit-user-select: none;\n  margin-top: 5px;\n  margin-left: 5px;\n}\n\n#stats{\n  border-radius: 3px 3px 0 0;\n  overflow: hidden;\n}\n\n.count-particles{\n  border-radius: 0 0 3px 3px;\n}\n\n/* ---- particles.js container ---- */\n\n#particles-js{\n  width: 100%;\n  height: 100%;\n  background-color: #b61924;\n  background-image: url('');\n  background-size: cover;\n  background-position: 50% 50%;\n  background-repeat: no-repeat;\n}\n", "",{"version":3,"sources":["style.css"],"names":[],"mappings":"AAAA;;+EAE+E;;AAE/E,+VAA+V,QAAQ,CAAC,SAAS,CAAC,QAAQ,CAAC,SAAS,CAAC,cAAc,CAAC,uBAAuB,CAAC,sBAAsB;;AAClc,KAAK,aAAa;;AAClB,8EAA8E,aAAa;;AAC3F,OAAO,eAAe;;AACtB,aAAa,WAAW;;AACxB,oDAAoD,YAAY;;AAChE,EAAE,QAAQ,CAAC,SAAS,CAAC,cAAc,CAAC,uBAAuB,CAAC,sBAAsB,CAAC,oBAAoB;;AACvG,KAAK,qBAAqB,CAAC,UAAU,CAAC,iBAAiB,CAAC,gBAAgB;;AACxE,IAAI,4BAA4B;;AAChC,uBAAuB,wBAAwB,CAAC,WAAW;;AAC3D,MAAM,wBAAwB,CAAC,gBAAgB;;AAC/C,GAAG,aAAa,CAAC,UAAU,CAAC,QAAQ,CAAC,yBAAyB,CAAC,YAAY,CAAC,SAAS;;AACrF,aAAa,qBAAqB;;AAClC,GAAG,eAAe;;AAGlB;;+EAE+E;;AAE/E,mBAAmB;;AAEnB;CACC,UAAU;CACV,WAAW;CACX,eAAe;AAChB;;AAEA;EACE,6CAA6C;AAC/C;;AAEA;EACE,4CAA4C;AAC9C;;AAEA;EACE,aAAa;EACb,qBAAqB;AACvB;;AAGA,uBAAuB;;AAEvB;EACE,mBAAmB;EACnB,kBAAkB;EAClB,SAAS;EACT,OAAO;EACP,WAAW;EACX,cAAc;EACd,eAAe;EACf,gBAAgB;EAChB,gBAAgB;EAChB,iBAAiB;EACjB,mBAAmB;EACnB,yCAAyC;EACzC,iBAAiB;AACnB;;AAEA;EACE,gBAAgB;AAClB;;AAEA;;EAEE,yBAAyB;EACzB,eAAe;EACf,gBAAgB;AAClB;;AAEA;EACE,0BAA0B;EAC1B,gBAAgB;AAClB;;AAEA;EACE,0BAA0B;AAC5B;;AAGA,qCAAqC;;AAErC;EACE,WAAW;EACX,YAAY;EACZ,yBAAyB;EACzB,yBAAyB;EACzB,sBAAsB;EACtB,4BAA4B;EAC5B,4BAA4B;AAC9B","file":"style.css","sourcesContent":["/* =============================================================================\n   HTML5 CSS Reset Minified - Eric Meyer\n   ========================================================================== */\n\nhtml,body,div,span,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,abbr,address,cite,code,del,dfn,em,img,ins,kbd,q,samp,small,strong,sub,sup,var,b,i,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,figcaption,figure,footer,header,hgroup,menu,nav,section,summary,time,mark,audio,video{margin:0;padding:0;border:0;outline:0;font-size:100%;vertical-align:baseline;background:transparent}\nbody{line-height:1}\narticle,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section{display:block}\nnav ul{list-style:none}\nblockquote,q{quotes:none}\nblockquote:before,blockquote:after,q:before,q:after{content:none}\na{margin:0;padding:0;font-size:100%;vertical-align:baseline;background:transparent;text-decoration:none}\nmark{background-color:#ff9;color:#000;font-style:italic;font-weight:bold}\ndel{text-decoration:line-through}\nabbr[title],dfn[title]{border-bottom:1px dotted;cursor:help}\ntable{border-collapse:collapse;border-spacing:0}\nhr{display:block;height:1px;border:0;border-top:1px solid #ccc;margin:1em 0;padding:0}\ninput,select{vertical-align:middle}\nli{list-style:none}\n\n\n/* =============================================================================\n   My CSS\n   ========================================================================== */\n\n/* ---- base ---- */\n\nhtml,body{ \n\twidth:100%;\n\theight:100%;\n\tbackground:#111;\n}\n\nhtml{\n  -webkit-tap-highlight-color: rgba(0, 0, 0, 0);\n}\n\nbody{\n  font:normal 75% Arial, Helvetica, sans-serif;\n}\n\ncanvas{\n  display:block;\n  vertical-align:bottom;\n}\n\n\n/* ---- stats.js ---- */\n\n.count-particles{\n  background: #000022;\n  position: absolute;\n  top: 48px;\n  left: 0;\n  width: 80px;\n  color: #13E8E9;\n  font-size: .8em;\n  text-align: left;\n  text-indent: 4px;\n  line-height: 14px;\n  padding-bottom: 2px;\n  font-family: Helvetica, Arial, sans-serif;\n  font-weight: bold;\n}\n\n.js-count-particles{\n  font-size: 1.1em;\n}\n\n#stats,\n.count-particles{\n  -webkit-user-select: none;\n  margin-top: 5px;\n  margin-left: 5px;\n}\n\n#stats{\n  border-radius: 3px 3px 0 0;\n  overflow: hidden;\n}\n\n.count-particles{\n  border-radius: 0 0 3px 3px;\n}\n\n\n/* ---- particles.js container ---- */\n\n#particles-js{\n  width: 100%;\n  height: 100%;\n  background-color: #b61924;\n  background-image: url('');\n  background-size: cover;\n  background-position: 50% 50%;\n  background-repeat: no-repeat;\n}\n"]}]);


/***/ }),

/***/ "./node_modules/css-loader/dist/runtime/api.js":
/*!*****************************************************!*\
  !*** ./node_modules/css-loader/dist/runtime/api.js ***!
  \*****************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

/*
  MIT License http://www.opensource.org/licenses/mit-license.php
  Author Tobias Koppers @sokra
*/
// css base code, injected by the css-loader
// eslint-disable-next-line func-names

module.exports = function (useSourceMap) {
  var list = []; // return the list of modules as css string

  list.toString = function toString() {
    return this.map(function (item) {
      var content = cssWithMappingToString(item, useSourceMap);

      if (item[2]) {
        return "@media ".concat(item[2], "{").concat(content, "}");
      }

      return content;
    }).join('');
  }; // import a list of modules into the list
  // eslint-disable-next-line func-names


  list.i = function (modules, mediaQuery) {
    if (typeof modules === 'string') {
      // eslint-disable-next-line no-param-reassign
      modules = [[null, modules, '']];
    }

    var alreadyImportedModules = {};

    for (var i = 0; i < this.length; i++) {
      // eslint-disable-next-line prefer-destructuring
      var id = this[i][0];

      if (id != null) {
        alreadyImportedModules[id] = true;
      }
    }

    for (var _i = 0; _i < modules.length; _i++) {
      var item = modules[_i]; // skip already imported module
      // this implementation is not 100% perfect for weird media query combinations
      // when a module is imported multiple times with different media queries.
      // I hope this will never occur (Hey this way we have smaller bundles)

      if (item[0] == null || !alreadyImportedModules[item[0]]) {
        if (mediaQuery && !item[2]) {
          item[2] = mediaQuery;
        } else if (mediaQuery) {
          item[2] = "(".concat(item[2], ") and (").concat(mediaQuery, ")");
        }

        list.push(item);
      }
    }
  };

  return list;
};

function cssWithMappingToString(item, useSourceMap) {
  var content = item[1] || ''; // eslint-disable-next-line prefer-destructuring

  var cssMapping = item[3];

  if (!cssMapping) {
    return content;
  }

  if (useSourceMap && typeof btoa === 'function') {
    var sourceMapping = toComment(cssMapping);
    var sourceURLs = cssMapping.sources.map(function (source) {
      return "/*# sourceURL=".concat(cssMapping.sourceRoot).concat(source, " */");
    });
    return [content].concat(sourceURLs).concat([sourceMapping]).join('\n');
  }

  return [content].join('\n');
} // Adapted from convert-source-map (MIT)


function toComment(sourceMap) {
  // eslint-disable-next-line no-undef
  var base64 = btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap))));
  var data = "sourceMappingURL=data:application/json;charset=utf-8;base64,".concat(base64);
  return "/*# ".concat(data, " */");
}

/***/ }),

/***/ "./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js":
/*!****************************************************************************!*\
  !*** ./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js ***!
  \****************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var stylesInDom = {};

var isOldIE = function isOldIE() {
  var memo;
  return function memorize() {
    if (typeof memo === 'undefined') {
      // Test for IE <= 9 as proposed by Browserhacks
      // @see http://browserhacks.com/#hack-e71d8692f65334173fee715c222cb805
      // Tests for existence of standard globals is to allow style-loader
      // to operate correctly into non-standard environments
      // @see https://github.com/webpack-contrib/style-loader/issues/177
      memo = Boolean(window && document && document.all && !window.atob);
    }

    return memo;
  };
}();

var getTarget = function getTarget() {
  var memo = {};
  return function memorize(target) {
    if (typeof memo[target] === 'undefined') {
      var styleTarget = document.querySelector(target); // Special case to return head of iframe instead of iframe itself

      if (window.HTMLIFrameElement && styleTarget instanceof window.HTMLIFrameElement) {
        try {
          // This will throw an exception if access to iframe is blocked
          // due to cross-origin restrictions
          styleTarget = styleTarget.contentDocument.head;
        } catch (e) {
          // istanbul ignore next
          styleTarget = null;
        }
      }

      memo[target] = styleTarget;
    }

    return memo[target];
  };
}();

function listToStyles(list, options) {
  var styles = [];
  var newStyles = {};

  for (var i = 0; i < list.length; i++) {
    var item = list[i];
    var id = options.base ? item[0] + options.base : item[0];
    var css = item[1];
    var media = item[2];
    var sourceMap = item[3];
    var part = {
      css: css,
      media: media,
      sourceMap: sourceMap
    };

    if (!newStyles[id]) {
      styles.push(newStyles[id] = {
        id: id,
        parts: [part]
      });
    } else {
      newStyles[id].parts.push(part);
    }
  }

  return styles;
}

function addStylesToDom(styles, options) {
  for (var i = 0; i < styles.length; i++) {
    var item = styles[i];
    var domStyle = stylesInDom[item.id];
    var j = 0;

    if (domStyle) {
      domStyle.refs++;

      for (; j < domStyle.parts.length; j++) {
        domStyle.parts[j](item.parts[j]);
      }

      for (; j < item.parts.length; j++) {
        domStyle.parts.push(addStyle(item.parts[j], options));
      }
    } else {
      var parts = [];

      for (; j < item.parts.length; j++) {
        parts.push(addStyle(item.parts[j], options));
      }

      stylesInDom[item.id] = {
        id: item.id,
        refs: 1,
        parts: parts
      };
    }
  }
}

function insertStyleElement(options) {
  var style = document.createElement('style');

  if (typeof options.attributes.nonce === 'undefined') {
    var nonce =  true ? __webpack_require__.nc : undefined;

    if (nonce) {
      options.attributes.nonce = nonce;
    }
  }

  Object.keys(options.attributes).forEach(function (key) {
    style.setAttribute(key, options.attributes[key]);
  });

  if (typeof options.insert === 'function') {
    options.insert(style);
  } else {
    var target = getTarget(options.insert || 'head');

    if (!target) {
      throw new Error("Couldn't find a style target. This probably means that the value for the 'insert' parameter is invalid.");
    }

    target.appendChild(style);
  }

  return style;
}

function removeStyleElement(style) {
  // istanbul ignore if
  if (style.parentNode === null) {
    return false;
  }

  style.parentNode.removeChild(style);
}
/* istanbul ignore next  */


var replaceText = function replaceText() {
  var textStore = [];
  return function replace(index, replacement) {
    textStore[index] = replacement;
    return textStore.filter(Boolean).join('\n');
  };
}();

function applyToSingletonTag(style, index, remove, obj) {
  var css = remove ? '' : obj.css; // For old IE

  /* istanbul ignore if  */

  if (style.styleSheet) {
    style.styleSheet.cssText = replaceText(index, css);
  } else {
    var cssNode = document.createTextNode(css);
    var childNodes = style.childNodes;

    if (childNodes[index]) {
      style.removeChild(childNodes[index]);
    }

    if (childNodes.length) {
      style.insertBefore(cssNode, childNodes[index]);
    } else {
      style.appendChild(cssNode);
    }
  }
}

function applyToTag(style, options, obj) {
  var css = obj.css;
  var media = obj.media;
  var sourceMap = obj.sourceMap;

  if (media) {
    style.setAttribute('media', media);
  }

  if (sourceMap && btoa) {
    css += "\n/*# sourceMappingURL=data:application/json;base64,".concat(btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap)))), " */");
  } // For old IE

  /* istanbul ignore if  */


  if (style.styleSheet) {
    style.styleSheet.cssText = css;
  } else {
    while (style.firstChild) {
      style.removeChild(style.firstChild);
    }

    style.appendChild(document.createTextNode(css));
  }
}

var singleton = null;
var singletonCounter = 0;

function addStyle(obj, options) {
  var style;
  var update;
  var remove;

  if (options.singleton) {
    var styleIndex = singletonCounter++;
    style = singleton || (singleton = insertStyleElement(options));
    update = applyToSingletonTag.bind(null, style, styleIndex, false);
    remove = applyToSingletonTag.bind(null, style, styleIndex, true);
  } else {
    style = insertStyleElement(options);
    update = applyToTag.bind(null, style, options);

    remove = function remove() {
      removeStyleElement(style);
    };
  }

  update(obj);
  return function updateStyle(newObj) {
    if (newObj) {
      if (newObj.css === obj.css && newObj.media === obj.media && newObj.sourceMap === obj.sourceMap) {
        return;
      }

      update(obj = newObj);
    } else {
      remove();
    }
  };
}

module.exports = function (list, options) {
  options = options || {};
  options.attributes = typeof options.attributes === 'object' ? options.attributes : {}; // Force single-tag solution on IE6-9, which has a hard limit on the # of <style>
  // tags it will allow on a page

  if (!options.singleton && typeof options.singleton !== 'boolean') {
    options.singleton = isOldIE();
  }

  var styles = listToStyles(list, options);
  addStylesToDom(styles, options);
  return function update(newList) {
    var mayRemove = [];

    for (var i = 0; i < styles.length; i++) {
      var item = styles[i];
      var domStyle = stylesInDom[item.id];

      if (domStyle) {
        domStyle.refs--;
        mayRemove.push(domStyle);
      }
    }

    if (newList) {
      var newStyles = listToStyles(newList, options);
      addStylesToDom(newStyles, options);
    }

    for (var _i = 0; _i < mayRemove.length; _i++) {
      var _domStyle = mayRemove[_i];

      if (_domStyle.refs === 0) {
        for (var j = 0; j < _domStyle.parts.length; j++) {
          _domStyle.parts[j]();
        }

        delete stylesInDom[_domStyle.id];
      }
    }
  };
};

/***/ })

/******/ });
//# sourceMappingURL=style-2a5556ca60f22fa14cd8.js.map