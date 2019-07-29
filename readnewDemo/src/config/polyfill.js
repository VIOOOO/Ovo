/**
 * IE 扩展includes函数
 */
if (!String.prototype.includes) {
    String.prototype.includes = function (search, start) {
        if (typeof start !== 'number') {
            start = 0;
        }

        if (start + search.length > this.length) {
            return false;
        } else {
            return this.indexOf(search, start) !== -1;
        }
    };
}
/**
 * IE 扩展startsWith函数
 */
if (!String.prototype.startsWith) {
    String.prototype.startsWith = function (search, pos) {
        return this.substr(!pos || pos < 0 ? 0 : +pos, search.length) === search;
    };
}

/**
 * IE 扩展endsWith函数
 */
if (!String.prototype.endsWith) {
	String.prototype.endsWith = function(search, this_len) {
		if (this_len === undefined || this_len > this.length) {
			this_len = this.length;
		}
		return this.substring(this_len - search.length, this_len) === search;
	};
}

/**
 * IE 扩展数组find函数
 */
if (!Array.prototype.find) {
    Object.defineProperty(Array.prototype, 'find', {
        value: function (predicate) {
            // 1. Let O be ? ToObject(this value).
            if (this == null) {
                throw new TypeError('"this" is null or not defined');
            }

            var o = Object(this);

            // 2. Let len be ? ToLength(? Get(O, "length")).
            var len = o.length >>> 0;

            // 3. If IsCallable(predicate) is false, throw a TypeError exception.
            if (typeof predicate !== 'function') {
                throw new TypeError('predicate must be a function');
            }

            // 4. If thisArg was supplied, let T be thisArg; else let T be undefined.
            var thisArg = arguments[1];

            // 5. Let k be 0.
            var k = 0;

            // 6. Repeat, while k < len
            while (k < len) {
                // a. Let Pk be ! ToString(k).
                // b. Let kValue be ? Get(O, Pk).
                // c. Let testResult be ToBoolean(? Call(predicate, T, « kValue, k, O »)).
                // d. If testResult is true, return kValue.
                var kValue = o[k];
                if (predicate.call(thisArg, kValue, k, o)) {
                    return kValue;
                }
                // e. Increase k by 1.
                k++;
            }

            // 7. Return undefined.
            return undefined;
        }
    });
}

if (!Array.prototype.filter) {
    Array.prototype.filter = function (func, thisArg) {
        if (!((typeof func === 'Function' || typeof func === 'function') && this))
            throw new TypeError();

        var len = this.length >>> 0,
            res = new Array(len), // preallocate array
            t = this,
            c = 0,
            i = -1;
        if (thisArg === undefined)
            while (++i !== len)
                // checks to see if the key was set
                if (i in this)
                    if (func(t[i], i, t))
                        res[c++] = t[i];
                    else
                        while (++i !== len)
                            // checks to see if the key was set
                            if (i in this)
                                if (func.call(thisArg, t[i], i, t))
                                    res[c++] = t[i];

        res.length = c; // shrink down array to proper size
        return res;
    };
}

if (!Array.prototype.includes) {
    Object.defineProperty(Array.prototype, 'includes', {
        value: function (searchElement, fromIndex) {

            if (this == null) {
                throw new TypeError('"this" is null or not defined');
            }

            // 1. Let O be ? ToObject(this value).
            var o = Object(this);

            // 2. Let len be ? ToLength(? Get(O, "length")).
            var len = o.length >>> 0;

            // 3. If len is 0, return false.
            if (len === 0) {
                return false;
            }

            // 4. Let n be ? ToInteger(fromIndex).
            //    (If fromIndex is undefined, this step produces the value 0.)
            var n = fromIndex | 0;

            // 5. If n ≥ 0, then
            //  a. Let k be n.
            // 6. Else n < 0,
            //  a. Let k be len + n.
            //  b. If k < 0, let k be 0.
            var k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);

            function sameValueZero(x, y) {
                return x === y || (typeof x === 'number' && typeof y === 'number' && isNaN(x) && isNaN(y));
            }

            // 7. Repeat, while k < len
            while (k < len) {
                // a. Let elementK be the result of ? Get(O, ! ToString(k)).
                // b. If SameValueZero(searchElement, elementK) is true, return true.
                if (sameValueZero(o[k], searchElement)) {
                    return true;
                }
                // c. Increase k by 1. 
                k++;
            }

            // 8. Return false
            return false;
        }
    });
}


if (!Array.prototype.forEach) {

    Array.prototype.forEach = function (callback /*, thisArg*/) {

        var T, k;

        if (this == null) {
            throw new TypeError('this is null or not defined');
        }

        // 1. Let O be the result of calling toObject() passing the
        // |this| value as the argument.
        var O = Object(this);

        // 2. Let lenValue be the result of calling the Get() internal
        // method of O with the argument "length".
        // 3. Let len be toUint32(lenValue).
        var len = O.length >>> 0;

        // 4. If isCallable(callback) is false, throw a TypeError exception. 
        // See: http://es5.github.com/#x9.11
        if (typeof callback !== 'function') {
            throw new TypeError(callback + ' is not a function');
        }

        // 5. If thisArg was supplied, let T be thisArg; else let
        // T be undefined.
        if (arguments.length > 1) {
            T = arguments[1];
        }

        // 6. Let k be 0.
        k = 0;

        // 7. Repeat while k < len.
        while (k < len) {

            var kValue;

            // a. Let Pk be ToString(k).
            //    This is implicit for LHS operands of the in operator.
            // b. Let kPresent be the result of calling the HasProperty
            //    internal method of O with argument Pk.
            //    This step can be combined with c.
            // c. If kPresent is true, then
            if (k in O) {

                // i. Let kValue be the result of calling the Get internal
                // method of O with argument Pk.
                kValue = O[k];

                // ii. Call the Call internal method of callback with T as
                // the this value and argument list containing kValue, k, and O.
                callback.call(T, kValue, k, O);
            }
            // d. Increase k by 1.
            k++;
        }
        // 8. return undefined.
    };
}

if (!String.prototype.startsWith) {
    String.prototype.startsWith = function (search, pos) {
        return this.substr(!pos || pos < 0 ? 0 : +pos, search.length) === search;
    };
}


// Production steps of ECMA-262, Edition 5, 15.4.4.18
// Reference: http://es5.github.io/#x15.4.4.18
if (!Array.prototype.forEach) {

    Array.prototype.forEach = function (callback /*, thisArg*/) {

        var T, k;

        if (this == null) {
            throw new TypeError('this is null or not defined');
        }

        // 1. Let O be the result of calling toObject() passing the
        // |this| value as the argument.
        var O = Object(this);

        // 2. Let lenValue be the result of calling the Get() internal
        // method of O with the argument "length".
        // 3. Let len be toUint32(lenValue).
        var len = O.length >>> 0;

        // 4. If isCallable(callback) is false, throw a TypeError exception. 
        // See: http://es5.github.com/#x9.11
        if (typeof callback !== 'function') {
            throw new TypeError(callback + ' is not a function');
        }

        // 5. If thisArg was supplied, let T be thisArg; else let
        // T be undefined.
        if (arguments.length > 1) {
            T = arguments[1];
        }

        // 6. Let k be 0.
        k = 0;

        // 7. Repeat while k < len.
        while (k < len) {

            var kValue;

            // a. Let Pk be ToString(k).
            //    This is implicit for LHS operands of the in operator.
            // b. Let kPresent be the result of calling the HasProperty
            //    internal method of O with argument Pk.
            //    This step can be combined with c.
            // c. If kPresent is true, then
            if (k in O) {

                // i. Let kValue be the result of calling the Get internal
                // method of O with argument Pk.
                kValue = O[k];

                // ii. Call the Call internal method of callback with T as
                // the this value and argument list containing kValue, k, and O.
                callback.call(T, kValue, k, O);
            }
            // d. Increase k by 1.
            k++;
        }
        // 8. return undefined.
    };
}

// Production steps of ECMA-262, Edition 5, 15.4.4.21
// Reference: http://es5.github.io/#x15.4.4.21
// https://tc39.github.io/ecma262/#sec-array.prototype.reduce
if (!Array.prototype.reduce) {
    Object.defineProperty(Array.prototype, 'reduce', {
        value: function (callback /*, initialValue*/) {
            if (this === null) {
                throw new TypeError('Array.prototype.reduce ' +
                    'called on null or undefined');
            }
            if (typeof callback !== 'function') {
                throw new TypeError(callback +
                    ' is not a function');
            }

            // 1. Let O be ? ToObject(this value).
            var o = Object(this);

            // 2. Let len be ? ToLength(? Get(O, "length")).
            var len = o.length >>> 0;

            // Steps 3, 4, 5, 6, 7      
            var k = 0;
            var value;

            if (arguments.length >= 2) {
                value = arguments[1];
            } else {
                while (k < len && !(k in o)) {
                    k++;
                }

                // 3. If len is 0 and initialValue is not present,
                //    throw a TypeError exception.
                if (k >= len) {
                    throw new TypeError('Reduce of empty array ' +
                        'with no initial value');
                }
                value = o[k++];
            }

            // 8. Repeat, while k < len
            while (k < len) {
                // a. Let Pk be ! ToString(k).
                // b. Let kPresent be ? HasProperty(O, Pk).
                // c. If kPresent is true, then
                //    i.  Let kValue be ? Get(O, Pk).
                //    ii. Let accumulator be ? Call(
                //          callbackfn, undefined,
                //          « accumulator, kValue, k, O »).
                if (k in o) {
                    value = callback(value, o[k], k, o);
                }

                // d. Increase k by 1.      
                k++;
            }

            // 9. Return accumulator.
            return value;
        }
    });
}

// Production steps of ECMA-262, Edition 5, 15.4.4.17
// Reference: http://es5.github.io/#x15.4.4.17
if (!Array.prototype.some) {
    Array.prototype.some = function(fun/*, thisArg*/) {
      'use strict';
  
      if (this == null) {
        throw new TypeError('Array.prototype.some called on null or undefined');
      }
  
      if (typeof fun !== 'function') {
        throw new TypeError();
      }
  
      var t = Object(this);
      var len = t.length >>> 0;
  
      var thisArg = arguments.length >= 2 ? arguments[1] : void 0;
      for (var i = 0; i < len; i++) {
        if (i in t && fun.call(thisArg, t[i], i, t)) {
          return true;
        }
      }
  
      return false;
    };
  }

  if (typeof Object.assign != 'function') {
    // Must be writable: true, enumerable: false, configurable: true
    Object.defineProperty(Object, "assign", {
      value: function assign(target, varArgs) { // .length of function is 2
        'use strict';
        if (target == null) { // TypeError if undefined or null
          throw new TypeError('Cannot convert undefined or null to object');
        }
  
        var to = Object(target);
  
        for (var index = 1; index < arguments.length; index++) {
          var nextSource = arguments[index];
  
          if (nextSource != null) { // Skip over if undefined or null
            for (var nextKey in nextSource) {
              // Avoid bugs when hasOwnProperty is shadowed
              if (Object.prototype.hasOwnProperty.call(nextSource, nextKey)) {
                to[nextKey] = nextSource[nextKey];
              }
            }
          }
        }
        return to;
      },
      writable: true,
      configurable: true
    });
  }

  // Production steps of ECMA-262, Edition 5, 15.4.4.17
// Reference: http://es5.github.io/#x15.4.4.17
if (!Array.prototype.some) {
    Array.prototype.some = function(fun/*, thisArg*/) {
      'use strict';
  
      if (this == null) {
        throw new TypeError('Array.prototype.some called on null or undefined');
      }
  
      if (typeof fun !== 'function') {
        throw new TypeError();
      }
  
      var t = Object(this);
      var len = t.length >>> 0;
  
      var thisArg = arguments.length >= 2 ? arguments[1] : void 0;
      for (var i = 0; i < len; i++) {
        if (i in t && fun.call(thisArg, t[i], i, t)) {
          return true;
        }
      }
  
      return false;
    };
  }


  Date.prototype.format = function(format)
{
 var o = {
 "M+" : this.getMonth()+1, //month
 "d+" : this.getDate(),    //day
 "h+" : this.getHours(),   //hour
 "m+" : this.getMinutes(), //minute
 "s+" : this.getSeconds(), //second
 "q+" : Math.floor((this.getMonth()+3)/3),  //quarter
 "S" : this.getMilliseconds() //millisecond
 }
 if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
 (this.getFullYear()+"").substr(4 - RegExp.$1.length));
 for(var k in o)if(new RegExp("("+ k +")").test(format))
 format = format.replace(RegExp.$1,
 RegExp.$1.length==1 ? o[k] :
 ("00"+ o[k]).substr((""+ o[k]).length));
 return format;
}

 