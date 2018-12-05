(function(scope){
'use strict';

function F(arity, fun, wrapper) {
  wrapper.a = arity;
  wrapper.f = fun;
  return wrapper;
}

function F2(fun) {
  return F(2, fun, function(a) { return function(b) { return fun(a,b); }; })
}
function F3(fun) {
  return F(3, fun, function(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  });
}
function F4(fun) {
  return F(4, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  });
}
function F5(fun) {
  return F(5, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  });
}
function F6(fun) {
  return F(6, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  });
}
function F7(fun) {
  return F(7, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  });
}
function F8(fun) {
  return F(8, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  });
}
function F9(fun) {
  return F(9, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  });
}

function A2(fun, a, b) {
  return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
  return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
  return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
  return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
  return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
  return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
  return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
  return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

console.warn('Compiled in DEV mode. Follow the advice at https://elm-lang.org/0.19.0/optimize for better performance and smaller assets.');


var _JsArray_empty = [];

function _JsArray_singleton(value)
{
    return [value];
}

function _JsArray_length(array)
{
    return array.length;
}

var _JsArray_initialize = F3(function(size, offset, func)
{
    var result = new Array(size);

    for (var i = 0; i < size; i++)
    {
        result[i] = func(offset + i);
    }

    return result;
});

var _JsArray_initializeFromList = F2(function (max, ls)
{
    var result = new Array(max);

    for (var i = 0; i < max && ls.b; i++)
    {
        result[i] = ls.a;
        ls = ls.b;
    }

    result.length = i;
    return _Utils_Tuple2(result, ls);
});

var _JsArray_unsafeGet = F2(function(index, array)
{
    return array[index];
});

var _JsArray_unsafeSet = F3(function(index, value, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[index] = value;
    return result;
});

var _JsArray_push = F2(function(value, array)
{
    var length = array.length;
    var result = new Array(length + 1);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[length] = value;
    return result;
});

var _JsArray_foldl = F3(function(func, acc, array)
{
    var length = array.length;

    for (var i = 0; i < length; i++)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_foldr = F3(function(func, acc, array)
{
    for (var i = array.length - 1; i >= 0; i--)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_map = F2(function(func, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = func(array[i]);
    }

    return result;
});

var _JsArray_indexedMap = F3(function(func, offset, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = A2(func, offset + i, array[i]);
    }

    return result;
});

var _JsArray_slice = F3(function(from, to, array)
{
    return array.slice(from, to);
});

var _JsArray_appendN = F3(function(n, dest, source)
{
    var destLen = dest.length;
    var itemsToCopy = n - destLen;

    if (itemsToCopy > source.length)
    {
        itemsToCopy = source.length;
    }

    var size = destLen + itemsToCopy;
    var result = new Array(size);

    for (var i = 0; i < destLen; i++)
    {
        result[i] = dest[i];
    }

    for (var i = 0; i < itemsToCopy; i++)
    {
        result[i + destLen] = source[i];
    }

    return result;
});



var _List_Nil_UNUSED = { $: 0 };
var _List_Nil = { $: '[]' };

function _List_Cons_UNUSED(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons(hd, tl) { return { $: '::', a: hd, b: tl }; }


var _List_cons = F2(_List_Cons);

function _List_fromArray(arr)
{
	var out = _List_Nil;
	for (var i = arr.length; i--; )
	{
		out = _List_Cons(arr[i], out);
	}
	return out;
}

function _List_toArray(xs)
{
	for (var out = []; xs.b; xs = xs.b) // WHILE_CONS
	{
		out.push(xs.a);
	}
	return out;
}

var _List_map2 = F3(function(f, xs, ys)
{
	for (var arr = []; xs.b && ys.b; xs = xs.b, ys = ys.b) // WHILE_CONSES
	{
		arr.push(A2(f, xs.a, ys.a));
	}
	return _List_fromArray(arr);
});

var _List_map3 = F4(function(f, xs, ys, zs)
{
	for (var arr = []; xs.b && ys.b && zs.b; xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A3(f, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map4 = F5(function(f, ws, xs, ys, zs)
{
	for (var arr = []; ws.b && xs.b && ys.b && zs.b; ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A4(f, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map5 = F6(function(f, vs, ws, xs, ys, zs)
{
	for (var arr = []; vs.b && ws.b && xs.b && ys.b && zs.b; vs = vs.b, ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A5(f, vs.a, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_sortBy = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		return _Utils_cmp(f(a), f(b));
	}));
});

var _List_sortWith = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		var ord = A2(f, a, b);
		return ord === elm$core$Basics$EQ ? 0 : ord === elm$core$Basics$LT ? -1 : 1;
	}));
});



// LOG

var _Debug_log_UNUSED = F2(function(tag, value)
{
	return value;
});

var _Debug_log = F2(function(tag, value)
{
	console.log(tag + ': ' + _Debug_toString(value));
	return value;
});


// TODOS

function _Debug_todo(moduleName, region)
{
	return function(message) {
		_Debug_crash(8, moduleName, region, message);
	};
}

function _Debug_todoCase(moduleName, region, value)
{
	return function(message) {
		_Debug_crash(9, moduleName, region, value, message);
	};
}


// TO STRING

function _Debug_toString_UNUSED(value)
{
	return '<internals>';
}

function _Debug_toString(value)
{
	return _Debug_toAnsiString(false, value);
}

function _Debug_toAnsiString(ansi, value)
{
	if (typeof value === 'function')
	{
		return _Debug_internalColor(ansi, '<function>');
	}

	if (typeof value === 'boolean')
	{
		return _Debug_ctorColor(ansi, value ? 'True' : 'False');
	}

	if (typeof value === 'number')
	{
		return _Debug_numberColor(ansi, value + '');
	}

	if (value instanceof String)
	{
		return _Debug_charColor(ansi, "'" + _Debug_addSlashes(value, true) + "'");
	}

	if (typeof value === 'string')
	{
		return _Debug_stringColor(ansi, '"' + _Debug_addSlashes(value, false) + '"');
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (typeof tag === 'number')
		{
			return _Debug_internalColor(ansi, '<internals>');
		}

		if (tag[0] === '#')
		{
			var output = [];
			for (var k in value)
			{
				if (k === '$') continue;
				output.push(_Debug_toAnsiString(ansi, value[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (tag === 'Set_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Set')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, elm$core$Set$toList(value));
		}

		if (tag === 'RBNode_elm_builtin' || tag === 'RBEmpty_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Dict')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, elm$core$Dict$toList(value));
		}

		if (tag === 'Array_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Array')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, elm$core$Array$toList(value));
		}

		if (tag === '::' || tag === '[]')
		{
			var output = '[';

			value.b && (output += _Debug_toAnsiString(ansi, value.a), value = value.b)

			for (; value.b; value = value.b) // WHILE_CONS
			{
				output += ',' + _Debug_toAnsiString(ansi, value.a);
			}
			return output + ']';
		}

		var output = '';
		for (var i in value)
		{
			if (i === '$') continue;
			var str = _Debug_toAnsiString(ansi, value[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '[' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return _Debug_ctorColor(ansi, tag) + output;
	}

	if (typeof DataView === 'function' && value instanceof DataView)
	{
		return _Debug_stringColor(ansi, '<' + value.byteLength + ' bytes>');
	}

	if (typeof File === 'function' && value instanceof File)
	{
		return _Debug_internalColor(ansi, '<' + value.name + '>');
	}

	if (typeof value === 'object')
	{
		var output = [];
		for (var key in value)
		{
			var field = key[0] === '_' ? key.slice(1) : key;
			output.push(_Debug_fadeColor(ansi, field) + ' = ' + _Debug_toAnsiString(ansi, value[key]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return _Debug_internalColor(ansi, '<internals>');
}

function _Debug_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');

	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}

function _Debug_ctorColor(ansi, string)
{
	return ansi ? '\x1b[96m' + string + '\x1b[0m' : string;
}

function _Debug_numberColor(ansi, string)
{
	return ansi ? '\x1b[95m' + string + '\x1b[0m' : string;
}

function _Debug_stringColor(ansi, string)
{
	return ansi ? '\x1b[93m' + string + '\x1b[0m' : string;
}

function _Debug_charColor(ansi, string)
{
	return ansi ? '\x1b[92m' + string + '\x1b[0m' : string;
}

function _Debug_fadeColor(ansi, string)
{
	return ansi ? '\x1b[37m' + string + '\x1b[0m' : string;
}

function _Debug_internalColor(ansi, string)
{
	return ansi ? '\x1b[94m' + string + '\x1b[0m' : string;
}

function _Debug_toHexDigit(n)
{
	return String.fromCharCode(n < 10 ? 48 + n : 55 + n);
}


// CRASH


function _Debug_crash_UNUSED(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash(identifier, fact1, fact2, fact3, fact4)
{
	switch(identifier)
	{
		case 0:
			throw new Error('What node should I take over? In JavaScript I need something like:\n\n    Elm.Main.init({\n        node: document.getElementById("elm-node")\n    })\n\nYou need to do this with any Browser.sandbox or Browser.element program.');

		case 1:
			throw new Error('Browser.application programs cannot handle URLs like this:\n\n    ' + document.location.href + '\n\nWhat is the root? The root of your file system? Try looking at this program with `elm reactor` or some other server.');

		case 2:
			var jsonErrorString = fact1;
			throw new Error('Problem with the flags given to your Elm program on initialization.\n\n' + jsonErrorString);

		case 3:
			var portName = fact1;
			throw new Error('There can only be one port named `' + portName + '`, but your program has multiple.');

		case 4:
			var portName = fact1;
			var problem = fact2;
			throw new Error('Trying to send an unexpected type of value through port `' + portName + '`:\n' + problem);

		case 5:
			throw new Error('Trying to use `(==)` on functions.\nThere is no way to know if functions are "the same" in the Elm sense.\nRead more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.');

		case 6:
			var moduleName = fact1;
			throw new Error('Your page is loading multiple Elm scripts with a module named ' + moduleName + '. Maybe a duplicate script is getting loaded accidentally? If not, rename one of them so I know which is which!');

		case 8:
			var moduleName = fact1;
			var region = fact2;
			var message = fact3;
			throw new Error('TODO in module `' + moduleName + '` ' + _Debug_regionToString(region) + '\n\n' + message);

		case 9:
			var moduleName = fact1;
			var region = fact2;
			var value = fact3;
			var message = fact4;
			throw new Error(
				'TODO in module `' + moduleName + '` from the `case` expression '
				+ _Debug_regionToString(region) + '\n\nIt received the following value:\n\n    '
				+ _Debug_toString(value).replace('\n', '\n    ')
				+ '\n\nBut the branch that handles it says:\n\n    ' + message.replace('\n', '\n    ')
			);

		case 10:
			throw new Error('Bug in https://github.com/elm/virtual-dom/issues');

		case 11:
			throw new Error('Cannot perform mod 0. Division by zero error.');
	}
}

function _Debug_regionToString(region)
{
	if (region.start.line === region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'on lines ' + region.start.line + ' through ' + region.end.line;
}



// EQUALITY

function _Utils_eq(x, y)
{
	for (
		var pair, stack = [], isEqual = _Utils_eqHelp(x, y, 0, stack);
		isEqual && (pair = stack.pop());
		isEqual = _Utils_eqHelp(pair.a, pair.b, 0, stack)
		)
	{}

	return isEqual;
}

function _Utils_eqHelp(x, y, depth, stack)
{
	if (depth > 100)
	{
		stack.push(_Utils_Tuple2(x,y));
		return true;
	}

	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object' || x === null || y === null)
	{
		typeof x === 'function' && _Debug_crash(5);
		return false;
	}

	/**/
	if (x.$ === 'Set_elm_builtin')
	{
		x = elm$core$Set$toList(x);
		y = elm$core$Set$toList(y);
	}
	if (x.$ === 'RBNode_elm_builtin' || x.$ === 'RBEmpty_elm_builtin')
	{
		x = elm$core$Dict$toList(x);
		y = elm$core$Dict$toList(y);
	}
	//*/

	/**_UNUSED/
	if (x.$ < 0)
	{
		x = elm$core$Dict$toList(x);
		y = elm$core$Dict$toList(y);
	}
	//*/

	for (var key in x)
	{
		if (!_Utils_eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

var _Utils_equal = F2(_Utils_eq);
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });



// COMPARISONS

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

function _Utils_cmp(x, y, ord)
{
	if (typeof x !== 'object')
	{
		return x === y ? /*EQ*/ 0 : x < y ? /*LT*/ -1 : /*GT*/ 1;
	}

	/**/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**_UNUSED/
	if (typeof x.$ === 'undefined')
	//*/
	/**/
	if (x.$[0] === '#')
	//*/
	{
		return (ord = _Utils_cmp(x.a, y.a))
			? ord
			: (ord = _Utils_cmp(x.b, y.b))
				? ord
				: _Utils_cmp(x.c, y.c);
	}

	// traverse conses until end of a list or a mismatch
	for (; x.b && y.b && !(ord = _Utils_cmp(x.a, y.a)); x = x.b, y = y.b) {} // WHILE_CONSES
	return ord || (x.b ? /*GT*/ 1 : y.b ? /*LT*/ -1 : /*EQ*/ 0);
}

var _Utils_lt = F2(function(a, b) { return _Utils_cmp(a, b) < 0; });
var _Utils_le = F2(function(a, b) { return _Utils_cmp(a, b) < 1; });
var _Utils_gt = F2(function(a, b) { return _Utils_cmp(a, b) > 0; });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });

var _Utils_compare = F2(function(x, y)
{
	var n = _Utils_cmp(x, y);
	return n < 0 ? elm$core$Basics$LT : n ? elm$core$Basics$GT : elm$core$Basics$EQ;
});


// COMMON VALUES

var _Utils_Tuple0_UNUSED = 0;
var _Utils_Tuple0 = { $: '#0' };

function _Utils_Tuple2_UNUSED(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3_UNUSED(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr_UNUSED(c) { return c; }
function _Utils_chr(c) { return new String(c); }


// RECORDS

function _Utils_update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


// APPEND

var _Utils_append = F2(_Utils_ap);

function _Utils_ap(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (!xs.b)
	{
		return ys;
	}
	var root = _List_Cons(xs.a, ys);
	xs = xs.b
	for (var curr = root; xs.b; xs = xs.b) // WHILE_CONS
	{
		curr = curr.b = _List_Cons(xs.a, ys);
	}
	return root;
}



// MATH

var _Basics_add = F2(function(a, b) { return a + b; });
var _Basics_sub = F2(function(a, b) { return a - b; });
var _Basics_mul = F2(function(a, b) { return a * b; });
var _Basics_fdiv = F2(function(a, b) { return a / b; });
var _Basics_idiv = F2(function(a, b) { return (a / b) | 0; });
var _Basics_pow = F2(Math.pow);

var _Basics_remainderBy = F2(function(b, a) { return a % b; });

// https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
var _Basics_modBy = F2(function(modulus, x)
{
	var answer = x % modulus;
	return modulus === 0
		? _Debug_crash(11)
		:
	((answer > 0 && modulus < 0) || (answer < 0 && modulus > 0))
		? answer + modulus
		: answer;
});


// TRIGONOMETRY

var _Basics_pi = Math.PI;
var _Basics_e = Math.E;
var _Basics_cos = Math.cos;
var _Basics_sin = Math.sin;
var _Basics_tan = Math.tan;
var _Basics_acos = Math.acos;
var _Basics_asin = Math.asin;
var _Basics_atan = Math.atan;
var _Basics_atan2 = F2(Math.atan2);


// MORE MATH

function _Basics_toFloat(x) { return x; }
function _Basics_truncate(n) { return n | 0; }
function _Basics_isInfinite(n) { return n === Infinity || n === -Infinity; }

var _Basics_ceiling = Math.ceil;
var _Basics_floor = Math.floor;
var _Basics_round = Math.round;
var _Basics_sqrt = Math.sqrt;
var _Basics_log = Math.log;
var _Basics_isNaN = isNaN;


// BOOLEANS

function _Basics_not(bool) { return !bool; }
var _Basics_and = F2(function(a, b) { return a && b; });
var _Basics_or  = F2(function(a, b) { return a || b; });
var _Basics_xor = F2(function(a, b) { return a !== b; });



function _Char_toCode(char)
{
	var code = char.charCodeAt(0);
	if (0xD800 <= code && code <= 0xDBFF)
	{
		return (code - 0xD800) * 0x400 + char.charCodeAt(1) - 0xDC00 + 0x10000
	}
	return code;
}

function _Char_fromCode(code)
{
	return _Utils_chr(
		(code < 0 || 0x10FFFF < code)
			? '\uFFFD'
			:
		(code <= 0xFFFF)
			? String.fromCharCode(code)
			:
		(code -= 0x10000,
			String.fromCharCode(Math.floor(code / 0x400) + 0xD800, code % 0x400 + 0xDC00)
		)
	);
}

function _Char_toUpper(char)
{
	return _Utils_chr(char.toUpperCase());
}

function _Char_toLower(char)
{
	return _Utils_chr(char.toLowerCase());
}

function _Char_toLocaleUpper(char)
{
	return _Utils_chr(char.toLocaleUpperCase());
}

function _Char_toLocaleLower(char)
{
	return _Utils_chr(char.toLocaleLowerCase());
}



var _String_cons = F2(function(chr, str)
{
	return chr + str;
});

function _String_uncons(string)
{
	var word = string.charCodeAt(0);
	return word
		? elm$core$Maybe$Just(
			0xD800 <= word && word <= 0xDBFF
				? _Utils_Tuple2(_Utils_chr(string[0] + string[1]), string.slice(2))
				: _Utils_Tuple2(_Utils_chr(string[0]), string.slice(1))
		)
		: elm$core$Maybe$Nothing;
}

var _String_append = F2(function(a, b)
{
	return a + b;
});

function _String_length(str)
{
	return str.length;
}

var _String_map = F2(function(func, string)
{
	var len = string.length;
	var array = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = string.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			array[i] = func(_Utils_chr(string[i] + string[i+1]));
			i += 2;
			continue;
		}
		array[i] = func(_Utils_chr(string[i]));
		i++;
	}
	return array.join('');
});

var _String_filter = F2(function(isGood, str)
{
	var arr = [];
	var len = str.length;
	var i = 0;
	while (i < len)
	{
		var char = str[i];
		var word = str.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += str[i];
			i++;
		}

		if (isGood(_Utils_chr(char)))
		{
			arr.push(char);
		}
	}
	return arr.join('');
});

function _String_reverse(str)
{
	var len = str.length;
	var arr = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = str.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			arr[len - i] = str[i + 1];
			i++;
			arr[len - i] = str[i - 1];
			i++;
		}
		else
		{
			arr[len - i] = str[i];
			i++;
		}
	}
	return arr.join('');
}

var _String_foldl = F3(function(func, state, string)
{
	var len = string.length;
	var i = 0;
	while (i < len)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += string[i];
			i++;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_foldr = F3(function(func, state, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_split = F2(function(sep, str)
{
	return str.split(sep);
});

var _String_join = F2(function(sep, strs)
{
	return strs.join(sep);
});

var _String_slice = F3(function(start, end, str) {
	return str.slice(start, end);
});

function _String_trim(str)
{
	return str.trim();
}

function _String_trimLeft(str)
{
	return str.replace(/^\s+/, '');
}

function _String_trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function _String_words(str)
{
	return _List_fromArray(str.trim().split(/\s+/g));
}

function _String_lines(str)
{
	return _List_fromArray(str.split(/\r\n|\r|\n/g));
}

function _String_toUpper(str)
{
	return str.toUpperCase();
}

function _String_toLower(str)
{
	return str.toLowerCase();
}

var _String_any = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (isGood(_Utils_chr(char)))
		{
			return true;
		}
	}
	return false;
});

var _String_all = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (!isGood(_Utils_chr(char)))
		{
			return false;
		}
	}
	return true;
});

var _String_contains = F2(function(sub, str)
{
	return str.indexOf(sub) > -1;
});

var _String_startsWith = F2(function(sub, str)
{
	return str.indexOf(sub) === 0;
});

var _String_endsWith = F2(function(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
});

var _String_indexes = F2(function(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _List_Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _List_fromArray(is);
});


// TO STRING

function _String_fromNumber(number)
{
	return number + '';
}


// INT CONVERSIONS

function _String_toInt(str)
{
	var total = 0;
	var code0 = str.charCodeAt(0);
	var start = code0 == 0x2B /* + */ || code0 == 0x2D /* - */ ? 1 : 0;

	for (var i = start; i < str.length; ++i)
	{
		var code = str.charCodeAt(i);
		if (code < 0x30 || 0x39 < code)
		{
			return elm$core$Maybe$Nothing;
		}
		total = 10 * total + code - 0x30;
	}

	return i == start
		? elm$core$Maybe$Nothing
		: elm$core$Maybe$Just(code0 == 0x2D ? -total : total);
}


// FLOAT CONVERSIONS

function _String_toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return elm$core$Maybe$Nothing;
	}
	var n = +s;
	// faster isNaN check
	return n === n ? elm$core$Maybe$Just(n) : elm$core$Maybe$Nothing;
}

function _String_fromList(chars)
{
	return _List_toArray(chars).join('');
}




/**/
function _Json_errorToString(error)
{
	return elm$json$Json$Decode$errorToString(error);
}
//*/


// CORE DECODERS

function _Json_succeed(msg)
{
	return {
		$: 0,
		a: msg
	};
}

function _Json_fail(msg)
{
	return {
		$: 1,
		a: msg
	};
}

function _Json_decodePrim(decoder)
{
	return { $: 2, b: decoder };
}

var _Json_decodeInt = _Json_decodePrim(function(value) {
	return (typeof value !== 'number')
		? _Json_expecting('an INT', value)
		:
	(-2147483647 < value && value < 2147483647 && (value | 0) === value)
		? elm$core$Result$Ok(value)
		:
	(isFinite(value) && !(value % 1))
		? elm$core$Result$Ok(value)
		: _Json_expecting('an INT', value);
});

var _Json_decodeBool = _Json_decodePrim(function(value) {
	return (typeof value === 'boolean')
		? elm$core$Result$Ok(value)
		: _Json_expecting('a BOOL', value);
});

var _Json_decodeFloat = _Json_decodePrim(function(value) {
	return (typeof value === 'number')
		? elm$core$Result$Ok(value)
		: _Json_expecting('a FLOAT', value);
});

var _Json_decodeValue = _Json_decodePrim(function(value) {
	return elm$core$Result$Ok(_Json_wrap(value));
});

var _Json_decodeString = _Json_decodePrim(function(value) {
	return (typeof value === 'string')
		? elm$core$Result$Ok(value)
		: (value instanceof String)
			? elm$core$Result$Ok(value + '')
			: _Json_expecting('a STRING', value);
});

function _Json_decodeList(decoder) { return { $: 3, b: decoder }; }
function _Json_decodeArray(decoder) { return { $: 4, b: decoder }; }

function _Json_decodeNull(value) { return { $: 5, c: value }; }

var _Json_decodeField = F2(function(field, decoder)
{
	return {
		$: 6,
		d: field,
		b: decoder
	};
});

var _Json_decodeIndex = F2(function(index, decoder)
{
	return {
		$: 7,
		e: index,
		b: decoder
	};
});

function _Json_decodeKeyValuePairs(decoder)
{
	return {
		$: 8,
		b: decoder
	};
}

function _Json_mapMany(f, decoders)
{
	return {
		$: 9,
		f: f,
		g: decoders
	};
}

var _Json_andThen = F2(function(callback, decoder)
{
	return {
		$: 10,
		b: decoder,
		h: callback
	};
});

function _Json_oneOf(decoders)
{
	return {
		$: 11,
		g: decoders
	};
}


// DECODING OBJECTS

var _Json_map1 = F2(function(f, d1)
{
	return _Json_mapMany(f, [d1]);
});

var _Json_map2 = F3(function(f, d1, d2)
{
	return _Json_mapMany(f, [d1, d2]);
});

var _Json_map3 = F4(function(f, d1, d2, d3)
{
	return _Json_mapMany(f, [d1, d2, d3]);
});

var _Json_map4 = F5(function(f, d1, d2, d3, d4)
{
	return _Json_mapMany(f, [d1, d2, d3, d4]);
});

var _Json_map5 = F6(function(f, d1, d2, d3, d4, d5)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5]);
});

var _Json_map6 = F7(function(f, d1, d2, d3, d4, d5, d6)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6]);
});

var _Json_map7 = F8(function(f, d1, d2, d3, d4, d5, d6, d7)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
});

var _Json_map8 = F9(function(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
});


// DECODE

var _Json_runOnString = F2(function(decoder, string)
{
	try
	{
		var value = JSON.parse(string);
		return _Json_runHelp(decoder, value);
	}
	catch (e)
	{
		return elm$core$Result$Err(A2(elm$json$Json$Decode$Failure, 'This is not valid JSON! ' + e.message, _Json_wrap(string)));
	}
});

var _Json_run = F2(function(decoder, value)
{
	return _Json_runHelp(decoder, _Json_unwrap(value));
});

function _Json_runHelp(decoder, value)
{
	switch (decoder.$)
	{
		case 2:
			return decoder.b(value);

		case 5:
			return (value === null)
				? elm$core$Result$Ok(decoder.c)
				: _Json_expecting('null', value);

		case 3:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('a LIST', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _List_fromArray);

		case 4:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _Json_toElmArray);

		case 6:
			var field = decoder.d;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return _Json_expecting('an OBJECT with a field named `' + field + '`', value);
			}
			var result = _Json_runHelp(decoder.b, value[field]);
			return (elm$core$Result$isOk(result)) ? result : elm$core$Result$Err(A2(elm$json$Json$Decode$Field, field, result.a));

		case 7:
			var index = decoder.e;
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			if (index >= value.length)
			{
				return _Json_expecting('a LONGER array. Need index ' + index + ' but only see ' + value.length + ' entries', value);
			}
			var result = _Json_runHelp(decoder.b, value[index]);
			return (elm$core$Result$isOk(result)) ? result : elm$core$Result$Err(A2(elm$json$Json$Decode$Index, index, result.a));

		case 8:
			if (typeof value !== 'object' || value === null || _Json_isArray(value))
			{
				return _Json_expecting('an OBJECT', value);
			}

			var keyValuePairs = _List_Nil;
			// TODO test perf of Object.keys and switch when support is good enough
			for (var key in value)
			{
				if (value.hasOwnProperty(key))
				{
					var result = _Json_runHelp(decoder.b, value[key]);
					if (!elm$core$Result$isOk(result))
					{
						return elm$core$Result$Err(A2(elm$json$Json$Decode$Field, key, result.a));
					}
					keyValuePairs = _List_Cons(_Utils_Tuple2(key, result.a), keyValuePairs);
				}
			}
			return elm$core$Result$Ok(elm$core$List$reverse(keyValuePairs));

		case 9:
			var answer = decoder.f;
			var decoders = decoder.g;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = _Json_runHelp(decoders[i], value);
				if (!elm$core$Result$isOk(result))
				{
					return result;
				}
				answer = answer(result.a);
			}
			return elm$core$Result$Ok(answer);

		case 10:
			var result = _Json_runHelp(decoder.b, value);
			return (!elm$core$Result$isOk(result))
				? result
				: _Json_runHelp(decoder.h(result.a), value);

		case 11:
			var errors = _List_Nil;
			for (var temp = decoder.g; temp.b; temp = temp.b) // WHILE_CONS
			{
				var result = _Json_runHelp(temp.a, value);
				if (elm$core$Result$isOk(result))
				{
					return result;
				}
				errors = _List_Cons(result.a, errors);
			}
			return elm$core$Result$Err(elm$json$Json$Decode$OneOf(elm$core$List$reverse(errors)));

		case 1:
			return elm$core$Result$Err(A2(elm$json$Json$Decode$Failure, decoder.a, _Json_wrap(value)));

		case 0:
			return elm$core$Result$Ok(decoder.a);
	}
}

function _Json_runArrayDecoder(decoder, value, toElmValue)
{
	var len = value.length;
	var array = new Array(len);
	for (var i = 0; i < len; i++)
	{
		var result = _Json_runHelp(decoder, value[i]);
		if (!elm$core$Result$isOk(result))
		{
			return elm$core$Result$Err(A2(elm$json$Json$Decode$Index, i, result.a));
		}
		array[i] = result.a;
	}
	return elm$core$Result$Ok(toElmValue(array));
}

function _Json_isArray(value)
{
	return Array.isArray(value) || (typeof FileList === 'function' && value instanceof FileList);
}

function _Json_toElmArray(array)
{
	return A2(elm$core$Array$initialize, array.length, function(i) { return array[i]; });
}

function _Json_expecting(type, value)
{
	return elm$core$Result$Err(A2(elm$json$Json$Decode$Failure, 'Expecting ' + type, _Json_wrap(value)));
}


// EQUALITY

function _Json_equality(x, y)
{
	if (x === y)
	{
		return true;
	}

	if (x.$ !== y.$)
	{
		return false;
	}

	switch (x.$)
	{
		case 0:
		case 1:
			return x.a === y.a;

		case 2:
			return x.b === y.b;

		case 5:
			return x.c === y.c;

		case 3:
		case 4:
		case 8:
			return _Json_equality(x.b, y.b);

		case 6:
			return x.d === y.d && _Json_equality(x.b, y.b);

		case 7:
			return x.e === y.e && _Json_equality(x.b, y.b);

		case 9:
			return x.f === y.f && _Json_listEquality(x.g, y.g);

		case 10:
			return x.h === y.h && _Json_equality(x.b, y.b);

		case 11:
			return _Json_listEquality(x.g, y.g);
	}
}

function _Json_listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!_Json_equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

var _Json_encode = F2(function(indentLevel, value)
{
	return JSON.stringify(_Json_unwrap(value), null, indentLevel) + '';
});

function _Json_wrap(value) { return { $: 0, a: value }; }
function _Json_unwrap(value) { return value.a; }

function _Json_wrap_UNUSED(value) { return value; }
function _Json_unwrap_UNUSED(value) { return value; }

function _Json_emptyArray() { return []; }
function _Json_emptyObject() { return {}; }

var _Json_addField = F3(function(key, value, object)
{
	object[key] = _Json_unwrap(value);
	return object;
});

function _Json_addEntry(func)
{
	return F2(function(entry, array)
	{
		array.push(_Json_unwrap(func(entry)));
		return array;
	});
}

var _Json_encodeNull = _Json_wrap(null);



// TASKS

function _Scheduler_succeed(value)
{
	return {
		$: 0,
		a: value
	};
}

function _Scheduler_fail(error)
{
	return {
		$: 1,
		a: error
	};
}

function _Scheduler_binding(callback)
{
	return {
		$: 2,
		b: callback,
		c: null
	};
}

var _Scheduler_andThen = F2(function(callback, task)
{
	return {
		$: 3,
		b: callback,
		d: task
	};
});

var _Scheduler_onError = F2(function(callback, task)
{
	return {
		$: 4,
		b: callback,
		d: task
	};
});

function _Scheduler_receive(callback)
{
	return {
		$: 5,
		b: callback
	};
}


// PROCESSES

var _Scheduler_guid = 0;

function _Scheduler_rawSpawn(task)
{
	var proc = {
		$: 0,
		e: _Scheduler_guid++,
		f: task,
		g: null,
		h: []
	};

	_Scheduler_enqueue(proc);

	return proc;
}

function _Scheduler_spawn(task)
{
	return _Scheduler_binding(function(callback) {
		callback(_Scheduler_succeed(_Scheduler_rawSpawn(task)));
	});
}

function _Scheduler_rawSend(proc, msg)
{
	proc.h.push(msg);
	_Scheduler_enqueue(proc);
}

var _Scheduler_send = F2(function(proc, msg)
{
	return _Scheduler_binding(function(callback) {
		_Scheduler_rawSend(proc, msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});

function _Scheduler_kill(proc)
{
	return _Scheduler_binding(function(callback) {
		var task = proc.f;
		if (task.$ === 2 && task.c)
		{
			task.c();
		}

		proc.f = null;

		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


/* STEP PROCESSES

type alias Process =
  { $ : tag
  , id : unique_id
  , root : Task
  , stack : null | { $: SUCCEED | FAIL, a: callback, b: stack }
  , mailbox : [msg]
  }

*/


var _Scheduler_working = false;
var _Scheduler_queue = [];


function _Scheduler_enqueue(proc)
{
	_Scheduler_queue.push(proc);
	if (_Scheduler_working)
	{
		return;
	}
	_Scheduler_working = true;
	while (proc = _Scheduler_queue.shift())
	{
		_Scheduler_step(proc);
	}
	_Scheduler_working = false;
}


function _Scheduler_step(proc)
{
	while (proc.f)
	{
		var rootTag = proc.f.$;
		if (rootTag === 0 || rootTag === 1)
		{
			while (proc.g && proc.g.$ !== rootTag)
			{
				proc.g = proc.g.i;
			}
			if (!proc.g)
			{
				return;
			}
			proc.f = proc.g.b(proc.f.a);
			proc.g = proc.g.i;
		}
		else if (rootTag === 2)
		{
			proc.f.c = proc.f.b(function(newRoot) {
				proc.f = newRoot;
				_Scheduler_enqueue(proc);
			});
			return;
		}
		else if (rootTag === 5)
		{
			if (proc.h.length === 0)
			{
				return;
			}
			proc.f = proc.f.b(proc.h.shift());
		}
		else // if (rootTag === 3 || rootTag === 4)
		{
			proc.g = {
				$: rootTag === 3 ? 0 : 1,
				b: proc.f.b,
				i: proc.g
			};
			proc.f = proc.f.d;
		}
	}
}



function _Process_sleep(time)
{
	return _Scheduler_binding(function(callback) {
		var id = setTimeout(function() {
			callback(_Scheduler_succeed(_Utils_Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}




// PROGRAMS


var _Platform_worker = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	elm$core$Result$isOk(result) || _Debug_crash(2 /**/, _Json_errorToString(result.a) /**/);
	var managers = {};
	result = init(result.a);
	var model = result.a;
	var stepper = stepperBuilder(sendToApp, model);
	var ports = _Platform_setupEffects(managers, sendToApp);

	function sendToApp(msg, viewMetadata)
	{
		result = A2(update, msg, model);
		stepper(model = result.a, viewMetadata);
		_Platform_dispatchEffects(managers, result.b, subscriptions(model));
	}

	_Platform_dispatchEffects(managers, result.b, subscriptions(model));

	return ports ? { ports: ports } : {};
}



// TRACK PRELOADS
//
// This is used by code in elm/browser and elm/http
// to register any HTTP requests that are triggered by init.
//


var _Platform_preload;


function _Platform_registerPreload(url)
{
	_Platform_preload.add(url);
}



// EFFECT MANAGERS


var _Platform_effectManagers = {};


function _Platform_setupEffects(managers, sendToApp)
{
	var ports;

	// setup all necessary effect managers
	for (var key in _Platform_effectManagers)
	{
		var manager = _Platform_effectManagers[key];

		if (manager.a)
		{
			ports = ports || {};
			ports[key] = manager.a(key, sendToApp);
		}

		managers[key] = _Platform_instantiateManager(manager, sendToApp);
	}

	return ports;
}


function _Platform_createManager(init, onEffects, onSelfMsg, cmdMap, subMap)
{
	return {
		b: init,
		c: onEffects,
		d: onSelfMsg,
		e: cmdMap,
		f: subMap
	};
}


function _Platform_instantiateManager(info, sendToApp)
{
	var router = {
		g: sendToApp,
		h: undefined
	};

	var onEffects = info.c;
	var onSelfMsg = info.d;
	var cmdMap = info.e;
	var subMap = info.f;

	function loop(state)
	{
		return A2(_Scheduler_andThen, loop, _Scheduler_receive(function(msg)
		{
			var value = msg.a;

			if (msg.$ === 0)
			{
				return A3(onSelfMsg, router, value, state);
			}

			return cmdMap && subMap
				? A4(onEffects, router, value.i, value.j, state)
				: A3(onEffects, router, cmdMap ? value.i : value.j, state);
		}));
	}

	return router.h = _Scheduler_rawSpawn(A2(_Scheduler_andThen, loop, info.b));
}



// ROUTING


var _Platform_sendToApp = F2(function(router, msg)
{
	return _Scheduler_binding(function(callback)
	{
		router.g(msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});


var _Platform_sendToSelf = F2(function(router, msg)
{
	return A2(_Scheduler_send, router.h, {
		$: 0,
		a: msg
	});
});



// BAGS


function _Platform_leaf(home)
{
	return function(value)
	{
		return {
			$: 1,
			k: home,
			l: value
		};
	};
}


function _Platform_batch(list)
{
	return {
		$: 2,
		m: list
	};
}


var _Platform_map = F2(function(tagger, bag)
{
	return {
		$: 3,
		n: tagger,
		o: bag
	}
});



// PIPE BAGS INTO EFFECT MANAGERS


function _Platform_dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	_Platform_gatherEffects(true, cmdBag, effectsDict, null);
	_Platform_gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		_Scheduler_rawSend(managers[home], {
			$: 'fx',
			a: effectsDict[home] || { i: _List_Nil, j: _List_Nil }
		});
	}
}


function _Platform_gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.$)
	{
		case 1:
			var home = bag.k;
			var effect = _Platform_toEffect(isCmd, home, taggers, bag.l);
			effectsDict[home] = _Platform_insert(isCmd, effect, effectsDict[home]);
			return;

		case 2:
			for (var list = bag.m; list.b; list = list.b) // WHILE_CONS
			{
				_Platform_gatherEffects(isCmd, list.a, effectsDict, taggers);
			}
			return;

		case 3:
			_Platform_gatherEffects(isCmd, bag.o, effectsDict, {
				p: bag.n,
				q: taggers
			});
			return;
	}
}


function _Platform_toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		for (var temp = taggers; temp; temp = temp.q)
		{
			x = temp.p(x);
		}
		return x;
	}

	var map = isCmd
		? _Platform_effectManagers[home].e
		: _Platform_effectManagers[home].f;

	return A2(map, applyTaggers, value)
}


function _Platform_insert(isCmd, newEffect, effects)
{
	effects = effects || { i: _List_Nil, j: _List_Nil };

	isCmd
		? (effects.i = _List_Cons(newEffect, effects.i))
		: (effects.j = _List_Cons(newEffect, effects.j));

	return effects;
}



// PORTS


function _Platform_checkPortName(name)
{
	if (_Platform_effectManagers[name])
	{
		_Debug_crash(3, name)
	}
}



// OUTGOING PORTS


function _Platform_outgoingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		e: _Platform_outgoingPortMap,
		r: converter,
		a: _Platform_setupOutgoingPort
	};
	return _Platform_leaf(name);
}


var _Platform_outgoingPortMap = F2(function(tagger, value) { return value; });


function _Platform_setupOutgoingPort(name)
{
	var subs = [];
	var converter = _Platform_effectManagers[name].r;

	// CREATE MANAGER

	var init = _Process_sleep(0);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, cmdList, state)
	{
		for ( ; cmdList.b; cmdList = cmdList.b) // WHILE_CONS
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = _Json_unwrap(converter(cmdList.a));
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
		}
		return init;
	});

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}



// INCOMING PORTS


function _Platform_incomingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		f: _Platform_incomingPortMap,
		r: converter,
		a: _Platform_setupIncomingPort
	};
	return _Platform_leaf(name);
}


var _Platform_incomingPortMap = F2(function(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});


function _Platform_setupIncomingPort(name, sendToApp)
{
	var subs = _List_Nil;
	var converter = _Platform_effectManagers[name].r;

	// CREATE MANAGER

	var init = _Scheduler_succeed(null);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, subList, state)
	{
		subs = subList;
		return init;
	});

	// PUBLIC API

	function send(incomingValue)
	{
		var result = A2(_Json_run, converter, _Json_wrap(incomingValue));

		elm$core$Result$isOk(result) || _Debug_crash(4, name, result.a);

		var value = result.a;
		for (var temp = subs; temp.b; temp = temp.b) // WHILE_CONS
		{
			sendToApp(temp.a(value));
		}
	}

	return { send: send };
}



// EXPORT ELM MODULES
//
// Have DEBUG and PROD versions so that we can (1) give nicer errors in
// debug mode and (2) not pay for the bits needed for that in prod mode.
//


function _Platform_export_UNUSED(exports)
{
	scope['Elm']
		? _Platform_mergeExportsProd(scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsProd(obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6)
				: _Platform_mergeExportsProd(obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}


function _Platform_export(exports)
{
	scope['Elm']
		? _Platform_mergeExportsDebug('Elm', scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsDebug(moduleName, obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6, moduleName)
				: _Platform_mergeExportsDebug(moduleName + '.' + name, obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}




// HELPERS


var _VirtualDom_divertHrefToApp;

var _VirtualDom_doc = typeof document !== 'undefined' ? document : {};


function _VirtualDom_appendChild(parent, child)
{
	parent.appendChild(child);
}

var _VirtualDom_init = F4(function(virtualNode, flagDecoder, debugMetadata, args)
{
	// NOTE: this function needs _Platform_export available to work

	/**_UNUSED/
	var node = args['node'];
	//*/
	/**/
	var node = args && args['node'] ? args['node'] : _Debug_crash(0);
	//*/

	node.parentNode.replaceChild(
		_VirtualDom_render(virtualNode, function() {}),
		node
	);

	return {};
});



// TEXT


function _VirtualDom_text(string)
{
	return {
		$: 0,
		a: string
	};
}



// NODE


var _VirtualDom_nodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 1,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_node = _VirtualDom_nodeNS(undefined);



// KEYED NODE


var _VirtualDom_keyedNodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 2,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_keyedNode = _VirtualDom_keyedNodeNS(undefined);



// CUSTOM


function _VirtualDom_custom(factList, model, render, diff)
{
	return {
		$: 3,
		d: _VirtualDom_organizeFacts(factList),
		g: model,
		h: render,
		i: diff
	};
}



// MAP


var _VirtualDom_map = F2(function(tagger, node)
{
	return {
		$: 4,
		j: tagger,
		k: node,
		b: 1 + (node.b || 0)
	};
});



// LAZY


function _VirtualDom_thunk(refs, thunk)
{
	return {
		$: 5,
		l: refs,
		m: thunk,
		k: undefined
	};
}

var _VirtualDom_lazy = F2(function(func, a)
{
	return _VirtualDom_thunk([func, a], function() {
		return func(a);
	});
});

var _VirtualDom_lazy2 = F3(function(func, a, b)
{
	return _VirtualDom_thunk([func, a, b], function() {
		return A2(func, a, b);
	});
});

var _VirtualDom_lazy3 = F4(function(func, a, b, c)
{
	return _VirtualDom_thunk([func, a, b, c], function() {
		return A3(func, a, b, c);
	});
});

var _VirtualDom_lazy4 = F5(function(func, a, b, c, d)
{
	return _VirtualDom_thunk([func, a, b, c, d], function() {
		return A4(func, a, b, c, d);
	});
});

var _VirtualDom_lazy5 = F6(function(func, a, b, c, d, e)
{
	return _VirtualDom_thunk([func, a, b, c, d, e], function() {
		return A5(func, a, b, c, d, e);
	});
});

var _VirtualDom_lazy6 = F7(function(func, a, b, c, d, e, f)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f], function() {
		return A6(func, a, b, c, d, e, f);
	});
});

var _VirtualDom_lazy7 = F8(function(func, a, b, c, d, e, f, g)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g], function() {
		return A7(func, a, b, c, d, e, f, g);
	});
});

var _VirtualDom_lazy8 = F9(function(func, a, b, c, d, e, f, g, h)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g, h], function() {
		return A8(func, a, b, c, d, e, f, g, h);
	});
});



// FACTS


var _VirtualDom_on = F2(function(key, handler)
{
	return {
		$: 'a0',
		n: key,
		o: handler
	};
});
var _VirtualDom_style = F2(function(key, value)
{
	return {
		$: 'a1',
		n: key,
		o: value
	};
});
var _VirtualDom_property = F2(function(key, value)
{
	return {
		$: 'a2',
		n: key,
		o: value
	};
});
var _VirtualDom_attribute = F2(function(key, value)
{
	return {
		$: 'a3',
		n: key,
		o: value
	};
});
var _VirtualDom_attributeNS = F3(function(namespace, key, value)
{
	return {
		$: 'a4',
		n: key,
		o: { f: namespace, o: value }
	};
});



// XSS ATTACK VECTOR CHECKS


function _VirtualDom_noScript(tag)
{
	return tag == 'script' ? 'p' : tag;
}

function _VirtualDom_noOnOrFormAction(key)
{
	return /^(on|formAction$)/i.test(key) ? 'data-' + key : key;
}

function _VirtualDom_noInnerHtmlOrFormAction(key)
{
	return key == 'innerHTML' || key == 'formAction' ? 'data-' + key : key;
}

function _VirtualDom_noJavaScriptUri_UNUSED(value)
{
	return /^javascript:/i.test(value.replace(/\s/g,'')) ? '' : value;
}

function _VirtualDom_noJavaScriptUri(value)
{
	return /^javascript:/i.test(value.replace(/\s/g,''))
		? 'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'
		: value;
}

function _VirtualDom_noJavaScriptOrHtmlUri_UNUSED(value)
{
	return /^\s*(javascript:|data:text\/html)/i.test(value) ? '' : value;
}

function _VirtualDom_noJavaScriptOrHtmlUri(value)
{
	return /^\s*(javascript:|data:text\/html)/i.test(value)
		? 'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'
		: value;
}



// MAP FACTS


var _VirtualDom_mapAttribute = F2(function(func, attr)
{
	return (attr.$ === 'a0')
		? A2(_VirtualDom_on, attr.n, _VirtualDom_mapHandler(func, attr.o))
		: attr;
});

function _VirtualDom_mapHandler(func, handler)
{
	var tag = elm$virtual_dom$VirtualDom$toHandlerInt(handler);

	// 0 = Normal
	// 1 = MayStopPropagation
	// 2 = MayPreventDefault
	// 3 = Custom

	return {
		$: handler.$,
		a:
			!tag
				? A2(elm$json$Json$Decode$map, func, handler.a)
				:
			A3(elm$json$Json$Decode$map2,
				tag < 3
					? _VirtualDom_mapEventTuple
					: _VirtualDom_mapEventRecord,
				elm$json$Json$Decode$succeed(func),
				handler.a
			)
	};
}

var _VirtualDom_mapEventTuple = F2(function(func, tuple)
{
	return _Utils_Tuple2(func(tuple.a), tuple.b);
});

var _VirtualDom_mapEventRecord = F2(function(func, record)
{
	return {
		message: func(record.message),
		stopPropagation: record.stopPropagation,
		preventDefault: record.preventDefault
	}
});



// ORGANIZE FACTS


function _VirtualDom_organizeFacts(factList)
{
	for (var facts = {}; factList.b; factList = factList.b) // WHILE_CONS
	{
		var entry = factList.a;

		var tag = entry.$;
		var key = entry.n;
		var value = entry.o;

		if (tag === 'a2')
		{
			(key === 'className')
				? _VirtualDom_addClass(facts, key, _Json_unwrap(value))
				: facts[key] = _Json_unwrap(value);

			continue;
		}

		var subFacts = facts[tag] || (facts[tag] = {});
		(tag === 'a3' && key === 'class')
			? _VirtualDom_addClass(subFacts, key, value)
			: subFacts[key] = value;
	}

	return facts;
}

function _VirtualDom_addClass(object, key, newClass)
{
	var classes = object[key];
	object[key] = classes ? classes + ' ' + newClass : newClass;
}



// RENDER


function _VirtualDom_render(vNode, eventNode)
{
	var tag = vNode.$;

	if (tag === 5)
	{
		return _VirtualDom_render(vNode.k || (vNode.k = vNode.m()), eventNode);
	}

	if (tag === 0)
	{
		return _VirtualDom_doc.createTextNode(vNode.a);
	}

	if (tag === 4)
	{
		var subNode = vNode.k;
		var tagger = vNode.j;

		while (subNode.$ === 4)
		{
			typeof tagger !== 'object'
				? tagger = [tagger, subNode.j]
				: tagger.push(subNode.j);

			subNode = subNode.k;
		}

		var subEventRoot = { j: tagger, p: eventNode };
		var domNode = _VirtualDom_render(subNode, subEventRoot);
		domNode.elm_event_node_ref = subEventRoot;
		return domNode;
	}

	if (tag === 3)
	{
		var domNode = vNode.h(vNode.g);
		_VirtualDom_applyFacts(domNode, eventNode, vNode.d);
		return domNode;
	}

	// at this point `tag` must be 1 or 2

	var domNode = vNode.f
		? _VirtualDom_doc.createElementNS(vNode.f, vNode.c)
		: _VirtualDom_doc.createElement(vNode.c);

	if (_VirtualDom_divertHrefToApp && vNode.c == 'a')
	{
		domNode.addEventListener('click', _VirtualDom_divertHrefToApp(domNode));
	}

	_VirtualDom_applyFacts(domNode, eventNode, vNode.d);

	for (var kids = vNode.e, i = 0; i < kids.length; i++)
	{
		_VirtualDom_appendChild(domNode, _VirtualDom_render(tag === 1 ? kids[i] : kids[i].b, eventNode));
	}

	return domNode;
}



// APPLY FACTS


function _VirtualDom_applyFacts(domNode, eventNode, facts)
{
	for (var key in facts)
	{
		var value = facts[key];

		key === 'a1'
			? _VirtualDom_applyStyles(domNode, value)
			:
		key === 'a0'
			? _VirtualDom_applyEvents(domNode, eventNode, value)
			:
		key === 'a3'
			? _VirtualDom_applyAttrs(domNode, value)
			:
		key === 'a4'
			? _VirtualDom_applyAttrsNS(domNode, value)
			:
		((key !== 'value' && key !== 'checked') || domNode[key] !== value) && (domNode[key] = value);
	}
}



// APPLY STYLES


function _VirtualDom_applyStyles(domNode, styles)
{
	var domNodeStyle = domNode.style;

	for (var key in styles)
	{
		domNodeStyle[key] = styles[key];
	}
}



// APPLY ATTRS


function _VirtualDom_applyAttrs(domNode, attrs)
{
	for (var key in attrs)
	{
		var value = attrs[key];
		typeof value !== 'undefined'
			? domNode.setAttribute(key, value)
			: domNode.removeAttribute(key);
	}
}



// APPLY NAMESPACED ATTRS


function _VirtualDom_applyAttrsNS(domNode, nsAttrs)
{
	for (var key in nsAttrs)
	{
		var pair = nsAttrs[key];
		var namespace = pair.f;
		var value = pair.o;

		typeof value !== 'undefined'
			? domNode.setAttributeNS(namespace, key, value)
			: domNode.removeAttributeNS(namespace, key);
	}
}



// APPLY EVENTS


function _VirtualDom_applyEvents(domNode, eventNode, events)
{
	var allCallbacks = domNode.elmFs || (domNode.elmFs = {});

	for (var key in events)
	{
		var newHandler = events[key];
		var oldCallback = allCallbacks[key];

		if (!newHandler)
		{
			domNode.removeEventListener(key, oldCallback);
			allCallbacks[key] = undefined;
			continue;
		}

		if (oldCallback)
		{
			var oldHandler = oldCallback.q;
			if (oldHandler.$ === newHandler.$)
			{
				oldCallback.q = newHandler;
				continue;
			}
			domNode.removeEventListener(key, oldCallback);
		}

		oldCallback = _VirtualDom_makeCallback(eventNode, newHandler);
		domNode.addEventListener(key, oldCallback,
			_VirtualDom_passiveSupported
			&& { passive: elm$virtual_dom$VirtualDom$toHandlerInt(newHandler) < 2 }
		);
		allCallbacks[key] = oldCallback;
	}
}



// PASSIVE EVENTS


var _VirtualDom_passiveSupported;

try
{
	window.addEventListener('t', null, Object.defineProperty({}, 'passive', {
		get: function() { _VirtualDom_passiveSupported = true; }
	}));
}
catch(e) {}



// EVENT HANDLERS


function _VirtualDom_makeCallback(eventNode, initialHandler)
{
	function callback(event)
	{
		var handler = callback.q;
		var result = _Json_runHelp(handler.a, event);

		if (!elm$core$Result$isOk(result))
		{
			return;
		}

		var tag = elm$virtual_dom$VirtualDom$toHandlerInt(handler);

		// 0 = Normal
		// 1 = MayStopPropagation
		// 2 = MayPreventDefault
		// 3 = Custom

		var value = result.a;
		var message = !tag ? value : tag < 3 ? value.a : value.message;
		var stopPropagation = tag == 1 ? value.b : tag == 3 && value.stopPropagation;
		var currentEventNode = (
			stopPropagation && event.stopPropagation(),
			(tag == 2 ? value.b : tag == 3 && value.preventDefault) && event.preventDefault(),
			eventNode
		);
		var tagger;
		var i;
		while (tagger = currentEventNode.j)
		{
			if (typeof tagger == 'function')
			{
				message = tagger(message);
			}
			else
			{
				for (var i = tagger.length; i--; )
				{
					message = tagger[i](message);
				}
			}
			currentEventNode = currentEventNode.p;
		}
		currentEventNode(message, stopPropagation); // stopPropagation implies isSync
	}

	callback.q = initialHandler;

	return callback;
}

function _VirtualDom_equalEvents(x, y)
{
	return x.$ == y.$ && _Json_equality(x.a, y.a);
}



// DIFF


// TODO: Should we do patches like in iOS?
//
// type Patch
//   = At Int Patch
//   | Batch (List Patch)
//   | Change ...
//
// How could it not be better?
//
function _VirtualDom_diff(x, y)
{
	var patches = [];
	_VirtualDom_diffHelp(x, y, patches, 0);
	return patches;
}


function _VirtualDom_pushPatch(patches, type, index, data)
{
	var patch = {
		$: type,
		r: index,
		s: data,
		t: undefined,
		u: undefined
	};
	patches.push(patch);
	return patch;
}


function _VirtualDom_diffHelp(x, y, patches, index)
{
	if (x === y)
	{
		return;
	}

	var xType = x.$;
	var yType = y.$;

	// Bail if you run into different types of nodes. Implies that the
	// structure has changed significantly and it's not worth a diff.
	if (xType !== yType)
	{
		if (xType === 1 && yType === 2)
		{
			y = _VirtualDom_dekey(y);
			yType = 1;
		}
		else
		{
			_VirtualDom_pushPatch(patches, 0, index, y);
			return;
		}
	}

	// Now we know that both nodes are the same $.
	switch (yType)
	{
		case 5:
			var xRefs = x.l;
			var yRefs = y.l;
			var i = xRefs.length;
			var same = i === yRefs.length;
			while (same && i--)
			{
				same = xRefs[i] === yRefs[i];
			}
			if (same)
			{
				y.k = x.k;
				return;
			}
			y.k = y.m();
			var subPatches = [];
			_VirtualDom_diffHelp(x.k, y.k, subPatches, 0);
			subPatches.length > 0 && _VirtualDom_pushPatch(patches, 1, index, subPatches);
			return;

		case 4:
			// gather nested taggers
			var xTaggers = x.j;
			var yTaggers = y.j;
			var nesting = false;

			var xSubNode = x.k;
			while (xSubNode.$ === 4)
			{
				nesting = true;

				typeof xTaggers !== 'object'
					? xTaggers = [xTaggers, xSubNode.j]
					: xTaggers.push(xSubNode.j);

				xSubNode = xSubNode.k;
			}

			var ySubNode = y.k;
			while (ySubNode.$ === 4)
			{
				nesting = true;

				typeof yTaggers !== 'object'
					? yTaggers = [yTaggers, ySubNode.j]
					: yTaggers.push(ySubNode.j);

				ySubNode = ySubNode.k;
			}

			// Just bail if different numbers of taggers. This implies the
			// structure of the virtual DOM has changed.
			if (nesting && xTaggers.length !== yTaggers.length)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			// check if taggers are "the same"
			if (nesting ? !_VirtualDom_pairwiseRefEqual(xTaggers, yTaggers) : xTaggers !== yTaggers)
			{
				_VirtualDom_pushPatch(patches, 2, index, yTaggers);
			}

			// diff everything below the taggers
			_VirtualDom_diffHelp(xSubNode, ySubNode, patches, index + 1);
			return;

		case 0:
			if (x.a !== y.a)
			{
				_VirtualDom_pushPatch(patches, 3, index, y.a);
			}
			return;

		case 1:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKids);
			return;

		case 2:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKeyedKids);
			return;

		case 3:
			if (x.h !== y.h)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
			factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

			var patch = y.i(x.g, y.g);
			patch && _VirtualDom_pushPatch(patches, 5, index, patch);

			return;
	}
}

// assumes the incoming arrays are the same length
function _VirtualDom_pairwiseRefEqual(as, bs)
{
	for (var i = 0; i < as.length; i++)
	{
		if (as[i] !== bs[i])
		{
			return false;
		}
	}

	return true;
}

function _VirtualDom_diffNodes(x, y, patches, index, diffKids)
{
	// Bail if obvious indicators have changed. Implies more serious
	// structural changes such that it's not worth it to diff.
	if (x.c !== y.c || x.f !== y.f)
	{
		_VirtualDom_pushPatch(patches, 0, index, y);
		return;
	}

	var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
	factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

	diffKids(x, y, patches, index);
}



// DIFF FACTS


// TODO Instead of creating a new diff object, it's possible to just test if
// there *is* a diff. During the actual patch, do the diff again and make the
// modifications directly. This way, there's no new allocations. Worth it?
function _VirtualDom_diffFacts(x, y, category)
{
	var diff;

	// look for changes and removals
	for (var xKey in x)
	{
		if (xKey === 'a1' || xKey === 'a0' || xKey === 'a3' || xKey === 'a4')
		{
			var subDiff = _VirtualDom_diffFacts(x[xKey], y[xKey] || {}, xKey);
			if (subDiff)
			{
				diff = diff || {};
				diff[xKey] = subDiff;
			}
			continue;
		}

		// remove if not in the new facts
		if (!(xKey in y))
		{
			diff = diff || {};
			diff[xKey] =
				!category
					? (typeof x[xKey] === 'string' ? '' : null)
					:
				(category === 'a1')
					? ''
					:
				(category === 'a0' || category === 'a3')
					? undefined
					:
				{ f: x[xKey].f, o: undefined };

			continue;
		}

		var xValue = x[xKey];
		var yValue = y[xKey];

		// reference equal, so don't worry about it
		if (xValue === yValue && xKey !== 'value' && xKey !== 'checked'
			|| category === 'a0' && _VirtualDom_equalEvents(xValue, yValue))
		{
			continue;
		}

		diff = diff || {};
		diff[xKey] = yValue;
	}

	// add new stuff
	for (var yKey in y)
	{
		if (!(yKey in x))
		{
			diff = diff || {};
			diff[yKey] = y[yKey];
		}
	}

	return diff;
}



// DIFF KIDS


function _VirtualDom_diffKids(xParent, yParent, patches, index)
{
	var xKids = xParent.e;
	var yKids = yParent.e;

	var xLen = xKids.length;
	var yLen = yKids.length;

	// FIGURE OUT IF THERE ARE INSERTS OR REMOVALS

	if (xLen > yLen)
	{
		_VirtualDom_pushPatch(patches, 6, index, {
			v: yLen,
			i: xLen - yLen
		});
	}
	else if (xLen < yLen)
	{
		_VirtualDom_pushPatch(patches, 7, index, {
			v: xLen,
			e: yKids
		});
	}

	// PAIRWISE DIFF EVERYTHING ELSE

	for (var minLen = xLen < yLen ? xLen : yLen, i = 0; i < minLen; i++)
	{
		var xKid = xKids[i];
		_VirtualDom_diffHelp(xKid, yKids[i], patches, ++index);
		index += xKid.b || 0;
	}
}



// KEYED DIFF


function _VirtualDom_diffKeyedKids(xParent, yParent, patches, rootIndex)
{
	var localPatches = [];

	var changes = {}; // Dict String Entry
	var inserts = []; // Array { index : Int, entry : Entry }
	// type Entry = { tag : String, vnode : VNode, index : Int, data : _ }

	var xKids = xParent.e;
	var yKids = yParent.e;
	var xLen = xKids.length;
	var yLen = yKids.length;
	var xIndex = 0;
	var yIndex = 0;

	var index = rootIndex;

	while (xIndex < xLen && yIndex < yLen)
	{
		var x = xKids[xIndex];
		var y = yKids[yIndex];

		var xKey = x.a;
		var yKey = y.a;
		var xNode = x.b;
		var yNode = y.b;

		var newMatch = undefined;
		var oldMatch = undefined;

		// check if keys match

		if (xKey === yKey)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNode, localPatches, index);
			index += xNode.b || 0;

			xIndex++;
			yIndex++;
			continue;
		}

		// look ahead 1 to detect insertions and removals.

		var xNext = xKids[xIndex + 1];
		var yNext = yKids[yIndex + 1];

		if (xNext)
		{
			var xNextKey = xNext.a;
			var xNextNode = xNext.b;
			oldMatch = yKey === xNextKey;
		}

		if (yNext)
		{
			var yNextKey = yNext.a;
			var yNextNode = yNext.b;
			newMatch = xKey === yNextKey;
		}


		// swap x and y
		if (newMatch && oldMatch)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			_VirtualDom_insertNode(changes, localPatches, xKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNextNode, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		// insert y
		if (newMatch)
		{
			index++;
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			index += xNode.b || 0;

			xIndex += 1;
			yIndex += 2;
			continue;
		}

		// remove x
		if (oldMatch)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 1;
			continue;
		}

		// remove x, insert y
		if (xNext && xNextKey === yNextKey)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNextNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		break;
	}

	// eat up any remaining nodes with removeNode and insertNode

	while (xIndex < xLen)
	{
		index++;
		var x = xKids[xIndex];
		var xNode = x.b;
		_VirtualDom_removeNode(changes, localPatches, x.a, xNode, index);
		index += xNode.b || 0;
		xIndex++;
	}

	while (yIndex < yLen)
	{
		var endInserts = endInserts || [];
		var y = yKids[yIndex];
		_VirtualDom_insertNode(changes, localPatches, y.a, y.b, undefined, endInserts);
		yIndex++;
	}

	if (localPatches.length > 0 || inserts.length > 0 || endInserts)
	{
		_VirtualDom_pushPatch(patches, 8, rootIndex, {
			w: localPatches,
			x: inserts,
			y: endInserts
		});
	}
}



// CHANGES FROM KEYED DIFF


var _VirtualDom_POSTFIX = '_elmW6BL';


function _VirtualDom_insertNode(changes, localPatches, key, vnode, yIndex, inserts)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		entry = {
			c: 0,
			z: vnode,
			r: yIndex,
			s: undefined
		};

		inserts.push({ r: yIndex, A: entry });
		changes[key] = entry;

		return;
	}

	// this key was removed earlier, a match!
	if (entry.c === 1)
	{
		inserts.push({ r: yIndex, A: entry });

		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(entry.z, vnode, subPatches, entry.r);
		entry.r = yIndex;
		entry.s.s = {
			w: subPatches,
			A: entry
		};

		return;
	}

	// this key has already been inserted or moved, a duplicate!
	_VirtualDom_insertNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, yIndex, inserts);
}


function _VirtualDom_removeNode(changes, localPatches, key, vnode, index)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		var patch = _VirtualDom_pushPatch(localPatches, 9, index, undefined);

		changes[key] = {
			c: 1,
			z: vnode,
			r: index,
			s: patch
		};

		return;
	}

	// this key was inserted earlier, a match!
	if (entry.c === 0)
	{
		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(vnode, entry.z, subPatches, index);

		_VirtualDom_pushPatch(localPatches, 9, index, {
			w: subPatches,
			A: entry
		});

		return;
	}

	// this key has already been removed or moved, a duplicate!
	_VirtualDom_removeNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, index);
}



// ADD DOM NODES
//
// Each DOM node has an "index" assigned in order of traversal. It is important
// to minimize our crawl over the actual DOM, so these indexes (along with the
// descendantsCount of virtual nodes) let us skip touching entire subtrees of
// the DOM if we know there are no patches there.


function _VirtualDom_addDomNodes(domNode, vNode, patches, eventNode)
{
	_VirtualDom_addDomNodesHelp(domNode, vNode, patches, 0, 0, vNode.b, eventNode);
}


// assumes `patches` is non-empty and indexes increase monotonically.
function _VirtualDom_addDomNodesHelp(domNode, vNode, patches, i, low, high, eventNode)
{
	var patch = patches[i];
	var index = patch.r;

	while (index === low)
	{
		var patchType = patch.$;

		if (patchType === 1)
		{
			_VirtualDom_addDomNodes(domNode, vNode.k, patch.s, eventNode);
		}
		else if (patchType === 8)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var subPatches = patch.s.w;
			if (subPatches.length > 0)
			{
				_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
			}
		}
		else if (patchType === 9)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var data = patch.s;
			if (data)
			{
				data.A.s = domNode;
				var subPatches = data.w;
				if (subPatches.length > 0)
				{
					_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
				}
			}
		}
		else
		{
			patch.t = domNode;
			patch.u = eventNode;
		}

		i++;

		if (!(patch = patches[i]) || (index = patch.r) > high)
		{
			return i;
		}
	}

	var tag = vNode.$;

	if (tag === 4)
	{
		var subNode = vNode.k;

		while (subNode.$ === 4)
		{
			subNode = subNode.k;
		}

		return _VirtualDom_addDomNodesHelp(domNode, subNode, patches, i, low + 1, high, domNode.elm_event_node_ref);
	}

	// tag must be 1 or 2 at this point

	var vKids = vNode.e;
	var childNodes = domNode.childNodes;
	for (var j = 0; j < vKids.length; j++)
	{
		low++;
		var vKid = tag === 1 ? vKids[j] : vKids[j].b;
		var nextLow = low + (vKid.b || 0);
		if (low <= index && index <= nextLow)
		{
			i = _VirtualDom_addDomNodesHelp(childNodes[j], vKid, patches, i, low, nextLow, eventNode);
			if (!(patch = patches[i]) || (index = patch.r) > high)
			{
				return i;
			}
		}
		low = nextLow;
	}
	return i;
}



// APPLY PATCHES


function _VirtualDom_applyPatches(rootDomNode, oldVirtualNode, patches, eventNode)
{
	if (patches.length === 0)
	{
		return rootDomNode;
	}

	_VirtualDom_addDomNodes(rootDomNode, oldVirtualNode, patches, eventNode);
	return _VirtualDom_applyPatchesHelp(rootDomNode, patches);
}

function _VirtualDom_applyPatchesHelp(rootDomNode, patches)
{
	for (var i = 0; i < patches.length; i++)
	{
		var patch = patches[i];
		var localDomNode = patch.t
		var newNode = _VirtualDom_applyPatch(localDomNode, patch);
		if (localDomNode === rootDomNode)
		{
			rootDomNode = newNode;
		}
	}
	return rootDomNode;
}

function _VirtualDom_applyPatch(domNode, patch)
{
	switch (patch.$)
	{
		case 0:
			return _VirtualDom_applyPatchRedraw(domNode, patch.s, patch.u);

		case 4:
			_VirtualDom_applyFacts(domNode, patch.u, patch.s);
			return domNode;

		case 3:
			domNode.replaceData(0, domNode.length, patch.s);
			return domNode;

		case 1:
			return _VirtualDom_applyPatchesHelp(domNode, patch.s);

		case 2:
			if (domNode.elm_event_node_ref)
			{
				domNode.elm_event_node_ref.j = patch.s;
			}
			else
			{
				domNode.elm_event_node_ref = { j: patch.s, p: patch.u };
			}
			return domNode;

		case 6:
			var data = patch.s;
			for (var i = 0; i < data.i; i++)
			{
				domNode.removeChild(domNode.childNodes[data.v]);
			}
			return domNode;

		case 7:
			var data = patch.s;
			var kids = data.e;
			var i = data.v;
			var theEnd = domNode.childNodes[i];
			for (; i < kids.length; i++)
			{
				domNode.insertBefore(_VirtualDom_render(kids[i], patch.u), theEnd);
			}
			return domNode;

		case 9:
			var data = patch.s;
			if (!data)
			{
				domNode.parentNode.removeChild(domNode);
				return domNode;
			}
			var entry = data.A;
			if (typeof entry.r !== 'undefined')
			{
				domNode.parentNode.removeChild(domNode);
			}
			entry.s = _VirtualDom_applyPatchesHelp(domNode, data.w);
			return domNode;

		case 8:
			return _VirtualDom_applyPatchReorder(domNode, patch);

		case 5:
			return patch.s(domNode);

		default:
			_Debug_crash(10); // 'Ran into an unknown patch!'
	}
}


function _VirtualDom_applyPatchRedraw(domNode, vNode, eventNode)
{
	var parentNode = domNode.parentNode;
	var newNode = _VirtualDom_render(vNode, eventNode);

	if (!newNode.elm_event_node_ref)
	{
		newNode.elm_event_node_ref = domNode.elm_event_node_ref;
	}

	if (parentNode && newNode !== domNode)
	{
		parentNode.replaceChild(newNode, domNode);
	}
	return newNode;
}


function _VirtualDom_applyPatchReorder(domNode, patch)
{
	var data = patch.s;

	// remove end inserts
	var frag = _VirtualDom_applyPatchReorderEndInsertsHelp(data.y, patch);

	// removals
	domNode = _VirtualDom_applyPatchesHelp(domNode, data.w);

	// inserts
	var inserts = data.x;
	for (var i = 0; i < inserts.length; i++)
	{
		var insert = inserts[i];
		var entry = insert.A;
		var node = entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u);
		domNode.insertBefore(node, domNode.childNodes[insert.r]);
	}

	// add end inserts
	if (frag)
	{
		_VirtualDom_appendChild(domNode, frag);
	}

	return domNode;
}


function _VirtualDom_applyPatchReorderEndInsertsHelp(endInserts, patch)
{
	if (!endInserts)
	{
		return;
	}

	var frag = _VirtualDom_doc.createDocumentFragment();
	for (var i = 0; i < endInserts.length; i++)
	{
		var insert = endInserts[i];
		var entry = insert.A;
		_VirtualDom_appendChild(frag, entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u)
		);
	}
	return frag;
}


function _VirtualDom_virtualize(node)
{
	// TEXT NODES

	if (node.nodeType === 3)
	{
		return _VirtualDom_text(node.textContent);
	}


	// WEIRD NODES

	if (node.nodeType !== 1)
	{
		return _VirtualDom_text('');
	}


	// ELEMENT NODES

	var attrList = _List_Nil;
	var attrs = node.attributes;
	for (var i = attrs.length; i--; )
	{
		var attr = attrs[i];
		var name = attr.name;
		var value = attr.value;
		attrList = _List_Cons( A2(_VirtualDom_attribute, name, value), attrList );
	}

	var tag = node.tagName.toLowerCase();
	var kidList = _List_Nil;
	var kids = node.childNodes;

	for (var i = kids.length; i--; )
	{
		kidList = _List_Cons(_VirtualDom_virtualize(kids[i]), kidList);
	}
	return A3(_VirtualDom_node, tag, attrList, kidList);
}

function _VirtualDom_dekey(keyedNode)
{
	var keyedKids = keyedNode.e;
	var len = keyedKids.length;
	var kids = new Array(len);
	for (var i = 0; i < len; i++)
	{
		kids[i] = keyedKids[i].b;
	}

	return {
		$: 1,
		c: keyedNode.c,
		d: keyedNode.d,
		e: kids,
		f: keyedNode.f,
		b: keyedNode.b
	};
}



var _Bitwise_and = F2(function(a, b)
{
	return a & b;
});

var _Bitwise_or = F2(function(a, b)
{
	return a | b;
});

var _Bitwise_xor = F2(function(a, b)
{
	return a ^ b;
});

function _Bitwise_complement(a)
{
	return ~a;
};

var _Bitwise_shiftLeftBy = F2(function(offset, a)
{
	return a << offset;
});

var _Bitwise_shiftRightBy = F2(function(offset, a)
{
	return a >> offset;
});

var _Bitwise_shiftRightZfBy = F2(function(offset, a)
{
	return a >>> offset;
});




// STRINGS


var _Parser_isSubString = F5(function(smallString, offset, row, col, bigString)
{
	var smallLength = smallString.length;
	var isGood = offset + smallLength <= bigString.length;

	for (var i = 0; isGood && i < smallLength; )
	{
		var code = bigString.charCodeAt(offset);
		isGood =
			smallString[i++] === bigString[offset++]
			&& (
				code === 0x000A /* \n */
					? ( row++, col=1 )
					: ( col++, (code & 0xF800) === 0xD800 ? smallString[i++] === bigString[offset++] : 1 )
			)
	}

	return _Utils_Tuple3(isGood ? offset : -1, row, col);
});



// CHARS


var _Parser_isSubChar = F3(function(predicate, offset, string)
{
	return (
		string.length <= offset
			? -1
			:
		(string.charCodeAt(offset) & 0xF800) === 0xD800
			? (predicate(_Utils_chr(string.substr(offset, 2))) ? offset + 2 : -1)
			:
		(predicate(_Utils_chr(string[offset]))
			? ((string[offset] === '\n') ? -2 : (offset + 1))
			: -1
		)
	);
});


var _Parser_isAsciiCode = F3(function(code, offset, string)
{
	return string.charCodeAt(offset) === code;
});



// NUMBERS


var _Parser_chompBase10 = F2(function(offset, string)
{
	for (; offset < string.length; offset++)
	{
		var code = string.charCodeAt(offset);
		if (code < 0x30 || 0x39 < code)
		{
			return offset;
		}
	}
	return offset;
});


var _Parser_consumeBase = F3(function(base, offset, string)
{
	for (var total = 0; offset < string.length; offset++)
	{
		var digit = string.charCodeAt(offset) - 0x30;
		if (digit < 0 || base <= digit) break;
		total = base * total + digit;
	}
	return _Utils_Tuple2(offset, total);
});


var _Parser_consumeBase16 = F2(function(offset, string)
{
	for (var total = 0; offset < string.length; offset++)
	{
		var code = string.charCodeAt(offset);
		if (0x30 <= code && code <= 0x39)
		{
			total = 16 * total + code - 0x30;
		}
		else if (0x41 <= code && code <= 0x46)
		{
			total = 16 * total + code - 55;
		}
		else if (0x61 <= code && code <= 0x66)
		{
			total = 16 * total + code - 87;
		}
		else
		{
			break;
		}
	}
	return _Utils_Tuple2(offset, total);
});



// FIND STRING


var _Parser_findSubString = F5(function(smallString, offset, row, col, bigString)
{
	var newOffset = bigString.indexOf(smallString, offset);
	var target = newOffset < 0 ? bigString.length : newOffset + smallString.length;

	while (offset < target)
	{
		var code = bigString.charCodeAt(offset++);
		code === 0x000A /* \n */
			? ( col=1, row++ )
			: ( col++, (code & 0xF800) === 0xD800 && offset++ )
	}

	return _Utils_Tuple3(newOffset, row, col);
});
var elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var elm$core$Array$foldr = F3(
	function (func, baseCase, _n0) {
		var tree = _n0.c;
		var tail = _n0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
					var subTree = node.a;
					return A3(elm$core$Elm$JsArray$foldr, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3(elm$core$Elm$JsArray$foldr, func, acc, values);
				}
			});
		return A3(
			elm$core$Elm$JsArray$foldr,
			helper,
			A3(elm$core$Elm$JsArray$foldr, func, baseCase, tail),
			tree);
	});
var elm$core$Basics$EQ = {$: 'EQ'};
var elm$core$Basics$LT = {$: 'LT'};
var elm$core$List$cons = _List_cons;
var elm$core$Array$toList = function (array) {
	return A3(elm$core$Array$foldr, elm$core$List$cons, _List_Nil, array);
};
var elm$core$Basics$GT = {$: 'GT'};
var elm$core$Dict$foldr = F3(
	function (func, acc, t) {
		foldr:
		while (true) {
			if (t.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = t.b;
				var value = t.c;
				var left = t.d;
				var right = t.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3(elm$core$Dict$foldr, func, acc, right)),
					$temp$t = left;
				func = $temp$func;
				acc = $temp$acc;
				t = $temp$t;
				continue foldr;
			}
		}
	});
var elm$core$Dict$toList = function (dict) {
	return A3(
		elm$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					elm$core$List$cons,
					_Utils_Tuple2(key, value),
					list);
			}),
		_List_Nil,
		dict);
};
var elm$core$Dict$keys = function (dict) {
	return A3(
		elm$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2(elm$core$List$cons, key, keyList);
			}),
		_List_Nil,
		dict);
};
var elm$core$Set$toList = function (_n0) {
	var dict = _n0.a;
	return elm$core$Dict$keys(dict);
};
var elm$core$Basics$eq = _Utils_equal;
var elm$core$Maybe$Nothing = {$: 'Nothing'};
var elm$core$Maybe$withDefault = F2(
	function (_default, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return value;
		} else {
			return _default;
		}
	});
var elm$core$Basics$identity = function (x) {
	return x;
};
var elm$core$Basics$False = {$: 'False'};
var elm$core$Basics$True = {$: 'True'};
var elm$core$Result$isOk = function (result) {
	if (result.$ === 'Ok') {
		return true;
	} else {
		return false;
	}
};
var elm$core$Array$branchFactor = 32;
var elm$core$Array$Array_elm_builtin = F4(
	function (a, b, c, d) {
		return {$: 'Array_elm_builtin', a: a, b: b, c: c, d: d};
	});
var elm$core$Basics$ceiling = _Basics_ceiling;
var elm$core$Basics$fdiv = _Basics_fdiv;
var elm$core$Basics$logBase = F2(
	function (base, number) {
		return _Basics_log(number) / _Basics_log(base);
	});
var elm$core$Basics$toFloat = _Basics_toFloat;
var elm$core$Array$shiftStep = elm$core$Basics$ceiling(
	A2(elm$core$Basics$logBase, 2, elm$core$Array$branchFactor));
var elm$core$Elm$JsArray$empty = _JsArray_empty;
var elm$core$Array$empty = A4(elm$core$Array$Array_elm_builtin, 0, elm$core$Array$shiftStep, elm$core$Elm$JsArray$empty, elm$core$Elm$JsArray$empty);
var elm$core$Array$Leaf = function (a) {
	return {$: 'Leaf', a: a};
};
var elm$core$Array$SubTree = function (a) {
	return {$: 'SubTree', a: a};
};
var elm$core$Elm$JsArray$initializeFromList = _JsArray_initializeFromList;
var elm$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			if (!list.b) {
				return acc;
			} else {
				var x = list.a;
				var xs = list.b;
				var $temp$func = func,
					$temp$acc = A2(func, x, acc),
					$temp$list = xs;
				func = $temp$func;
				acc = $temp$acc;
				list = $temp$list;
				continue foldl;
			}
		}
	});
var elm$core$List$reverse = function (list) {
	return A3(elm$core$List$foldl, elm$core$List$cons, _List_Nil, list);
};
var elm$core$Array$compressNodes = F2(
	function (nodes, acc) {
		compressNodes:
		while (true) {
			var _n0 = A2(elm$core$Elm$JsArray$initializeFromList, elm$core$Array$branchFactor, nodes);
			var node = _n0.a;
			var remainingNodes = _n0.b;
			var newAcc = A2(
				elm$core$List$cons,
				elm$core$Array$SubTree(node),
				acc);
			if (!remainingNodes.b) {
				return elm$core$List$reverse(newAcc);
			} else {
				var $temp$nodes = remainingNodes,
					$temp$acc = newAcc;
				nodes = $temp$nodes;
				acc = $temp$acc;
				continue compressNodes;
			}
		}
	});
var elm$core$Basics$apR = F2(
	function (x, f) {
		return f(x);
	});
var elm$core$Tuple$first = function (_n0) {
	var x = _n0.a;
	return x;
};
var elm$core$Array$treeFromBuilder = F2(
	function (nodeList, nodeListSize) {
		treeFromBuilder:
		while (true) {
			var newNodeSize = elm$core$Basics$ceiling(nodeListSize / elm$core$Array$branchFactor);
			if (newNodeSize === 1) {
				return A2(elm$core$Elm$JsArray$initializeFromList, elm$core$Array$branchFactor, nodeList).a;
			} else {
				var $temp$nodeList = A2(elm$core$Array$compressNodes, nodeList, _List_Nil),
					$temp$nodeListSize = newNodeSize;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue treeFromBuilder;
			}
		}
	});
var elm$core$Basics$add = _Basics_add;
var elm$core$Basics$apL = F2(
	function (f, x) {
		return f(x);
	});
var elm$core$Basics$floor = _Basics_floor;
var elm$core$Basics$gt = _Utils_gt;
var elm$core$Basics$max = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) > 0) ? x : y;
	});
var elm$core$Basics$mul = _Basics_mul;
var elm$core$Basics$sub = _Basics_sub;
var elm$core$Elm$JsArray$length = _JsArray_length;
var elm$core$Array$builderToArray = F2(
	function (reverseNodeList, builder) {
		if (!builder.nodeListSize) {
			return A4(
				elm$core$Array$Array_elm_builtin,
				elm$core$Elm$JsArray$length(builder.tail),
				elm$core$Array$shiftStep,
				elm$core$Elm$JsArray$empty,
				builder.tail);
		} else {
			var treeLen = builder.nodeListSize * elm$core$Array$branchFactor;
			var depth = elm$core$Basics$floor(
				A2(elm$core$Basics$logBase, elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? elm$core$List$reverse(builder.nodeList) : builder.nodeList;
			var tree = A2(elm$core$Array$treeFromBuilder, correctNodeList, builder.nodeListSize);
			return A4(
				elm$core$Array$Array_elm_builtin,
				elm$core$Elm$JsArray$length(builder.tail) + treeLen,
				A2(elm$core$Basics$max, 5, depth * elm$core$Array$shiftStep),
				tree,
				builder.tail);
		}
	});
var elm$core$Basics$idiv = _Basics_idiv;
var elm$core$Basics$lt = _Utils_lt;
var elm$core$Elm$JsArray$initialize = _JsArray_initialize;
var elm$core$Array$initializeHelp = F5(
	function (fn, fromIndex, len, nodeList, tail) {
		initializeHelp:
		while (true) {
			if (fromIndex < 0) {
				return A2(
					elm$core$Array$builderToArray,
					false,
					{nodeList: nodeList, nodeListSize: (len / elm$core$Array$branchFactor) | 0, tail: tail});
			} else {
				var leaf = elm$core$Array$Leaf(
					A3(elm$core$Elm$JsArray$initialize, elm$core$Array$branchFactor, fromIndex, fn));
				var $temp$fn = fn,
					$temp$fromIndex = fromIndex - elm$core$Array$branchFactor,
					$temp$len = len,
					$temp$nodeList = A2(elm$core$List$cons, leaf, nodeList),
					$temp$tail = tail;
				fn = $temp$fn;
				fromIndex = $temp$fromIndex;
				len = $temp$len;
				nodeList = $temp$nodeList;
				tail = $temp$tail;
				continue initializeHelp;
			}
		}
	});
var elm$core$Basics$le = _Utils_le;
var elm$core$Basics$remainderBy = _Basics_remainderBy;
var elm$core$Array$initialize = F2(
	function (len, fn) {
		if (len <= 0) {
			return elm$core$Array$empty;
		} else {
			var tailLen = len % elm$core$Array$branchFactor;
			var tail = A3(elm$core$Elm$JsArray$initialize, tailLen, len - tailLen, fn);
			var initialFromIndex = (len - tailLen) - elm$core$Array$branchFactor;
			return A5(elm$core$Array$initializeHelp, fn, initialFromIndex, len, _List_Nil, tail);
		}
	});
var elm$core$Maybe$Just = function (a) {
	return {$: 'Just', a: a};
};
var elm$core$Result$Err = function (a) {
	return {$: 'Err', a: a};
};
var elm$core$Result$Ok = function (a) {
	return {$: 'Ok', a: a};
};
var elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 'Failure', a: a, b: b};
	});
var elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 'Index', a: a, b: b};
	});
var elm$json$Json$Decode$OneOf = function (a) {
	return {$: 'OneOf', a: a};
};
var elm$core$Basics$and = _Basics_and;
var elm$core$Basics$append = _Utils_append;
var elm$core$Basics$or = _Basics_or;
var elm$core$Char$toCode = _Char_toCode;
var elm$core$Char$isLower = function (_char) {
	var code = elm$core$Char$toCode(_char);
	return (97 <= code) && (code <= 122);
};
var elm$core$Char$isUpper = function (_char) {
	var code = elm$core$Char$toCode(_char);
	return (code <= 90) && (65 <= code);
};
var elm$core$Char$isAlpha = function (_char) {
	return elm$core$Char$isLower(_char) || elm$core$Char$isUpper(_char);
};
var elm$core$Char$isDigit = function (_char) {
	var code = elm$core$Char$toCode(_char);
	return (code <= 57) && (48 <= code);
};
var elm$core$Char$isAlphaNum = function (_char) {
	return elm$core$Char$isLower(_char) || (elm$core$Char$isUpper(_char) || elm$core$Char$isDigit(_char));
};
var elm$core$List$length = function (xs) {
	return A3(
		elm$core$List$foldl,
		F2(
			function (_n0, i) {
				return i + 1;
			}),
		0,
		xs);
};
var elm$core$List$map2 = _List_map2;
var elm$core$List$rangeHelp = F3(
	function (lo, hi, list) {
		rangeHelp:
		while (true) {
			if (_Utils_cmp(lo, hi) < 1) {
				var $temp$lo = lo,
					$temp$hi = hi - 1,
					$temp$list = A2(elm$core$List$cons, hi, list);
				lo = $temp$lo;
				hi = $temp$hi;
				list = $temp$list;
				continue rangeHelp;
			} else {
				return list;
			}
		}
	});
var elm$core$List$range = F2(
	function (lo, hi) {
		return A3(elm$core$List$rangeHelp, lo, hi, _List_Nil);
	});
var elm$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			elm$core$List$map2,
			f,
			A2(
				elm$core$List$range,
				0,
				elm$core$List$length(xs) - 1),
			xs);
	});
var elm$core$String$all = _String_all;
var elm$core$String$fromInt = _String_fromNumber;
var elm$core$String$join = F2(
	function (sep, chunks) {
		return A2(
			_String_join,
			sep,
			_List_toArray(chunks));
	});
var elm$core$String$uncons = _String_uncons;
var elm$core$String$split = F2(
	function (sep, string) {
		return _List_fromArray(
			A2(_String_split, sep, string));
	});
var elm$json$Json$Decode$indent = function (str) {
	return A2(
		elm$core$String$join,
		'\n    ',
		A2(elm$core$String$split, '\n', str));
};
var elm$json$Json$Encode$encode = _Json_encode;
var elm$json$Json$Decode$errorOneOf = F2(
	function (i, error) {
		return '\n\n(' + (elm$core$String$fromInt(i + 1) + (') ' + elm$json$Json$Decode$indent(
			elm$json$Json$Decode$errorToString(error))));
	});
var elm$json$Json$Decode$errorToString = function (error) {
	return A2(elm$json$Json$Decode$errorToStringHelp, error, _List_Nil);
};
var elm$json$Json$Decode$errorToStringHelp = F2(
	function (error, context) {
		errorToStringHelp:
		while (true) {
			switch (error.$) {
				case 'Field':
					var f = error.a;
					var err = error.b;
					var isSimple = function () {
						var _n1 = elm$core$String$uncons(f);
						if (_n1.$ === 'Nothing') {
							return false;
						} else {
							var _n2 = _n1.a;
							var _char = _n2.a;
							var rest = _n2.b;
							return elm$core$Char$isAlpha(_char) && A2(elm$core$String$all, elm$core$Char$isAlphaNum, rest);
						}
					}();
					var fieldName = isSimple ? ('.' + f) : ('[\'' + (f + '\']'));
					var $temp$error = err,
						$temp$context = A2(elm$core$List$cons, fieldName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'Index':
					var i = error.a;
					var err = error.b;
					var indexName = '[' + (elm$core$String$fromInt(i) + ']');
					var $temp$error = err,
						$temp$context = A2(elm$core$List$cons, indexName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'OneOf':
					var errors = error.a;
					if (!errors.b) {
						return 'Ran into a Json.Decode.oneOf with no possibilities' + function () {
							if (!context.b) {
								return '!';
							} else {
								return ' at json' + A2(
									elm$core$String$join,
									'',
									elm$core$List$reverse(context));
							}
						}();
					} else {
						if (!errors.b.b) {
							var err = errors.a;
							var $temp$error = err,
								$temp$context = context;
							error = $temp$error;
							context = $temp$context;
							continue errorToStringHelp;
						} else {
							var starter = function () {
								if (!context.b) {
									return 'Json.Decode.oneOf';
								} else {
									return 'The Json.Decode.oneOf at json' + A2(
										elm$core$String$join,
										'',
										elm$core$List$reverse(context));
								}
							}();
							var introduction = starter + (' failed in the following ' + (elm$core$String$fromInt(
								elm$core$List$length(errors)) + ' ways:'));
							return A2(
								elm$core$String$join,
								'\n\n',
								A2(
									elm$core$List$cons,
									introduction,
									A2(elm$core$List$indexedMap, elm$json$Json$Decode$errorOneOf, errors)));
						}
					}
				default:
					var msg = error.a;
					var json = error.b;
					var introduction = function () {
						if (!context.b) {
							return 'Problem with the given value:\n\n';
						} else {
							return 'Problem with the value at json' + (A2(
								elm$core$String$join,
								'',
								elm$core$List$reverse(context)) + ':\n\n    ');
						}
					}();
					return introduction + (elm$json$Json$Decode$indent(
						A2(elm$json$Json$Encode$encode, 4, json)) + ('\n\n' + msg));
			}
		}
	});
var elm$json$Json$Decode$map = _Json_map1;
var elm$json$Json$Decode$map2 = _Json_map2;
var elm$json$Json$Decode$succeed = _Json_succeed;
var elm$virtual_dom$VirtualDom$toHandlerInt = function (handler) {
	switch (handler.$) {
		case 'Normal':
			return 0;
		case 'MayStopPropagation':
			return 1;
		case 'MayPreventDefault':
			return 2;
		default:
			return 3;
	}
};
var elm$html$Html$p = _VirtualDom_node('p');
var elm$html$Html$span = _VirtualDom_node('span');
var elm$virtual_dom$VirtualDom$text = _VirtualDom_text;
var elm$html$Html$text = elm$virtual_dom$VirtualDom$text;
var elm$json$Json$Encode$string = _Json_wrap;
var elm$html$Html$Attributes$stringProperty = F2(
	function (key, string) {
		return A2(
			_VirtualDom_property,
			key,
			elm$json$Json$Encode$string(string));
	});
var elm$html$Html$Attributes$class = elm$html$Html$Attributes$stringProperty('className');
var elm$virtual_dom$VirtualDom$style = _VirtualDom_style;
var elm$html$Html$Attributes$style = elm$virtual_dom$VirtualDom$style;
var author$project$Answers$partP = F2(
	function (labelString, partString) {
		return A2(
			elm$html$Html$p,
			_Utils_eq(elm$core$Maybe$Nothing, partString) ? _List_fromArray(
				[
					A2(elm$html$Html$Attributes$style, 'color', 'red')
				]) : _List_Nil,
			_List_fromArray(
				[
					A2(
					elm$html$Html$span,
					_List_fromArray(
						[
							elm$html$Html$Attributes$class('param-name')
						]),
					_List_fromArray(
						[
							elm$html$Html$text(labelString)
						])),
					A2(
					elm$html$Html$span,
					_List_fromArray(
						[
							elm$html$Html$Attributes$class('param-value')
						]),
					_List_fromArray(
						[
							elm$html$Html$text(
							A2(elm$core$Maybe$withDefault, 'error', partString))
						]))
				]));
	});
var elm$html$Html$div = _VirtualDom_node('div');
var elm$html$Html$h2 = _VirtualDom_node('h2');
var author$project$Answers$dayDiv = F3(
	function (dayString, partOneString, partTwoString) {
		return A2(
			elm$html$Html$div,
			_List_fromArray(
				[
					elm$html$Html$Attributes$class('day-wrapper')
				]),
			_List_fromArray(
				[
					A2(
					elm$html$Html$div,
					_List_fromArray(
						[
							elm$html$Html$Attributes$class('heading-wrapper')
						]),
					_List_fromArray(
						[
							A2(
							elm$html$Html$h2,
							_List_Nil,
							_List_fromArray(
								[
									elm$html$Html$text(dayString)
								]))
						])),
					A2(author$project$Answers$partP, 'Part One: ', partOneString),
					A2(author$project$Answers$partP, 'Part Two: ', partTwoString)
				]));
	});
var elm$core$Basics$composeL = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var elm$core$Basics$negate = function (n) {
	return -n;
};
var elm$core$Maybe$andThen = F2(
	function (callback, maybeValue) {
		if (maybeValue.$ === 'Just') {
			var value = maybeValue.a;
			return callback(value);
		} else {
			return elm$core$Maybe$Nothing;
		}
	});
var elm$core$String$toInt = _String_toInt;
var author$project$DayOneInput$parseNumberString = function (string) {
	var _n0 = elm$core$String$uncons(string);
	_n0$2:
	while (true) {
		if (_n0.$ === 'Just') {
			switch (_n0.a.a.valueOf()) {
				case '+':
					var _n1 = _n0.a;
					var num = _n1.b;
					return elm$core$String$toInt(num);
				case '-':
					var _n2 = _n0.a;
					var num = _n2.b;
					return A2(
						elm$core$Maybe$andThen,
						A2(elm$core$Basics$composeL, elm$core$Maybe$Just, elm$core$Basics$negate),
						elm$core$String$toInt(num));
				default:
					break _n0$2;
			}
		} else {
			break _n0$2;
		}
	}
	return elm$core$Maybe$Nothing;
};
var author$project$DayOneInput$rawInput = '+2\n+11\n+4\n-16\n-4\n+15\n+19\n-8\n-17\n+12\n+8\n+8\n+18\n-10\n-17\n-6\n+10\n+10\n+19\n+11\n+12\n-17\n+4\n-1\n+12\n+6\n+13\n+14\n+6\n+19\n+2\n+19\n-7\n-15\n+6\n-12\n-15\n-18\n+17\n+8\n+4\n+14\n+1\n+15\n-6\n-6\n+13\n+9\n-2\n+1\n+15\n-12\n+18\n+7\n-14\n+15\n-16\n+6\n-12\n-11\n-12\n-1\n-15\n-8\n-18\n-15\n+11\n+13\n-7\n+15\n+19\n+2\n+17\n-9\n-15\n-11\n-8\n+16\n+17\n-6\n+13\n+16\n-20\n+19\n+8\n+14\n+5\n+11\n-5\n+6\n+10\n+3\n-7\n-5\n-14\n+9\n+6\n+13\n+4\n-3\n-13\n-6\n-18\n-23\n-2\n+16\n+12\n-4\n+12\n+3\n-4\n+9\n-14\n+1\n-17\n-21\n+11\n-8\n+7\n-16\n-20\n-3\n-10\n-17\n-11\n+6\n-15\n-11\n+17\n+12\n-13\n-11\n-12\n-18\n-1\n+10\n-16\n-1\n-8\n+18\n+4\n+2\n-11\n-18\n+8\n+18\n-17\n+7\n+3\n+17\n+7\n+1\n-16\n+10\n-6\n-10\n+31\n-5\n-14\n+15\n+19\n+6\n-1\n+17\n-4\n+16\n-6\n+9\n-26\n-18\n+17\n-9\n-5\n-19\n+2\n+13\n+41\n-18\n+10\n-26\n-12\n+4\n-3\n-23\n-9\n-29\n-13\n+15\n+4\n-21\n+14\n+23\n-24\n-4\n-12\n-8\n-18\n-16\n-14\n+17\n-8\n-16\n+13\n-15\n+7\n+9\n-17\n-4\n-7\n-12\n+4\n+10\n-13\n-6\n-8\n+10\n+1\n+9\n-15\n+14\n-15\n+11\n-18\n-18\n+2\n+10\n-8\n-10\n+5\n-4\n+12\n-4\n-2\n+15\n+17\n+16\n+19\n+17\n+13\n+8\n-10\n+13\n+8\n-13\n-14\n+5\n-3\n-15\n-16\n-9\n-5\n-10\n+8\n-2\n+1\n-14\n-7\n-3\n-12\n-3\n+10\n-18\n+22\n+8\n-13\n-3\n-18\n-12\n-9\n+1\n-10\n+8\n-13\n-12\n-9\n-2\n+12\n-14\n+8\n-19\n-6\n-11\n+12\n+15\n+17\n+7\n-14\n+11\n+9\n-10\n-21\n+3\n-19\n-6\n-6\n+7\n+15\n-13\n-8\n+10\n-18\n+15\n-9\n-19\n+5\n+11\n-7\n-14\n+7\n+9\n+6\n+6\n+13\n+8\n+13\n+19\n-8\n-3\n-4\n-18\n+12\n-2\n+18\n+13\n-1\n+17\n-7\n+12\n+8\n+2\n+19\n-11\n+22\n+14\n+9\n-12\n+24\n+1\n+5\n+20\n-18\n+17\n-9\n+12\n-4\n-15\n-10\n+4\n-7\n+11\n+13\n+10\n+21\n-14\n-1\n-13\n-6\n+14\n+7\n+7\n+10\n+11\n-22\n+6\n+17\n+26\n-7\n+8\n-5\n+29\n-54\n-16\n+13\n+10\n-1\n-23\n+12\n-20\n-20\n-27\n+1\n-2\n-4\n-26\n-2\n-36\n-18\n+14\n-3\n-18\n-1\n+17\n+15\n-12\n+9\n+1\n+23\n-22\n-6\n-20\n+19\n+3\n-17\n-6\n-41\n-5\n-5\n-5\n-19\n-9\n-13\n+3\n+2\n+10\n+5\n-6\n-18\n-19\n+10\n+17\n+6\n-17\n+5\n-7\n+10\n+6\n-5\n-14\n+1\n-17\n-19\n+7\n+14\n-19\n+6\n+12\n-16\n+13\n-1\n+16\n+14\n-13\n-4\n+2\n-17\n-1\n-7\n-5\n-3\n-14\n-3\n+5\n+11\n-12\n-5\n-14\n+2\n+2\n-15\n+12\n-3\n+15\n-2\n+10\n+7\n-16\n+12\n-15\n+1\n-3\n-4\n-19\n+7\n-5\n+22\n+8\n+17\n+16\n+15\n+11\n+3\n-16\n-10\n+7\n+12\n+16\n+13\n-10\n+15\n-1\n-15\n+22\n+1\n+3\n+20\n+24\n+12\n+17\n-19\n-12\n+7\n-11\n-19\n+4\n+4\n-21\n+22\n+1\n+45\n+3\n-9\n+41\n-1\n+94\n+2\n+7\n-37\n+3\n+217\n+13\n+10\n-14\n+5\n-3\n-14\n-26\n-39\n+80\n+33\n+9\n-13\n+7\n+7\n-13\n-14\n+1\n+37\n+33\n+7\n+14\n+1\n-5\n-11\n-8\n-12\n+4\n+14\n-17\n+1\n-10\n-20\n-25\n+27\n+31\n-8\n+1\n+53\n+22\n+9\n-14\n-49\n+13\n-52\n-64\n-100\n+34\n+198\n+605\n+76787\n-8\n+13\n+4\n-8\n+5\n+9\n-7\n-13\n-6\n-4\n-20\n+6\n+12\n-4\n+7\n+5\n-14\n+10\n+17\n+18\n+18\n+5\n+6\n-12\n-6\n-8\n-13\n-5\n-8\n-17\n+6\n+2\n+3\n+18\n-1\n+20\n+14\n-18\n+21\n-12\n+3\n+8\n+6\n+21\n-3\n+1\n+9\n+16\n+15\n-7\n+1\n-16\n+17\n-5\n-15\n-14\n+3\n+3\n-4\n+2\n+1\n+16\n+19\n+12\n-4\n+14\n-8\n+17\n-7\n-1\n-3\n-11\n-12\n+7\n+9\n-10\n-13\n+1\n-8\n+4\n-12\n+13\n-10\n-8\n-3\n-19\n-12\n+7\n+9\n-1\n-9\n-4\n-19\n-12\n+17\n-12\n+19\n+18\n-12\n-7\n-10\n+5\n-21\n+4\n-6\n+4\n-15\n-9\n+19\n-17\n+21\n+12\n+24\n+13\n+18\n-16\n-11\n+10\n+18\n+7\n+16\n-10\n-4\n-13\n+29\n-13\n-9\n+3\n-22\n-13\n+67\n-10\n+9\n+6\n+2\n+8\n+6\n+18\n-16\n-15\n+9\n+2\n+3\n-4\n+7\n+18\n+12\n-10\n-15\n+1\n+11\n-9\n-19\n+15\n+8\n+11\n+2\n+3\n+9\n+14\n-19\n+16\n-5\n-12\n+8\n+17\n+4\n+10\n-13\n+19\n+9\n-19\n-11\n+8\n+6\n+3\n+5\n-16\n+3\n+7\n+11\n-1\n+5\n-7\n-12\n+13\n-6\n+1\n+18\n+6\n+1\n+14\n-7\n-2\n-13\n+18\n-1\n+18\n-5\n+3\n-14\n-17\n+1\n+13\n+16\n+14\n+4\n-13\n-12\n-1\n+2\n+3\n+14\n-1\n-6\n+12\n+8\n-11\n+6\n-7\n+19\n-16\n+5\n+18\n+11\n-16\n-8\n-3\n+13\n+6\n+7\n-14\n+9\n+14\n-7\n+9\n-14\n+1\n-6\n+16\n-2\n-12\n-5\n-8\n+7\n-19\n+13\n+2\n+7\n+13\n-8\n+7\n+15\n+9\n+10\n-5\n+4\n+7\n-1\n+12\n+13\n+13\n+10\n+13\n+13\n-6\n+12\n+10\n-5\n+9\n+11\n-16\n+8\n-11\n-15\n-15\n+10\n-17\n+2\n-6\n-11\n-14\n-13\n-14\n-5\n-8\n-1\n-7\n-7\n+21\n-11\n-5\n+3\n+5\n-15\n+20\n+8\n-17\n+7\n-13\n+35\n+6\n-3\n-1\n-16\n+8\n-5\n-10\n+14\n+20\n+13\n+10\n-20\n-17\n+13\n-2\n+9\n+19\n-8\n+4\n-2\n+12\n-15\n+12\n-4\n+20\n-7\n+2\n-5\n-19\n-3\n-1\n+3\n+6\n+7\n-20\n+19\n+15\n+10\n+3\n-7\n+1\n+13\n+4\n+6\n+5\n+4\n+4\n+7\n-19\n+16\n+2\n+4\n-8\n-7\n+18\n+15\n+6\n+1\n-13\n+14\n+18\n-7\n+8\n-16\n-10\n+13\n-12\n+13\n+14\n+14\n-8\n-19\n+4\n-15\n-16\n-16\n-8\n+10\n+17\n-12\n+10\n+8\n+19\n-13\n+14\n+12\n+3\n-10\n+2\n+14\n+1\n-2\n+3\n+16\n-3\n-12\n+5\n+4\n-19\n+17\n-4\n-8\n+15\n-6\n+14\n+21\n-4\n-18\n+4\n-8\n+21\n-28\n+5\n-25\n-4\n-2\n+14\n-2\n-22\n-9\n-7\n-5\n-20\n-17\n-6\n+8\n-5\n-4\n-2\n-15\n-6\n+13\n+13\n+13\n-29\n-16\n+13\n-38\n+5\n-16\n+4\n-15\n+19\n-31\n+24\n+6\n-13\n+20\n-47\n-6\n+13\n+14\n-79\n-14\n+11\n-4\n+24\n-18\n-1\n+20\n-4\n+24\n-26\n-25\n-16\n-6\n-8\n-7\n+8\n-77371';
var elm$core$List$foldrHelper = F4(
	function (fn, acc, ctr, ls) {
		if (!ls.b) {
			return acc;
		} else {
			var a = ls.a;
			var r1 = ls.b;
			if (!r1.b) {
				return A2(fn, a, acc);
			} else {
				var b = r1.a;
				var r2 = r1.b;
				if (!r2.b) {
					return A2(
						fn,
						a,
						A2(fn, b, acc));
				} else {
					var c = r2.a;
					var r3 = r2.b;
					if (!r3.b) {
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(fn, c, acc)));
					} else {
						var d = r3.a;
						var r4 = r3.b;
						var res = (ctr > 500) ? A3(
							elm$core$List$foldl,
							fn,
							acc,
							elm$core$List$reverse(r4)) : A4(elm$core$List$foldrHelper, fn, acc, ctr + 1, r4);
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(
									fn,
									c,
									A2(fn, d, res))));
					}
				}
			}
		}
	});
var elm$core$List$foldr = F3(
	function (fn, acc, ls) {
		return A4(elm$core$List$foldrHelper, fn, acc, 0, ls);
	});
var elm$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _n0 = f(mx);
		if (_n0.$ === 'Just') {
			var x = _n0.a;
			return A2(elm$core$List$cons, x, xs);
		} else {
			return xs;
		}
	});
var elm$core$List$filterMap = F2(
	function (f, xs) {
		return A3(
			elm$core$List$foldr,
			elm$core$List$maybeCons(f),
			_List_Nil,
			xs);
	});
var author$project$DayOneInput$input = A2(
	elm$core$List$filterMap,
	author$project$DayOneInput$parseNumberString,
	A2(elm$core$String$split, '\n', author$project$DayOneInput$rawInput));
var author$project$DayOne$partOne = elm$core$String$fromInt(
	A3(elm$core$List$foldl, elm$core$Basics$add, 0, author$project$DayOneInput$input));
var elm$core$Bitwise$shiftRightZfBy = _Bitwise_shiftRightZfBy;
var elm$core$Array$bitMask = 4294967295 >>> (32 - elm$core$Array$shiftStep);
var elm$core$Bitwise$and = _Bitwise_and;
var elm$core$Elm$JsArray$unsafeGet = _JsArray_unsafeGet;
var elm$core$Array$getHelp = F3(
	function (shift, index, tree) {
		getHelp:
		while (true) {
			var pos = elm$core$Array$bitMask & (index >>> shift);
			var _n0 = A2(elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (_n0.$ === 'SubTree') {
				var subTree = _n0.a;
				var $temp$shift = shift - elm$core$Array$shiftStep,
					$temp$index = index,
					$temp$tree = subTree;
				shift = $temp$shift;
				index = $temp$index;
				tree = $temp$tree;
				continue getHelp;
			} else {
				var values = _n0.a;
				return A2(elm$core$Elm$JsArray$unsafeGet, elm$core$Array$bitMask & index, values);
			}
		}
	});
var elm$core$Bitwise$shiftLeftBy = _Bitwise_shiftLeftBy;
var elm$core$Array$tailIndex = function (len) {
	return (len >>> 5) << 5;
};
var elm$core$Basics$ge = _Utils_ge;
var elm$core$Array$get = F2(
	function (index, _n0) {
		var len = _n0.a;
		var startShift = _n0.b;
		var tree = _n0.c;
		var tail = _n0.d;
		return ((index < 0) || (_Utils_cmp(index, len) > -1)) ? elm$core$Maybe$Nothing : ((_Utils_cmp(
			index,
			elm$core$Array$tailIndex(len)) > -1) ? elm$core$Maybe$Just(
			A2(elm$core$Elm$JsArray$unsafeGet, elm$core$Array$bitMask & index, tail)) : elm$core$Maybe$Just(
			A3(elm$core$Array$getHelp, startShift, index, tree)));
	});
var author$project$DayOne$nextCycle = function (_n0) {
	var index = _n0.a;
	var array = _n0.b;
	var _n1 = A2(elm$core$Array$get, index, array);
	if (_n1.$ === 'Just') {
		var i = _n1.a;
		return _Utils_Tuple2(
			elm$core$Maybe$Just(i),
			_Utils_Tuple2(index + 1, array));
	} else {
		return _Utils_Tuple2(
			A2(elm$core$Array$get, 0, array),
			_Utils_Tuple2(1, array));
	}
};
var elm$core$Dict$Black = {$: 'Black'};
var elm$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {$: 'RBNode_elm_builtin', a: a, b: b, c: c, d: d, e: e};
	});
var elm$core$Basics$compare = _Utils_compare;
var elm$core$Dict$RBEmpty_elm_builtin = {$: 'RBEmpty_elm_builtin'};
var elm$core$Dict$Red = {$: 'Red'};
var elm$core$Dict$balance = F5(
	function (color, key, value, left, right) {
		if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Red')) {
			var _n1 = right.a;
			var rK = right.b;
			var rV = right.c;
			var rLeft = right.d;
			var rRight = right.e;
			if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
				var _n3 = left.a;
				var lK = left.b;
				var lV = left.c;
				var lLeft = left.d;
				var lRight = left.e;
				return A5(
					elm$core$Dict$RBNode_elm_builtin,
					elm$core$Dict$Red,
					key,
					value,
					A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Black, lK, lV, lLeft, lRight),
					A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Black, rK, rV, rLeft, rRight));
			} else {
				return A5(
					elm$core$Dict$RBNode_elm_builtin,
					color,
					rK,
					rV,
					A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Red, key, value, left, rLeft),
					rRight);
			}
		} else {
			if ((((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) && (left.d.$ === 'RBNode_elm_builtin')) && (left.d.a.$ === 'Red')) {
				var _n5 = left.a;
				var lK = left.b;
				var lV = left.c;
				var _n6 = left.d;
				var _n7 = _n6.a;
				var llK = _n6.b;
				var llV = _n6.c;
				var llLeft = _n6.d;
				var llRight = _n6.e;
				var lRight = left.e;
				return A5(
					elm$core$Dict$RBNode_elm_builtin,
					elm$core$Dict$Red,
					lK,
					lV,
					A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Black, llK, llV, llLeft, llRight),
					A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Black, key, value, lRight, right));
			} else {
				return A5(elm$core$Dict$RBNode_elm_builtin, color, key, value, left, right);
			}
		}
	});
var elm$core$Dict$insertHelp = F3(
	function (key, value, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Red, key, value, elm$core$Dict$RBEmpty_elm_builtin, elm$core$Dict$RBEmpty_elm_builtin);
		} else {
			var nColor = dict.a;
			var nKey = dict.b;
			var nValue = dict.c;
			var nLeft = dict.d;
			var nRight = dict.e;
			var _n1 = A2(elm$core$Basics$compare, key, nKey);
			switch (_n1.$) {
				case 'LT':
					return A5(
						elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						A3(elm$core$Dict$insertHelp, key, value, nLeft),
						nRight);
				case 'EQ':
					return A5(elm$core$Dict$RBNode_elm_builtin, nColor, nKey, value, nLeft, nRight);
				default:
					return A5(
						elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						nLeft,
						A3(elm$core$Dict$insertHelp, key, value, nRight));
			}
		}
	});
var elm$core$Dict$insert = F3(
	function (key, value, dict) {
		var _n0 = A3(elm$core$Dict$insertHelp, key, value, dict);
		if ((_n0.$ === 'RBNode_elm_builtin') && (_n0.a.$ === 'Red')) {
			var _n1 = _n0.a;
			var k = _n0.b;
			var v = _n0.c;
			var l = _n0.d;
			var r = _n0.e;
			return A5(elm$core$Dict$RBNode_elm_builtin, elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _n0;
			return x;
		}
	});
var elm$core$Set$Set_elm_builtin = function (a) {
	return {$: 'Set_elm_builtin', a: a};
};
var elm$core$Set$insert = F2(
	function (key, _n0) {
		var dict = _n0.a;
		return elm$core$Set$Set_elm_builtin(
			A3(elm$core$Dict$insert, key, _Utils_Tuple0, dict));
	});
var elm$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return elm$core$Maybe$Nothing;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var _n1 = A2(elm$core$Basics$compare, targetKey, key);
				switch (_n1.$) {
					case 'LT':
						var $temp$targetKey = targetKey,
							$temp$dict = left;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
					case 'EQ':
						return elm$core$Maybe$Just(value);
					default:
						var $temp$targetKey = targetKey,
							$temp$dict = right;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
				}
			}
		}
	});
var elm$core$Dict$member = F2(
	function (key, dict) {
		var _n0 = A2(elm$core$Dict$get, key, dict);
		if (_n0.$ === 'Just') {
			return true;
		} else {
			return false;
		}
	});
var elm$core$Set$member = F2(
	function (key, _n0) {
		var dict = _n0.a;
		return A2(elm$core$Dict$member, key, dict);
	});
var author$project$DayOne$problemTwoStep = F3(
	function (currentSum, pastSums, cycle) {
		problemTwoStep:
		while (true) {
			if (A2(elm$core$Set$member, currentSum, pastSums)) {
				return currentSum;
			} else {
				var _n0 = author$project$DayOne$nextCycle(cycle);
				if (_n0.a.$ === 'Nothing') {
					var _n1 = _n0.a;
					return -1;
				} else {
					var next = _n0.a.a;
					var rest = _n0.b;
					var $temp$currentSum = currentSum + next,
						$temp$pastSums = A2(elm$core$Set$insert, currentSum, pastSums),
						$temp$cycle = rest;
					currentSum = $temp$currentSum;
					pastSums = $temp$pastSums;
					cycle = $temp$cycle;
					continue problemTwoStep;
				}
			}
		}
	});
var elm$core$Array$fromListHelp = F3(
	function (list, nodeList, nodeListSize) {
		fromListHelp:
		while (true) {
			var _n0 = A2(elm$core$Elm$JsArray$initializeFromList, elm$core$Array$branchFactor, list);
			var jsArray = _n0.a;
			var remainingItems = _n0.b;
			if (_Utils_cmp(
				elm$core$Elm$JsArray$length(jsArray),
				elm$core$Array$branchFactor) < 0) {
				return A2(
					elm$core$Array$builderToArray,
					true,
					{nodeList: nodeList, nodeListSize: nodeListSize, tail: jsArray});
			} else {
				var $temp$list = remainingItems,
					$temp$nodeList = A2(
					elm$core$List$cons,
					elm$core$Array$Leaf(jsArray),
					nodeList),
					$temp$nodeListSize = nodeListSize + 1;
				list = $temp$list;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue fromListHelp;
			}
		}
	});
var elm$core$Array$fromList = function (list) {
	if (!list.b) {
		return elm$core$Array$empty;
	} else {
		return A3(elm$core$Array$fromListHelp, list, _List_Nil, 0);
	}
};
var elm$core$Dict$empty = elm$core$Dict$RBEmpty_elm_builtin;
var elm$core$Set$empty = elm$core$Set$Set_elm_builtin(elm$core$Dict$empty);
var author$project$DayOne$partTwo = elm$core$String$fromInt(
	A3(
		author$project$DayOne$problemTwoStep,
		0,
		elm$core$Set$empty,
		_Utils_Tuple2(
			0,
			elm$core$Array$fromList(author$project$DayOneInput$input))));
var author$project$DayThree$countWhere = F3(
	function (sum, condition, array) {
		countWhere:
		while (true) {
			if (!array.b) {
				return sum;
			} else {
				var head = array.a;
				var tail = array.b;
				if (condition(head)) {
					var $temp$sum = sum + 1,
						$temp$condition = condition,
						$temp$array = tail;
					sum = $temp$sum;
					condition = $temp$condition;
					array = $temp$array;
					continue countWhere;
				} else {
					var $temp$sum = sum,
						$temp$condition = condition,
						$temp$array = tail;
					sum = $temp$sum;
					condition = $temp$condition;
					array = $temp$array;
					continue countWhere;
				}
			}
		}
	});
var author$project$DynamicMatrix$get = F2(
	function (coordinate, matrix) {
		return ((coordinate.x < 0) || (coordinate.y < 0)) ? elm$core$Maybe$Nothing : (((_Utils_cmp(coordinate.x, matrix.size) < 0) && (_Utils_cmp(coordinate.y, matrix.size) < 0)) ? elm$core$Maybe$Just(
			A2(
				elm$core$Maybe$withDefault,
				matrix._default,
				A2(elm$core$Array$get, coordinate.x + (matrix.size * coordinate.y), matrix.data))) : elm$core$Maybe$Just(matrix._default));
	});
var elm$core$Elm$JsArray$appendN = _JsArray_appendN;
var elm$core$Elm$JsArray$slice = _JsArray_slice;
var elm$core$Array$appendHelpBuilder = F2(
	function (tail, builder) {
		var tailLen = elm$core$Elm$JsArray$length(tail);
		var notAppended = (elm$core$Array$branchFactor - elm$core$Elm$JsArray$length(builder.tail)) - tailLen;
		var appended = A3(elm$core$Elm$JsArray$appendN, elm$core$Array$branchFactor, builder.tail, tail);
		return (notAppended < 0) ? {
			nodeList: A2(
				elm$core$List$cons,
				elm$core$Array$Leaf(appended),
				builder.nodeList),
			nodeListSize: builder.nodeListSize + 1,
			tail: A3(elm$core$Elm$JsArray$slice, notAppended, tailLen, tail)
		} : ((!notAppended) ? {
			nodeList: A2(
				elm$core$List$cons,
				elm$core$Array$Leaf(appended),
				builder.nodeList),
			nodeListSize: builder.nodeListSize + 1,
			tail: elm$core$Elm$JsArray$empty
		} : {nodeList: builder.nodeList, nodeListSize: builder.nodeListSize, tail: appended});
	});
var elm$core$Elm$JsArray$push = _JsArray_push;
var elm$core$Elm$JsArray$singleton = _JsArray_singleton;
var elm$core$Elm$JsArray$unsafeSet = _JsArray_unsafeSet;
var elm$core$Array$insertTailInTree = F4(
	function (shift, index, tail, tree) {
		var pos = elm$core$Array$bitMask & (index >>> shift);
		if (_Utils_cmp(
			pos,
			elm$core$Elm$JsArray$length(tree)) > -1) {
			if (shift === 5) {
				return A2(
					elm$core$Elm$JsArray$push,
					elm$core$Array$Leaf(tail),
					tree);
			} else {
				var newSub = elm$core$Array$SubTree(
					A4(elm$core$Array$insertTailInTree, shift - elm$core$Array$shiftStep, index, tail, elm$core$Elm$JsArray$empty));
				return A2(elm$core$Elm$JsArray$push, newSub, tree);
			}
		} else {
			var value = A2(elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (value.$ === 'SubTree') {
				var subTree = value.a;
				var newSub = elm$core$Array$SubTree(
					A4(elm$core$Array$insertTailInTree, shift - elm$core$Array$shiftStep, index, tail, subTree));
				return A3(elm$core$Elm$JsArray$unsafeSet, pos, newSub, tree);
			} else {
				var newSub = elm$core$Array$SubTree(
					A4(
						elm$core$Array$insertTailInTree,
						shift - elm$core$Array$shiftStep,
						index,
						tail,
						elm$core$Elm$JsArray$singleton(value)));
				return A3(elm$core$Elm$JsArray$unsafeSet, pos, newSub, tree);
			}
		}
	});
var elm$core$Array$unsafeReplaceTail = F2(
	function (newTail, _n0) {
		var len = _n0.a;
		var startShift = _n0.b;
		var tree = _n0.c;
		var tail = _n0.d;
		var originalTailLen = elm$core$Elm$JsArray$length(tail);
		var newTailLen = elm$core$Elm$JsArray$length(newTail);
		var newArrayLen = len + (newTailLen - originalTailLen);
		if (_Utils_eq(newTailLen, elm$core$Array$branchFactor)) {
			var overflow = _Utils_cmp(newArrayLen >>> elm$core$Array$shiftStep, 1 << startShift) > 0;
			if (overflow) {
				var newShift = startShift + elm$core$Array$shiftStep;
				var newTree = A4(
					elm$core$Array$insertTailInTree,
					newShift,
					len,
					newTail,
					elm$core$Elm$JsArray$singleton(
						elm$core$Array$SubTree(tree)));
				return A4(elm$core$Array$Array_elm_builtin, newArrayLen, newShift, newTree, elm$core$Elm$JsArray$empty);
			} else {
				return A4(
					elm$core$Array$Array_elm_builtin,
					newArrayLen,
					startShift,
					A4(elm$core$Array$insertTailInTree, startShift, len, newTail, tree),
					elm$core$Elm$JsArray$empty);
			}
		} else {
			return A4(elm$core$Array$Array_elm_builtin, newArrayLen, startShift, tree, newTail);
		}
	});
var elm$core$Array$appendHelpTree = F2(
	function (toAppend, array) {
		var len = array.a;
		var tree = array.c;
		var tail = array.d;
		var itemsToAppend = elm$core$Elm$JsArray$length(toAppend);
		var notAppended = (elm$core$Array$branchFactor - elm$core$Elm$JsArray$length(tail)) - itemsToAppend;
		var appended = A3(elm$core$Elm$JsArray$appendN, elm$core$Array$branchFactor, tail, toAppend);
		var newArray = A2(elm$core$Array$unsafeReplaceTail, appended, array);
		if (notAppended < 0) {
			var nextTail = A3(elm$core$Elm$JsArray$slice, notAppended, itemsToAppend, toAppend);
			return A2(elm$core$Array$unsafeReplaceTail, nextTail, newArray);
		} else {
			return newArray;
		}
	});
var elm$core$Elm$JsArray$foldl = _JsArray_foldl;
var elm$core$Array$builderFromArray = function (_n0) {
	var len = _n0.a;
	var tree = _n0.c;
	var tail = _n0.d;
	var helper = F2(
		function (node, acc) {
			if (node.$ === 'SubTree') {
				var subTree = node.a;
				return A3(elm$core$Elm$JsArray$foldl, helper, acc, subTree);
			} else {
				return A2(elm$core$List$cons, node, acc);
			}
		});
	return {
		nodeList: A3(elm$core$Elm$JsArray$foldl, helper, _List_Nil, tree),
		nodeListSize: (len / elm$core$Array$branchFactor) | 0,
		tail: tail
	};
};
var elm$core$Array$append = F2(
	function (a, _n0) {
		var aTail = a.d;
		var bLen = _n0.a;
		var bTree = _n0.c;
		var bTail = _n0.d;
		if (_Utils_cmp(bLen, elm$core$Array$branchFactor * 4) < 1) {
			var foldHelper = F2(
				function (node, array) {
					if (node.$ === 'SubTree') {
						var tree = node.a;
						return A3(elm$core$Elm$JsArray$foldl, foldHelper, array, tree);
					} else {
						var leaf = node.a;
						return A2(elm$core$Array$appendHelpTree, leaf, array);
					}
				});
			return A2(
				elm$core$Array$appendHelpTree,
				bTail,
				A3(elm$core$Elm$JsArray$foldl, foldHelper, a, bTree));
		} else {
			var foldHelper = F2(
				function (node, builder) {
					if (node.$ === 'SubTree') {
						var tree = node.a;
						return A3(elm$core$Elm$JsArray$foldl, foldHelper, builder, tree);
					} else {
						var leaf = node.a;
						return A2(elm$core$Array$appendHelpBuilder, leaf, builder);
					}
				});
			return A2(
				elm$core$Array$builderToArray,
				true,
				A2(
					elm$core$Array$appendHelpBuilder,
					bTail,
					A3(
						elm$core$Elm$JsArray$foldl,
						foldHelper,
						elm$core$Array$builderFromArray(a),
						bTree)));
		}
	});
var author$project$DynamicMatrix$insertBetween = F3(
	function (firstHalf, secondHalf, value) {
		return A2(
			elm$core$Array$append,
			firstHalf,
			A2(elm$core$Array$append, value, secondHalf));
	});
var elm$core$Array$length = function (_n0) {
	var len = _n0.a;
	return len;
};
var elm$core$List$drop = F2(
	function (n, list) {
		drop:
		while (true) {
			if (n <= 0) {
				return list;
			} else {
				if (!list.b) {
					return list;
				} else {
					var x = list.a;
					var xs = list.b;
					var $temp$n = n - 1,
						$temp$list = xs;
					n = $temp$n;
					list = $temp$list;
					continue drop;
				}
			}
		}
	});
var elm$core$Array$sliceLeft = F2(
	function (from, array) {
		var len = array.a;
		var tree = array.c;
		var tail = array.d;
		if (!from) {
			return array;
		} else {
			if (_Utils_cmp(
				from,
				elm$core$Array$tailIndex(len)) > -1) {
				return A4(
					elm$core$Array$Array_elm_builtin,
					len - from,
					elm$core$Array$shiftStep,
					elm$core$Elm$JsArray$empty,
					A3(
						elm$core$Elm$JsArray$slice,
						from - elm$core$Array$tailIndex(len),
						elm$core$Elm$JsArray$length(tail),
						tail));
			} else {
				var skipNodes = (from / elm$core$Array$branchFactor) | 0;
				var helper = F2(
					function (node, acc) {
						if (node.$ === 'SubTree') {
							var subTree = node.a;
							return A3(elm$core$Elm$JsArray$foldr, helper, acc, subTree);
						} else {
							var leaf = node.a;
							return A2(elm$core$List$cons, leaf, acc);
						}
					});
				var leafNodes = A3(
					elm$core$Elm$JsArray$foldr,
					helper,
					_List_fromArray(
						[tail]),
					tree);
				var nodesToInsert = A2(elm$core$List$drop, skipNodes, leafNodes);
				if (!nodesToInsert.b) {
					return elm$core$Array$empty;
				} else {
					var head = nodesToInsert.a;
					var rest = nodesToInsert.b;
					var firstSlice = from - (skipNodes * elm$core$Array$branchFactor);
					var initialBuilder = {
						nodeList: _List_Nil,
						nodeListSize: 0,
						tail: A3(
							elm$core$Elm$JsArray$slice,
							firstSlice,
							elm$core$Elm$JsArray$length(head),
							head)
					};
					return A2(
						elm$core$Array$builderToArray,
						true,
						A3(elm$core$List$foldl, elm$core$Array$appendHelpBuilder, initialBuilder, rest));
				}
			}
		}
	});
var elm$core$Array$fetchNewTail = F4(
	function (shift, end, treeEnd, tree) {
		fetchNewTail:
		while (true) {
			var pos = elm$core$Array$bitMask & (treeEnd >>> shift);
			var _n0 = A2(elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (_n0.$ === 'SubTree') {
				var sub = _n0.a;
				var $temp$shift = shift - elm$core$Array$shiftStep,
					$temp$end = end,
					$temp$treeEnd = treeEnd,
					$temp$tree = sub;
				shift = $temp$shift;
				end = $temp$end;
				treeEnd = $temp$treeEnd;
				tree = $temp$tree;
				continue fetchNewTail;
			} else {
				var values = _n0.a;
				return A3(elm$core$Elm$JsArray$slice, 0, elm$core$Array$bitMask & end, values);
			}
		}
	});
var elm$core$Array$hoistTree = F3(
	function (oldShift, newShift, tree) {
		hoistTree:
		while (true) {
			if ((_Utils_cmp(oldShift, newShift) < 1) || (!elm$core$Elm$JsArray$length(tree))) {
				return tree;
			} else {
				var _n0 = A2(elm$core$Elm$JsArray$unsafeGet, 0, tree);
				if (_n0.$ === 'SubTree') {
					var sub = _n0.a;
					var $temp$oldShift = oldShift - elm$core$Array$shiftStep,
						$temp$newShift = newShift,
						$temp$tree = sub;
					oldShift = $temp$oldShift;
					newShift = $temp$newShift;
					tree = $temp$tree;
					continue hoistTree;
				} else {
					return tree;
				}
			}
		}
	});
var elm$core$Array$sliceTree = F3(
	function (shift, endIdx, tree) {
		var lastPos = elm$core$Array$bitMask & (endIdx >>> shift);
		var _n0 = A2(elm$core$Elm$JsArray$unsafeGet, lastPos, tree);
		if (_n0.$ === 'SubTree') {
			var sub = _n0.a;
			var newSub = A3(elm$core$Array$sliceTree, shift - elm$core$Array$shiftStep, endIdx, sub);
			return (!elm$core$Elm$JsArray$length(newSub)) ? A3(elm$core$Elm$JsArray$slice, 0, lastPos, tree) : A3(
				elm$core$Elm$JsArray$unsafeSet,
				lastPos,
				elm$core$Array$SubTree(newSub),
				A3(elm$core$Elm$JsArray$slice, 0, lastPos + 1, tree));
		} else {
			return A3(elm$core$Elm$JsArray$slice, 0, lastPos, tree);
		}
	});
var elm$core$Array$sliceRight = F2(
	function (end, array) {
		var len = array.a;
		var startShift = array.b;
		var tree = array.c;
		var tail = array.d;
		if (_Utils_eq(end, len)) {
			return array;
		} else {
			if (_Utils_cmp(
				end,
				elm$core$Array$tailIndex(len)) > -1) {
				return A4(
					elm$core$Array$Array_elm_builtin,
					end,
					startShift,
					tree,
					A3(elm$core$Elm$JsArray$slice, 0, elm$core$Array$bitMask & end, tail));
			} else {
				var endIdx = elm$core$Array$tailIndex(end);
				var depth = elm$core$Basics$floor(
					A2(
						elm$core$Basics$logBase,
						elm$core$Array$branchFactor,
						A2(elm$core$Basics$max, 1, endIdx - 1)));
				var newShift = A2(elm$core$Basics$max, 5, depth * elm$core$Array$shiftStep);
				return A4(
					elm$core$Array$Array_elm_builtin,
					end,
					newShift,
					A3(
						elm$core$Array$hoistTree,
						startShift,
						newShift,
						A3(elm$core$Array$sliceTree, startShift, endIdx, tree)),
					A4(elm$core$Array$fetchNewTail, startShift, end, endIdx, tree));
			}
		}
	});
var elm$core$Array$translateIndex = F2(
	function (index, _n0) {
		var len = _n0.a;
		var posIndex = (index < 0) ? (len + index) : index;
		return (posIndex < 0) ? 0 : ((_Utils_cmp(posIndex, len) > 0) ? len : posIndex);
	});
var elm$core$Array$slice = F3(
	function (from, to, array) {
		var correctTo = A2(elm$core$Array$translateIndex, to, array);
		var correctFrom = A2(elm$core$Array$translateIndex, from, array);
		return (_Utils_cmp(correctFrom, correctTo) > 0) ? elm$core$Array$empty : A2(
			elm$core$Array$sliceLeft,
			correctFrom,
			A2(elm$core$Array$sliceRight, correctTo, array));
	});
var author$project$DynamicMatrix$insertAt = F3(
	function (index, outer, inner) {
		var secondHalf = A3(
			elm$core$Array$slice,
			index,
			elm$core$Array$length(outer),
			outer);
		var firstHalf = A3(elm$core$Array$slice, 0, index, outer);
		return A3(author$project$DynamicMatrix$insertBetween, firstHalf, secondHalf, inner);
	});
var elm$core$List$repeatHelp = F3(
	function (result, n, value) {
		repeatHelp:
		while (true) {
			if (n <= 0) {
				return result;
			} else {
				var $temp$result = A2(elm$core$List$cons, value, result),
					$temp$n = n - 1,
					$temp$value = value;
				result = $temp$result;
				n = $temp$n;
				value = $temp$value;
				continue repeatHelp;
			}
		}
	});
var elm$core$List$repeat = F2(
	function (n, value) {
		return A3(elm$core$List$repeatHelp, _List_Nil, n, value);
	});
var author$project$DynamicMatrix$doubleMatrixFrom = F2(
	function (index, matrix) {
		doubleMatrixFrom:
		while (true) {
			var dividingPoint = matrix.size + ((matrix.size * 2) * index);
			if (_Utils_cmp(
				dividingPoint,
				elm$core$Array$length(matrix.data)) > -1) {
				return {
					data: A2(
						elm$core$Array$append,
						matrix.data,
						elm$core$Array$fromList(
							A2(elm$core$List$repeat, ((matrix.size * matrix.size) * 2) + matrix.size, matrix._default))),
					_default: matrix._default,
					size: matrix.size * 2
				};
			} else {
				var $temp$index = index + 1,
					$temp$matrix = {
					data: A3(
						author$project$DynamicMatrix$insertAt,
						dividingPoint,
						matrix.data,
						elm$core$Array$fromList(
							A2(elm$core$List$repeat, matrix.size, matrix._default))),
					_default: matrix._default,
					size: matrix.size
				};
				index = $temp$index;
				matrix = $temp$matrix;
				continue doubleMatrixFrom;
			}
		}
	});
var author$project$DynamicMatrix$double = function (matrix) {
	return A2(author$project$DynamicMatrix$doubleMatrixFrom, 0, matrix);
};
var elm$core$Array$setHelp = F4(
	function (shift, index, value, tree) {
		var pos = elm$core$Array$bitMask & (index >>> shift);
		var _n0 = A2(elm$core$Elm$JsArray$unsafeGet, pos, tree);
		if (_n0.$ === 'SubTree') {
			var subTree = _n0.a;
			var newSub = A4(elm$core$Array$setHelp, shift - elm$core$Array$shiftStep, index, value, subTree);
			return A3(
				elm$core$Elm$JsArray$unsafeSet,
				pos,
				elm$core$Array$SubTree(newSub),
				tree);
		} else {
			var values = _n0.a;
			var newLeaf = A3(elm$core$Elm$JsArray$unsafeSet, elm$core$Array$bitMask & index, value, values);
			return A3(
				elm$core$Elm$JsArray$unsafeSet,
				pos,
				elm$core$Array$Leaf(newLeaf),
				tree);
		}
	});
var elm$core$Array$set = F3(
	function (index, value, array) {
		var len = array.a;
		var startShift = array.b;
		var tree = array.c;
		var tail = array.d;
		return ((index < 0) || (_Utils_cmp(index, len) > -1)) ? array : ((_Utils_cmp(
			index,
			elm$core$Array$tailIndex(len)) > -1) ? A4(
			elm$core$Array$Array_elm_builtin,
			len,
			startShift,
			tree,
			A3(elm$core$Elm$JsArray$unsafeSet, elm$core$Array$bitMask & index, value, tail)) : A4(
			elm$core$Array$Array_elm_builtin,
			len,
			startShift,
			A4(elm$core$Array$setHelp, startShift, index, value, tree),
			tail));
	});
var author$project$DynamicMatrix$set = F3(
	function (coordinate, val, matrix) {
		set:
		while (true) {
			if ((coordinate.x < 0) || (coordinate.y < 0)) {
				return matrix;
			} else {
				if ((_Utils_cmp(coordinate.x, matrix.size) < 0) && (_Utils_cmp(coordinate.y, matrix.size) < 0)) {
					return {
						data: A3(elm$core$Array$set, coordinate.x + (matrix.size * coordinate.y), val, matrix.data),
						_default: matrix._default,
						size: matrix.size
					};
				} else {
					var $temp$coordinate = coordinate,
						$temp$val = val,
						$temp$matrix = author$project$DynamicMatrix$double(matrix);
					coordinate = $temp$coordinate;
					val = $temp$val;
					matrix = $temp$matrix;
					continue set;
				}
			}
		}
	});
var author$project$DynamicMatrix$transformElement = F3(
	function (coordinate, transformation, matrix) {
		var value = A2(
			elm$core$Maybe$withDefault,
			matrix._default,
			A2(author$project$DynamicMatrix$get, coordinate, matrix));
		return A3(
			author$project$DynamicMatrix$set,
			coordinate,
			transformation(value),
			matrix);
	});
var author$project$DayThree$addCoordinates = F2(
	function (coordinateList, matrix) {
		addCoordinates:
		while (true) {
			if (coordinateList.b) {
				var head = coordinateList.a;
				var tail = coordinateList.b;
				var $temp$coordinateList = tail,
					$temp$matrix = A3(
					author$project$DynamicMatrix$transformElement,
					head,
					elm$core$Basics$add(1),
					matrix);
				coordinateList = $temp$coordinateList;
				matrix = $temp$matrix;
				continue addCoordinates;
			} else {
				return matrix;
			}
		}
	});
var elm$core$Basics$modBy = _Basics_modBy;
var author$project$DayThree$toCoordinateListWithIndex = F3(
	function (index, rectangle, list) {
		toCoordinateListWithIndex:
		while (true) {
			var nextCoordinate = {
				x: rectangle.coordinate.x + A2(elm$core$Basics$modBy, rectangle.dimensions.width, rectangle.coordinate.x + index),
				y: rectangle.coordinate.y + ((index / rectangle.dimensions.width) | 0)
			};
			if (_Utils_cmp(index, rectangle.dimensions.width * rectangle.dimensions.height) < 0) {
				var $temp$index = index + 1,
					$temp$rectangle = rectangle,
					$temp$list = A2(elm$core$List$cons, nextCoordinate, list);
				index = $temp$index;
				rectangle = $temp$rectangle;
				list = $temp$list;
				continue toCoordinateListWithIndex;
			} else {
				return list;
			}
		}
	});
var author$project$DayThree$toCoordinateList = function (rectangle) {
	return A3(author$project$DayThree$toCoordinateListWithIndex, 0, rectangle, _List_Nil);
};
var author$project$DayThree$addRectangle = F2(
	function (rectangle, matrix) {
		return A2(
			author$project$DayThree$addCoordinates,
			author$project$DayThree$toCoordinateList(rectangle),
			matrix);
	});
var author$project$DayThree$addRectangles = F2(
	function (rectangleList, matrix) {
		addRectangles:
		while (true) {
			if (rectangleList.b) {
				var head = rectangleList.a;
				var tail = rectangleList.b;
				var $temp$rectangleList = tail,
					$temp$matrix = A2(author$project$DayThree$addRectangle, head, matrix);
				rectangleList = $temp$rectangleList;
				matrix = $temp$matrix;
				continue addRectangles;
			} else {
				return matrix;
			}
		}
	});
var author$project$DayThreeInput$rawInput = '#1 @ 429,177: 12x27\n#2 @ 862,948: 20x11\n#3 @ 783,463: 22x20\n#4 @ 603,555: 29x23\n#5 @ 553,529: 25x11\n#6 @ 219,969: 14x20\n#7 @ 873,917: 29x16\n#8 @ 752,63: 27x29\n#9 @ 112,119: 18x28\n#10 @ 257,504: 10x15\n#11 @ 807,884: 26x13\n#12 @ 222,600: 14x12\n#13 @ 80,113: 21x10\n#14 @ 88,626: 10x26\n#15 @ 500,196: 17x29\n#16 @ 242,436: 16x22\n#17 @ 334,714: 22x22\n#18 @ 371,130: 23x10\n#19 @ 46,847: 29x25\n#20 @ 215,950: 29x20\n#21 @ 216,427: 12x13\n#22 @ 184,230: 13x25\n#23 @ 828,217: 11x23\n#24 @ 390,276: 27x15\n#25 @ 15,381: 10x12\n#26 @ 303,953: 23x20\n#27 @ 928,149: 14x25\n#28 @ 210,792: 11x11\n#29 @ 885,694: 16x28\n#30 @ 283,819: 13x15\n#31 @ 214,249: 18x28\n#32 @ 983,900: 12x27\n#33 @ 144,886: 15x23\n#34 @ 891,876: 18x19\n#35 @ 739,113: 26x18\n#36 @ 353,814: 15x29\n#37 @ 286,548: 15x24\n#38 @ 921,827: 15x29\n#39 @ 452,895: 18x19\n#40 @ 352,692: 19x27\n#41 @ 692,931: 12x15\n#42 @ 230,559: 24x25\n#43 @ 386,488: 21x20\n#44 @ 578,725: 22x19\n#45 @ 952,16: 28x18\n#46 @ 152,862: 19x16\n#47 @ 825,680: 3x9\n#48 @ 21,381: 13x17\n#49 @ 499,635: 21x28\n#50 @ 211,781: 12x27\n#51 @ 480,311: 21x11\n#52 @ 300,693: 28x14\n#53 @ 332,358: 11x16\n#54 @ 839,548: 24x13\n#55 @ 269,469: 25x25\n#56 @ 397,728: 18x17\n#57 @ 921,636: 14x17\n#58 @ 774,427: 17x16\n#59 @ 484,129: 24x18\n#60 @ 566,45: 28x24\n#61 @ 589,573: 27x23\n#62 @ 709,766: 23x24\n#63 @ 126,62: 4x12\n#64 @ 117,430: 11x12\n#65 @ 733,745: 20x17\n#66 @ 118,279: 26x10\n#67 @ 693,86: 12x19\n#68 @ 159,29: 24x24\n#69 @ 910,467: 19x15\n#70 @ 858,513: 10x29\n#71 @ 433,532: 23x17\n#72 @ 618,146: 28x27\n#73 @ 240,594: 13x15\n#74 @ 299,528: 11x22\n#75 @ 416,233: 13x28\n#76 @ 287,442: 17x28\n#77 @ 32,671: 24x14\n#78 @ 342,948: 29x22\n#79 @ 934,110: 20x10\n#80 @ 750,36: 15x10\n#81 @ 552,927: 11x17\n#82 @ 356,776: 10x16\n#83 @ 463,42: 10x14\n#84 @ 780,102: 16x18\n#85 @ 650,384: 18x10\n#86 @ 3,8: 29x12\n#87 @ 367,429: 27x11\n#88 @ 470,525: 10x16\n#89 @ 115,777: 12x28\n#90 @ 460,534: 15x15\n#91 @ 199,673: 27x21\n#92 @ 954,717: 13x19\n#93 @ 5,682: 16x19\n#94 @ 582,4: 17x13\n#95 @ 405,823: 14x18\n#96 @ 506,499: 11x21\n#97 @ 155,815: 28x20\n#98 @ 337,392: 10x21\n#99 @ 877,585: 27x27\n#100 @ 878,891: 11x14\n#101 @ 583,405: 20x24\n#102 @ 127,117: 11x16\n#103 @ 246,38: 18x23\n#104 @ 175,427: 10x26\n#105 @ 668,229: 26x12\n#106 @ 11,434: 29x22\n#107 @ 553,460: 14x23\n#108 @ 228,235: 22x22\n#109 @ 165,299: 16x11\n#110 @ 265,424: 22x10\n#111 @ 461,884: 11x15\n#112 @ 10,38: 17x28\n#113 @ 633,562: 24x29\n#114 @ 794,401: 11x17\n#115 @ 435,872: 17x18\n#116 @ 807,239: 11x12\n#117 @ 922,65: 23x13\n#118 @ 886,607: 29x17\n#119 @ 1,625: 15x12\n#120 @ 498,569: 24x21\n#121 @ 204,831: 23x18\n#122 @ 564,551: 25x12\n#123 @ 131,541: 19x20\n#124 @ 772,356: 20x12\n#125 @ 353,902: 19x10\n#126 @ 198,663: 17x21\n#127 @ 449,207: 16x12\n#128 @ 12,182: 16x15\n#129 @ 908,20: 29x27\n#130 @ 32,572: 14x20\n#131 @ 383,977: 13x20\n#132 @ 81,502: 28x19\n#133 @ 565,767: 27x22\n#134 @ 214,942: 4x8\n#135 @ 464,190: 20x21\n#136 @ 741,68: 19x19\n#137 @ 413,67: 21x23\n#138 @ 507,820: 21x12\n#139 @ 360,938: 16x11\n#140 @ 484,831: 15x21\n#141 @ 733,931: 29x11\n#142 @ 219,692: 27x25\n#143 @ 636,584: 11x26\n#144 @ 48,659: 21x18\n#145 @ 975,850: 14x29\n#146 @ 359,831: 19x23\n#147 @ 800,901: 26x16\n#148 @ 388,195: 25x25\n#149 @ 155,320: 20x20\n#150 @ 827,207: 13x25\n#151 @ 11,489: 15x17\n#152 @ 26,587: 11x20\n#153 @ 448,477: 24x26\n#154 @ 750,250: 19x23\n#155 @ 912,628: 23x11\n#156 @ 589,328: 18x18\n#157 @ 292,335: 13x16\n#158 @ 751,357: 12x28\n#159 @ 233,775: 16x16\n#160 @ 855,923: 22x16\n#161 @ 439,517: 27x21\n#162 @ 465,829: 25x21\n#163 @ 435,635: 11x20\n#164 @ 354,394: 10x11\n#165 @ 507,928: 13x14\n#166 @ 541,899: 27x22\n#167 @ 702,939: 28x28\n#168 @ 849,818: 14x26\n#169 @ 776,252: 3x7\n#170 @ 229,32: 14x28\n#171 @ 397,411: 17x18\n#172 @ 35,292: 26x14\n#173 @ 333,174: 13x15\n#174 @ 768,134: 29x19\n#175 @ 46,690: 29x18\n#176 @ 554,773: 28x24\n#177 @ 727,704: 12x16\n#178 @ 295,274: 16x13\n#179 @ 160,707: 25x22\n#180 @ 265,208: 18x28\n#181 @ 815,26: 24x13\n#182 @ 541,154: 29x29\n#183 @ 130,898: 27x19\n#184 @ 35,926: 24x21\n#185 @ 65,84: 25x26\n#186 @ 890,919: 20x17\n#187 @ 762,444: 29x13\n#188 @ 154,440: 17x18\n#189 @ 527,514: 16x22\n#190 @ 93,857: 21x14\n#191 @ 352,947: 15x21\n#192 @ 642,434: 17x22\n#193 @ 303,547: 10x24\n#194 @ 611,911: 10x17\n#195 @ 8,715: 26x28\n#196 @ 909,178: 29x11\n#197 @ 225,621: 23x14\n#198 @ 835,411: 26x18\n#199 @ 315,466: 29x11\n#200 @ 234,440: 12x25\n#201 @ 39,773: 23x15\n#202 @ 147,155: 10x14\n#203 @ 186,790: 29x20\n#204 @ 651,389: 12x24\n#205 @ 612,930: 17x11\n#206 @ 73,238: 12x21\n#207 @ 458,808: 14x17\n#208 @ 742,784: 8x6\n#209 @ 754,878: 20x16\n#210 @ 176,698: 20x15\n#211 @ 831,442: 19x16\n#212 @ 411,262: 24x15\n#213 @ 422,948: 11x18\n#214 @ 67,108: 29x27\n#215 @ 713,538: 10x23\n#216 @ 528,153: 26x25\n#217 @ 878,238: 29x24\n#218 @ 494,54: 15x17\n#219 @ 878,892: 11x14\n#220 @ 478,269: 23x13\n#221 @ 595,908: 20x23\n#222 @ 73,120: 15x27\n#223 @ 766,792: 15x20\n#224 @ 562,263: 21x25\n#225 @ 164,790: 23x11\n#226 @ 49,290: 23x13\n#227 @ 413,625: 28x24\n#228 @ 168,197: 24x22\n#229 @ 458,886: 13x14\n#230 @ 285,457: 29x14\n#231 @ 972,133: 14x28\n#232 @ 757,267: 16x14\n#233 @ 680,958: 25x10\n#234 @ 889,35: 24x11\n#235 @ 835,535: 19x28\n#236 @ 590,81: 5x6\n#237 @ 863,589: 19x23\n#238 @ 761,726: 23x16\n#239 @ 837,819: 21x23\n#240 @ 12,632: 18x22\n#241 @ 805,922: 29x15\n#242 @ 836,520: 19x28\n#243 @ 89,622: 15x24\n#244 @ 397,818: 10x13\n#245 @ 163,337: 18x25\n#246 @ 47,967: 23x29\n#247 @ 595,195: 11x12\n#248 @ 620,601: 11x28\n#249 @ 425,264: 6x4\n#250 @ 765,741: 26x28\n#251 @ 475,571: 28x26\n#252 @ 79,536: 12x24\n#253 @ 30,420: 24x15\n#254 @ 450,214: 25x26\n#255 @ 932,685: 26x26\n#256 @ 277,390: 27x18\n#257 @ 238,264: 24x14\n#258 @ 766,254: 21x16\n#259 @ 852,820: 3x19\n#260 @ 521,21: 23x11\n#261 @ 743,821: 27x11\n#262 @ 415,84: 18x28\n#263 @ 506,286: 19x22\n#264 @ 128,913: 14x20\n#265 @ 521,152: 12x26\n#266 @ 790,445: 15x16\n#267 @ 113,297: 25x22\n#268 @ 418,62: 28x11\n#269 @ 609,594: 28x19\n#270 @ 500,538: 21x19\n#271 @ 153,290: 19x24\n#272 @ 369,114: 18x22\n#273 @ 26,710: 15x25\n#274 @ 907,958: 17x21\n#275 @ 119,52: 18x29\n#276 @ 154,484: 12x18\n#277 @ 8,364: 21x24\n#278 @ 665,320: 4x7\n#279 @ 212,136: 17x13\n#280 @ 141,418: 22x14\n#281 @ 17,479: 19x21\n#282 @ 911,819: 17x19\n#283 @ 505,705: 21x11\n#284 @ 357,964: 16x26\n#285 @ 540,502: 21x13\n#286 @ 103,868: 15x24\n#287 @ 945,365: 19x25\n#288 @ 970,806: 20x14\n#289 @ 871,887: 13x28\n#290 @ 461,909: 26x21\n#291 @ 360,252: 27x23\n#292 @ 670,351: 29x18\n#293 @ 551,707: 12x28\n#294 @ 578,839: 22x26\n#295 @ 876,955: 29x29\n#296 @ 571,140: 15x21\n#297 @ 634,801: 23x17\n#298 @ 489,415: 23x20\n#299 @ 396,962: 21x15\n#300 @ 722,128: 29x25\n#301 @ 169,707: 20x13\n#302 @ 584,176: 19x13\n#303 @ 738,602: 19x13\n#304 @ 48,756: 15x20\n#305 @ 334,360: 16x18\n#306 @ 421,613: 18x27\n#307 @ 775,414: 21x21\n#308 @ 680,166: 18x23\n#309 @ 984,884: 7x5\n#310 @ 241,967: 11x18\n#311 @ 308,398: 28x17\n#312 @ 236,984: 11x10\n#313 @ 108,24: 26x14\n#314 @ 894,1: 12x16\n#315 @ 544,773: 18x18\n#316 @ 103,754: 15x22\n#317 @ 563,139: 14x13\n#318 @ 394,878: 15x12\n#319 @ 744,370: 15x28\n#320 @ 463,874: 10x20\n#321 @ 359,308: 15x17\n#322 @ 877,771: 19x20\n#323 @ 902,875: 13x21\n#324 @ 272,267: 19x12\n#325 @ 543,527: 17x21\n#326 @ 5,650: 25x18\n#327 @ 584,592: 20x15\n#328 @ 730,355: 21x21\n#329 @ 720,889: 20x11\n#330 @ 412,334: 28x23\n#331 @ 311,217: 20x24\n#332 @ 281,932: 12x19\n#333 @ 58,53: 16x20\n#334 @ 545,557: 27x23\n#335 @ 868,585: 20x10\n#336 @ 748,782: 16x24\n#337 @ 411,841: 23x21\n#338 @ 240,12: 20x27\n#339 @ 793,7: 14x22\n#340 @ 215,115: 14x17\n#341 @ 318,178: 15x12\n#342 @ 695,31: 16x26\n#343 @ 735,770: 19x28\n#344 @ 777,786: 22x16\n#345 @ 531,501: 20x17\n#346 @ 569,1: 20x27\n#347 @ 424,146: 20x18\n#348 @ 530,652: 28x17\n#349 @ 470,857: 29x16\n#350 @ 590,43: 20x26\n#351 @ 909,890: 15x18\n#352 @ 406,23: 29x20\n#353 @ 254,506: 27x18\n#354 @ 231,172: 19x24\n#355 @ 651,567: 3x10\n#356 @ 258,313: 19x15\n#357 @ 920,169: 12x23\n#358 @ 707,474: 24x11\n#359 @ 810,854: 20x15\n#360 @ 428,661: 29x11\n#361 @ 115,433: 13x24\n#362 @ 977,181: 15x25\n#363 @ 747,125: 26x23\n#364 @ 635,286: 22x29\n#365 @ 788,246: 10x17\n#366 @ 275,258: 13x12\n#367 @ 635,362: 16x21\n#368 @ 447,903: 26x20\n#369 @ 939,559: 27x20\n#370 @ 929,550: 23x28\n#371 @ 764,722: 28x14\n#372 @ 884,764: 24x21\n#373 @ 290,153: 28x20\n#374 @ 868,560: 28x11\n#375 @ 759,712: 18x12\n#376 @ 654,468: 26x26\n#377 @ 390,425: 17x28\n#378 @ 678,224: 11x10\n#379 @ 937,226: 13x22\n#380 @ 533,313: 14x21\n#381 @ 239,695: 26x26\n#382 @ 632,160: 21x13\n#383 @ 727,271: 15x19\n#384 @ 8,532: 18x20\n#385 @ 232,978: 29x15\n#386 @ 431,371: 21x11\n#387 @ 875,299: 22x19\n#388 @ 479,678: 17x26\n#389 @ 108,951: 19x23\n#390 @ 735,112: 20x18\n#391 @ 318,893: 17x20\n#392 @ 194,215: 17x19\n#393 @ 214,528: 28x15\n#394 @ 46,142: 26x12\n#395 @ 528,379: 26x25\n#396 @ 479,646: 13x14\n#397 @ 865,562: 17x13\n#398 @ 441,142: 29x15\n#399 @ 174,199: 24x17\n#400 @ 561,47: 21x24\n#401 @ 629,284: 17x22\n#402 @ 19,654: 20x16\n#403 @ 101,568: 11x23\n#404 @ 641,262: 13x26\n#405 @ 709,960: 22x17\n#406 @ 939,522: 13x5\n#407 @ 317,400: 8x10\n#408 @ 829,239: 23x21\n#409 @ 288,438: 28x20\n#410 @ 452,405: 16x20\n#411 @ 718,197: 24x13\n#412 @ 607,956: 11x18\n#413 @ 777,65: 28x19\n#414 @ 548,933: 17x28\n#415 @ 255,696: 29x23\n#416 @ 245,954: 24x23\n#417 @ 942,688: 27x14\n#418 @ 671,254: 19x29\n#419 @ 152,554: 22x25\n#420 @ 312,457: 14x14\n#421 @ 202,959: 27x22\n#422 @ 622,27: 26x19\n#423 @ 957,700: 13x18\n#424 @ 555,477: 26x13\n#425 @ 652,652: 15x10\n#426 @ 89,165: 26x26\n#427 @ 23,906: 17x25\n#428 @ 648,157: 13x19\n#429 @ 789,16: 22x14\n#430 @ 56,288: 27x15\n#431 @ 855,805: 24x22\n#432 @ 139,316: 25x18\n#433 @ 715,539: 21x14\n#434 @ 203,689: 21x22\n#435 @ 244,334: 16x16\n#436 @ 436,626: 21x28\n#437 @ 809,228: 17x14\n#438 @ 900,244: 28x15\n#439 @ 945,13: 12x22\n#440 @ 817,479: 13x5\n#441 @ 869,440: 8x4\n#442 @ 528,730: 19x20\n#443 @ 9,707: 24x17\n#444 @ 44,70: 27x29\n#445 @ 577,461: 10x12\n#446 @ 31,742: 11x16\n#447 @ 717,227: 21x18\n#448 @ 129,130: 10x18\n#449 @ 87,929: 17x11\n#450 @ 807,849: 20x26\n#451 @ 583,586: 11x23\n#452 @ 483,150: 22x21\n#453 @ 223,731: 13x14\n#454 @ 402,834: 13x25\n#455 @ 131,782: 18x27\n#456 @ 21,693: 10x10\n#457 @ 672,226: 20x17\n#458 @ 490,953: 21x17\n#459 @ 374,924: 17x4\n#460 @ 660,488: 20x11\n#461 @ 155,16: 22x13\n#462 @ 135,829: 22x16\n#463 @ 593,620: 20x13\n#464 @ 142,9: 29x14\n#465 @ 493,708: 16x14\n#466 @ 541,636: 25x19\n#467 @ 342,179: 25x18\n#468 @ 499,563: 15x22\n#469 @ 643,368: 20x17\n#470 @ 7,679: 28x14\n#471 @ 77,865: 17x28\n#472 @ 875,800: 26x28\n#473 @ 422,862: 26x18\n#474 @ 972,880: 25x14\n#475 @ 892,963: 24x13\n#476 @ 448,536: 14x10\n#477 @ 210,940: 13x13\n#478 @ 361,197: 27x16\n#479 @ 787,417: 17x28\n#480 @ 976,467: 17x15\n#481 @ 592,316: 18x21\n#482 @ 589,931: 24x12\n#483 @ 361,207: 20x20\n#484 @ 831,802: 19x29\n#485 @ 466,399: 10x28\n#486 @ 381,971: 15x11\n#487 @ 552,629: 12x10\n#488 @ 172,713: 10x28\n#489 @ 849,106: 16x20\n#490 @ 35,660: 26x27\n#491 @ 37,762: 18x25\n#492 @ 174,926: 29x28\n#493 @ 113,323: 26x14\n#494 @ 586,78: 19x16\n#495 @ 539,313: 13x12\n#496 @ 685,97: 22x13\n#497 @ 10,515: 29x20\n#498 @ 90,852: 16x18\n#499 @ 496,868: 12x26\n#500 @ 141,8: 25x13\n#501 @ 705,219: 13x14\n#502 @ 168,181: 25x17\n#503 @ 162,16: 15x14\n#504 @ 291,943: 28x23\n#505 @ 203,394: 28x16\n#506 @ 243,967: 12x22\n#507 @ 130,595: 15x20\n#508 @ 489,803: 27x27\n#509 @ 694,701: 14x16\n#510 @ 461,147: 29x13\n#511 @ 914,952: 26x28\n#512 @ 701,192: 13x26\n#513 @ 289,130: 12x29\n#514 @ 590,380: 19x26\n#515 @ 488,939: 24x11\n#516 @ 8,469: 20x23\n#517 @ 776,424: 20x10\n#518 @ 850,807: 25x19\n#519 @ 814,557: 24x13\n#520 @ 754,695: 19x16\n#521 @ 973,173: 14x11\n#522 @ 548,559: 14x16\n#523 @ 232,255: 19x10\n#524 @ 276,904: 16x27\n#525 @ 487,197: 17x22\n#526 @ 80,524: 18x24\n#527 @ 169,14: 27x18\n#528 @ 938,190: 12x23\n#529 @ 776,963: 18x21\n#530 @ 698,938: 12x28\n#531 @ 528,27: 28x16\n#532 @ 42,186: 27x16\n#533 @ 532,312: 17x16\n#534 @ 113,842: 14x24\n#535 @ 245,149: 15x29\n#536 @ 741,690: 21x27\n#537 @ 220,102: 11x16\n#538 @ 753,770: 22x12\n#539 @ 117,918: 22x20\n#540 @ 722,533: 17x12\n#541 @ 578,255: 22x15\n#542 @ 505,117: 16x25\n#543 @ 152,138: 21x29\n#544 @ 595,704: 22x24\n#545 @ 720,98: 27x10\n#546 @ 754,571: 21x26\n#547 @ 10,353: 24x16\n#548 @ 163,11: 12x26\n#549 @ 683,859: 18x27\n#550 @ 771,579: 26x27\n#551 @ 22,772: 21x14\n#552 @ 265,388: 19x22\n#553 @ 589,431: 18x11\n#554 @ 348,382: 11x28\n#555 @ 33,387: 20x27\n#556 @ 74,417: 23x17\n#557 @ 297,954: 17x19\n#558 @ 426,666: 12x23\n#559 @ 364,247: 16x15\n#560 @ 854,944: 14x15\n#561 @ 369,916: 27x16\n#562 @ 738,65: 26x16\n#563 @ 804,204: 19x18\n#564 @ 722,483: 27x19\n#565 @ 492,109: 18x12\n#566 @ 564,722: 25x13\n#567 @ 31,366: 14x19\n#568 @ 635,271: 23x22\n#569 @ 823,678: 24x12\n#570 @ 320,103: 11x22\n#571 @ 450,879: 18x21\n#572 @ 119,705: 20x14\n#573 @ 634,149: 17x22\n#574 @ 770,664: 15x13\n#575 @ 256,303: 16x22\n#576 @ 554,180: 29x13\n#577 @ 661,273: 16x27\n#578 @ 361,688: 10x18\n#579 @ 578,573: 10x28\n#580 @ 536,710: 19x15\n#581 @ 479,175: 10x24\n#582 @ 313,963: 29x21\n#583 @ 870,878: 13x27\n#584 @ 148,99: 12x12\n#585 @ 2,30: 13x17\n#586 @ 490,680: 29x23\n#587 @ 563,458: 14x23\n#588 @ 517,933: 19x22\n#589 @ 466,885: 10x16\n#590 @ 955,575: 18x17\n#591 @ 400,301: 5x15\n#592 @ 768,208: 18x25\n#593 @ 687,913: 13x27\n#594 @ 282,893: 27x28\n#595 @ 410,339: 12x17\n#596 @ 552,764: 29x24\n#597 @ 25,165: 25x29\n#598 @ 126,796: 11x24\n#599 @ 689,704: 17x14\n#600 @ 509,956: 10x22\n#601 @ 484,604: 11x27\n#602 @ 551,538: 21x29\n#603 @ 433,845: 29x27\n#604 @ 702,699: 29x17\n#605 @ 5,528: 12x20\n#606 @ 849,804: 13x16\n#607 @ 769,707: 17x21\n#608 @ 514,557: 17x16\n#609 @ 275,733: 17x11\n#610 @ 608,973: 17x14\n#611 @ 967,855: 14x25\n#612 @ 48,653: 13x19\n#613 @ 508,119: 14x23\n#614 @ 957,866: 14x17\n#615 @ 345,785: 28x29\n#616 @ 175,141: 20x20\n#617 @ 111,426: 28x27\n#618 @ 854,362: 19x17\n#619 @ 935,172: 10x13\n#620 @ 282,498: 12x29\n#621 @ 248,546: 19x23\n#622 @ 75,824: 23x11\n#623 @ 695,800: 13x20\n#624 @ 62,147: 14x17\n#625 @ 150,962: 28x27\n#626 @ 574,576: 16x21\n#627 @ 271,510: 19x16\n#628 @ 194,615: 25x18\n#629 @ 977,150: 14x18\n#630 @ 300,269: 17x28\n#631 @ 290,528: 11x21\n#632 @ 546,387: 18x26\n#633 @ 171,30: 24x10\n#634 @ 476,628: 12x21\n#635 @ 676,907: 19x13\n#636 @ 230,605: 27x10\n#637 @ 514,736: 17x29\n#638 @ 5,490: 14x27\n#639 @ 364,680: 10x17\n#640 @ 398,251: 20x16\n#641 @ 150,101: 6x5\n#642 @ 109,420: 19x26\n#643 @ 118,715: 27x10\n#644 @ 979,723: 10x18\n#645 @ 530,729: 16x20\n#646 @ 724,284: 14x21\n#647 @ 164,89: 26x15\n#648 @ 218,833: 4x13\n#649 @ 697,207: 13x13\n#650 @ 482,5: 19x13\n#651 @ 383,142: 15x29\n#652 @ 734,287: 14x24\n#653 @ 727,956: 28x22\n#654 @ 588,424: 17x20\n#655 @ 602,582: 22x23\n#656 @ 936,520: 21x13\n#657 @ 110,304: 20x19\n#658 @ 368,689: 25x11\n#659 @ 139,966: 25x28\n#660 @ 369,289: 11x20\n#661 @ 821,483: 24x21\n#662 @ 690,171: 10x28\n#663 @ 409,696: 20x16\n#664 @ 836,557: 17x24\n#665 @ 466,407: 28x27\n#666 @ 244,573: 29x21\n#667 @ 439,475: 14x26\n#668 @ 570,337: 14x17\n#669 @ 276,244: 12x15\n#670 @ 157,271: 20x19\n#671 @ 984,460: 13x29\n#672 @ 38,109: 14x11\n#673 @ 318,369: 26x27\n#674 @ 706,262: 23x22\n#675 @ 292,547: 11x22\n#676 @ 774,750: 28x11\n#677 @ 869,507: 13x24\n#678 @ 214,746: 13x14\n#679 @ 711,753: 22x12\n#680 @ 482,861: 18x10\n#681 @ 926,53: 12x25\n#682 @ 282,901: 29x24\n#683 @ 578,825: 29x23\n#684 @ 262,555: 17x25\n#685 @ 476,930: 23x10\n#686 @ 928,239: 13x11\n#687 @ 691,43: 28x17\n#688 @ 711,194: 15x23\n#689 @ 83,157: 12x16\n#690 @ 59,853: 14x24\n#691 @ 9,384: 10x13\n#692 @ 655,814: 12x24\n#693 @ 928,33: 20x25\n#694 @ 271,716: 15x25\n#695 @ 190,710: 19x19\n#696 @ 436,851: 12x24\n#697 @ 445,294: 14x26\n#698 @ 544,889: 11x21\n#699 @ 361,304: 24x13\n#700 @ 787,333: 18x28\n#701 @ 442,851: 16x14\n#702 @ 542,962: 20x12\n#703 @ 876,920: 20x10\n#704 @ 920,65: 15x26\n#705 @ 393,176: 28x23\n#706 @ 528,428: 6x3\n#707 @ 700,72: 11x13\n#708 @ 133,350: 23x26\n#709 @ 485,630: 27x11\n#710 @ 174,150: 10x11\n#711 @ 675,192: 29x11\n#712 @ 182,190: 10x12\n#713 @ 105,21: 26x25\n#714 @ 957,479: 28x18\n#715 @ 577,942: 13x17\n#716 @ 313,824: 19x27\n#717 @ 845,175: 23x16\n#718 @ 198,397: 19x15\n#719 @ 544,203: 24x25\n#720 @ 236,626: 11x24\n#721 @ 210,373: 25x26\n#722 @ 441,483: 25x14\n#723 @ 154,850: 20x12\n#724 @ 50,165: 17x28\n#725 @ 284,267: 10x21\n#726 @ 803,395: 10x24\n#727 @ 742,793: 14x27\n#728 @ 951,576: 11x23\n#729 @ 269,434: 24x11\n#730 @ 160,658: 15x18\n#731 @ 239,866: 26x27\n#732 @ 325,187: 25x16\n#733 @ 649,547: 12x20\n#734 @ 646,438: 11x21\n#735 @ 199,127: 24x17\n#736 @ 178,322: 13x29\n#737 @ 777,18: 16x23\n#738 @ 72,121: 14x21\n#739 @ 204,718: 29x13\n#740 @ 750,887: 12x25\n#741 @ 884,804: 10x18\n#742 @ 642,618: 10x20\n#743 @ 734,667: 14x14\n#744 @ 262,670: 26x23\n#745 @ 218,599: 21x21\n#746 @ 726,266: 13x25\n#747 @ 742,956: 25x20\n#748 @ 147,110: 15x14\n#749 @ 62,381: 12x23\n#750 @ 247,628: 10x29\n#751 @ 948,190: 11x26\n#752 @ 284,545: 10x15\n#753 @ 851,927: 13x13\n#754 @ 331,568: 21x13\n#755 @ 180,200: 12x13\n#756 @ 979,926: 20x23\n#757 @ 957,940: 21x26\n#758 @ 297,833: 22x25\n#759 @ 601,53: 22x15\n#760 @ 223,264: 22x19\n#761 @ 384,881: 21x11\n#762 @ 245,966: 14x22\n#763 @ 397,740: 15x16\n#764 @ 579,320: 17x29\n#765 @ 132,947: 19x19\n#766 @ 482,927: 17x21\n#767 @ 773,249: 11x15\n#768 @ 366,407: 24x25\n#769 @ 802,56: 13x27\n#770 @ 581,370: 23x11\n#771 @ 431,429: 15x28\n#772 @ 130,0: 22x13\n#773 @ 815,116: 19x10\n#774 @ 922,617: 16x10\n#775 @ 193,979: 29x13\n#776 @ 817,819: 18x13\n#777 @ 753,270: 28x12\n#778 @ 759,709: 14x18\n#779 @ 582,750: 13x14\n#780 @ 387,490: 21x13\n#781 @ 114,766: 17x11\n#782 @ 777,260: 21x10\n#783 @ 529,151: 15x19\n#784 @ 686,547: 27x22\n#785 @ 259,271: 27x11\n#786 @ 192,271: 5x9\n#787 @ 238,507: 20x13\n#788 @ 129,577: 25x22\n#789 @ 835,411: 28x13\n#790 @ 547,549: 25x18\n#791 @ 933,40: 16x15\n#792 @ 815,553: 11x18\n#793 @ 503,10: 18x24\n#794 @ 951,25: 18x23\n#795 @ 71,387: 25x27\n#796 @ 405,252: 12x21\n#797 @ 918,790: 27x24\n#798 @ 832,851: 26x27\n#799 @ 909,769: 18x15\n#800 @ 864,515: 17x15\n#801 @ 342,823: 17x19\n#802 @ 591,976: 18x22\n#803 @ 310,573: 28x18\n#804 @ 101,569: 13x11\n#805 @ 369,376: 24x11\n#806 @ 723,731: 20x15\n#807 @ 394,268: 12x21\n#808 @ 154,899: 29x13\n#809 @ 188,599: 27x18\n#810 @ 433,171: 25x13\n#811 @ 925,905: 20x24\n#812 @ 633,430: 17x18\n#813 @ 187,268: 16x19\n#814 @ 467,886: 13x16\n#815 @ 897,746: 26x13\n#816 @ 308,689: 23x21\n#817 @ 966,385: 15x28\n#818 @ 368,293: 13x14\n#819 @ 821,804: 17x29\n#820 @ 890,715: 13x20\n#821 @ 755,145: 23x12\n#822 @ 860,545: 10x26\n#823 @ 797,518: 26x25\n#824 @ 625,3: 27x27\n#825 @ 359,201: 17x17\n#826 @ 720,614: 23x28\n#827 @ 104,795: 18x24\n#828 @ 885,965: 10x17\n#829 @ 530,731: 25x20\n#830 @ 919,264: 11x22\n#831 @ 150,950: 14x24\n#832 @ 785,213: 14x12\n#833 @ 413,627: 15x23\n#834 @ 723,689: 10x10\n#835 @ 828,202: 19x23\n#836 @ 241,262: 13x11\n#837 @ 788,26: 18x22\n#838 @ 203,172: 20x19\n#839 @ 181,207: 14x15\n#840 @ 915,680: 14x10\n#841 @ 742,399: 22x28\n#842 @ 760,95: 21x28\n#843 @ 152,75: 18x23\n#844 @ 47,286: 13x27\n#845 @ 923,20: 17x20\n#846 @ 305,940: 13x19\n#847 @ 691,504: 15x11\n#848 @ 73,228: 26x13\n#849 @ 329,512: 18x15\n#850 @ 154,85: 10x29\n#851 @ 200,157: 12x27\n#852 @ 209,692: 11x10\n#853 @ 242,331: 14x26\n#854 @ 895,118: 19x16\n#855 @ 580,973: 19x23\n#856 @ 663,317: 11x18\n#857 @ 922,548: 26x16\n#858 @ 930,784: 14x11\n#859 @ 802,455: 29x27\n#860 @ 888,979: 15x10\n#861 @ 688,91: 14x10\n#862 @ 752,823: 27x13\n#863 @ 61,831: 27x11\n#864 @ 345,944: 11x10\n#865 @ 8,713: 13x27\n#866 @ 298,199: 20x19\n#867 @ 423,260: 14x15\n#868 @ 41,376: 13x17\n#869 @ 204,673: 8x8\n#870 @ 105,288: 15x17\n#871 @ 108,482: 17x28\n#872 @ 603,578: 10x20\n#873 @ 738,674: 12x25\n#874 @ 456,563: 24x13\n#875 @ 340,694: 14x11\n#876 @ 163,560: 15x22\n#877 @ 15,705: 23x11\n#878 @ 849,445: 28x23\n#879 @ 53,664: 21x29\n#880 @ 256,253: 16x21\n#881 @ 609,80: 18x28\n#882 @ 585,93: 25x11\n#883 @ 681,98: 20x19\n#884 @ 318,184: 25x14\n#885 @ 33,517: 16x26\n#886 @ 490,281: 21x12\n#887 @ 613,179: 28x16\n#888 @ 25,968: 11x20\n#889 @ 276,432: 17x10\n#890 @ 482,907: 28x19\n#891 @ 332,737: 29x14\n#892 @ 58,964: 12x21\n#893 @ 728,684: 19x11\n#894 @ 776,660: 10x21\n#895 @ 441,629: 26x15\n#896 @ 467,291: 26x25\n#897 @ 83,183: 14x17\n#898 @ 391,832: 19x26\n#899 @ 364,728: 28x28\n#900 @ 23,498: 26x25\n#901 @ 780,896: 21x13\n#902 @ 330,176: 23x18\n#903 @ 337,690: 25x16\n#904 @ 334,801: 21x24\n#905 @ 176,795: 16x28\n#906 @ 374,929: 23x23\n#907 @ 394,166: 25x21\n#908 @ 633,146: 11x13\n#909 @ 579,129: 12x12\n#910 @ 225,283: 18x27\n#911 @ 277,500: 17x21\n#912 @ 396,299: 13x21\n#913 @ 669,212: 17x22\n#914 @ 372,731: 28x15\n#915 @ 905,10: 25x24\n#916 @ 697,65: 15x20\n#917 @ 190,587: 26x12\n#918 @ 930,54: 15x19\n#919 @ 360,359: 21x18\n#920 @ 15,507: 16x22\n#921 @ 722,512: 12x29\n#922 @ 400,868: 13x21\n#923 @ 707,759: 15x22\n#924 @ 57,70: 26x18\n#925 @ 321,882: 26x11\n#926 @ 408,743: 25x21\n#927 @ 435,371: 15x15\n#928 @ 181,434: 11x21\n#929 @ 571,36: 25x15\n#930 @ 777,545: 22x25\n#931 @ 823,678: 11x16\n#932 @ 7,663: 28x16\n#933 @ 862,259: 29x23\n#934 @ 915,964: 25x26\n#935 @ 843,659: 16x21\n#936 @ 887,236: 23x26\n#937 @ 116,855: 25x21\n#938 @ 210,609: 11x28\n#939 @ 434,51: 17x25\n#940 @ 912,761: 23x11\n#941 @ 948,470: 26x21\n#942 @ 158,887: 13x27\n#943 @ 513,33: 26x23\n#944 @ 832,889: 16x10\n#945 @ 414,691: 24x12\n#946 @ 218,773: 18x16\n#947 @ 869,570: 17x18\n#948 @ 598,585: 27x10\n#949 @ 973,525: 10x28\n#950 @ 117,475: 22x29\n#951 @ 726,426: 24x13\n#952 @ 854,275: 15x11\n#953 @ 312,723: 24x23\n#954 @ 814,477: 20x11\n#955 @ 677,842: 24x18\n#956 @ 880,495: 25x25\n#957 @ 183,33: 20x15\n#958 @ 817,108: 13x10\n#959 @ 922,5: 28x13\n#960 @ 322,464: 18x15\n#961 @ 903,555: 29x26\n#962 @ 826,210: 14x21\n#963 @ 678,183: 15x23\n#964 @ 339,885: 22x12\n#965 @ 328,969: 29x13\n#966 @ 367,721: 10x28\n#967 @ 15,405: 13x22\n#968 @ 961,565: 13x17\n#969 @ 249,131: 22x21\n#970 @ 282,272: 27x22\n#971 @ 965,377: 23x11\n#972 @ 373,886: 23x24\n#973 @ 818,873: 17x15\n#974 @ 976,358: 11x16\n#975 @ 640,561: 23x20\n#976 @ 210,661: 14x22\n#977 @ 722,249: 22x26\n#978 @ 841,461: 15x26\n#979 @ 113,546: 14x23\n#980 @ 474,654: 10x19\n#981 @ 740,123: 14x12\n#982 @ 303,662: 27x13\n#983 @ 514,300: 29x29\n#984 @ 692,784: 28x10\n#985 @ 34,117: 21x22\n#986 @ 867,432: 15x21\n#987 @ 896,967: 21x16\n#988 @ 554,390: 20x12\n#989 @ 698,215: 28x11\n#990 @ 90,625: 14x28\n#991 @ 781,252: 14x11\n#992 @ 106,25: 23x20\n#993 @ 634,455: 12x22\n#994 @ 212,316: 22x28\n#995 @ 576,53: 15x18\n#996 @ 721,304: 10x14\n#997 @ 465,686: 28x20\n#998 @ 611,178: 28x25\n#999 @ 524,426: 18x10\n#1000 @ 681,91: 19x18\n#1001 @ 552,392: 10x16\n#1002 @ 467,435: 14x17\n#1003 @ 839,640: 14x24\n#1004 @ 556,594: 28x19\n#1005 @ 551,952: 20x26\n#1006 @ 919,261: 10x21\n#1007 @ 153,420: 13x10\n#1008 @ 391,750: 18x19\n#1009 @ 690,565: 22x17\n#1010 @ 545,954: 20x12\n#1011 @ 498,855: 16x28\n#1012 @ 770,142: 12x22\n#1013 @ 646,596: 28x28\n#1014 @ 284,3: 6x10\n#1015 @ 30,743: 19x19\n#1016 @ 280,1: 20x23\n#1017 @ 476,683: 14x19\n#1018 @ 384,947: 29x11\n#1019 @ 65,109: 16x12\n#1020 @ 466,877: 16x28\n#1021 @ 141,717: 21x22\n#1022 @ 975,359: 23x10\n#1023 @ 328,894: 27x10\n#1024 @ 946,543: 12x14\n#1025 @ 420,17: 27x25\n#1026 @ 198,424: 19x18\n#1027 @ 674,201: 23x19\n#1028 @ 884,932: 10x24\n#1029 @ 497,491: 10x25\n#1030 @ 435,853: 25x13\n#1031 @ 890,125: 20x12\n#1032 @ 451,811: 16x21\n#1033 @ 846,219: 27x25\n#1034 @ 941,30: 14x21\n#1035 @ 891,504: 13x29\n#1036 @ 797,525: 11x25\n#1037 @ 237,8: 20x19\n#1038 @ 630,607: 25x19\n#1039 @ 196,671: 20x14\n#1040 @ 970,830: 26x12\n#1041 @ 158,656: 23x26\n#1042 @ 555,266: 15x24\n#1043 @ 19,782: 21x29\n#1044 @ 787,730: 13x10\n#1045 @ 482,106: 29x24\n#1046 @ 216,729: 24x19\n#1047 @ 738,797: 23x11\n#1048 @ 588,198: 21x26\n#1049 @ 164,185: 17x26\n#1050 @ 128,708: 20x17\n#1051 @ 132,145: 19x28\n#1052 @ 789,474: 12x11\n#1053 @ 715,671: 10x12\n#1054 @ 778,970: 3x9\n#1055 @ 472,530: 5x5\n#1056 @ 11,462: 24x25\n#1057 @ 974,353: 17x13\n#1058 @ 623,841: 22x25\n#1059 @ 228,632: 21x16\n#1060 @ 154,578: 15x14\n#1061 @ 217,568: 16x16\n#1062 @ 223,522: 14x14\n#1063 @ 705,903: 22x20\n#1064 @ 509,542: 19x13\n#1065 @ 24,966: 24x21\n#1066 @ 58,676: 16x27\n#1067 @ 668,880: 12x24\n#1068 @ 789,481: 24x24\n#1069 @ 71,937: 17x16\n#1070 @ 350,185: 13x29\n#1071 @ 839,179: 12x11\n#1072 @ 335,361: 4x9\n#1073 @ 781,511: 27x12\n#1074 @ 623,839: 27x24\n#1075 @ 587,361: 11x18\n#1076 @ 167,710: 5x14\n#1077 @ 92,620: 20x27\n#1078 @ 223,327: 14x26\n#1079 @ 452,271: 27x17\n#1080 @ 16,734: 14x23\n#1081 @ 586,165: 28x19\n#1082 @ 190,260: 27x24\n#1083 @ 321,709: 28x16\n#1084 @ 966,727: 14x28\n#1085 @ 410,739: 29x12\n#1086 @ 552,552: 17x10\n#1087 @ 128,327: 3x4\n#1088 @ 253,628: 15x29\n#1089 @ 406,833: 19x19\n#1090 @ 230,19: 14x19\n#1091 @ 740,94: 27x29\n#1092 @ 854,346: 10x27\n#1093 @ 431,280: 28x22\n#1094 @ 276,242: 10x29\n#1095 @ 177,232: 14x19\n#1096 @ 789,243: 15x12\n#1097 @ 636,554: 26x11\n#1098 @ 308,642: 12x23\n#1099 @ 146,497: 23x16\n#1100 @ 38,725: 5x4\n#1101 @ 533,715: 14x27\n#1102 @ 290,660: 27x16\n#1103 @ 516,636: 18x10\n#1104 @ 249,653: 12x17\n#1105 @ 661,203: 23x18\n#1106 @ 582,610: 16x18\n#1107 @ 4,687: 22x11\n#1108 @ 419,855: 28x23\n#1109 @ 970,537: 21x13\n#1110 @ 262,498: 12x29\n#1111 @ 271,815: 19x21\n#1112 @ 928,86: 13x28\n#1113 @ 193,956: 21x11\n#1114 @ 754,772: 11x25\n#1115 @ 161,257: 28x17\n#1116 @ 719,258: 19x11\n#1117 @ 932,623: 27x26\n#1118 @ 682,942: 28x26\n#1119 @ 179,788: 26x10\n#1120 @ 206,669: 15x19\n#1121 @ 665,353: 12x11\n#1122 @ 419,961: 18x18\n#1123 @ 975,350: 19x24\n#1124 @ 876,232: 10x19\n#1125 @ 560,728: 12x26\n#1126 @ 460,434: 14x22\n#1127 @ 221,752: 16x28\n#1128 @ 918,753: 27x22\n#1129 @ 822,661: 20x11\n#1130 @ 764,259: 16x18\n#1131 @ 931,97: 14x17\n#1132 @ 298,120: 23x14\n#1133 @ 285,469: 14x20\n#1134 @ 503,554: 28x15\n#1135 @ 330,802: 17x14\n#1136 @ 731,77: 20x10\n#1137 @ 366,128: 16x10\n#1138 @ 343,524: 16x26\n#1139 @ 820,212: 11x19\n#1140 @ 283,917: 16x27\n#1141 @ 610,971: 17x11\n#1142 @ 568,467: 14x16\n#1143 @ 195,964: 10x13\n#1144 @ 966,531: 12x25\n#1145 @ 453,623: 13x23\n#1146 @ 488,941: 17x15\n#1147 @ 376,949: 22x29\n#1148 @ 333,870: 22x18\n#1149 @ 400,808: 11x17\n#1150 @ 130,435: 28x16\n#1151 @ 348,971: 12x20\n#1152 @ 234,268: 26x29\n#1153 @ 684,213: 13x24\n#1154 @ 215,670: 21x25\n#1155 @ 285,335: 24x17\n#1156 @ 940,918: 21x19\n#1157 @ 923,687: 11x10\n#1158 @ 970,857: 13x21\n#1159 @ 478,929: 18x27\n#1160 @ 493,634: 20x29\n#1161 @ 97,503: 16x11\n#1162 @ 18,475: 27x16\n#1163 @ 324,871: 12x28\n#1164 @ 721,127: 18x15\n#1165 @ 600,164: 21x26\n#1166 @ 954,579: 21x10\n#1167 @ 170,694: 12x29\n#1168 @ 298,475: 29x25\n#1169 @ 555,264: 25x15\n#1170 @ 8,14: 26x14\n#1171 @ 155,870: 10x14\n#1172 @ 582,759: 18x10\n#1173 @ 377,869: 13x25\n#1174 @ 821,202: 10x14\n#1175 @ 617,550: 16x14\n#1176 @ 808,13: 17x17\n#1177 @ 530,717: 27x25\n#1178 @ 88,407: 24x15\n#1179 @ 914,465: 16x16\n#1180 @ 445,880: 26x29\n#1181 @ 271,654: 19x17\n#1182 @ 154,581: 10x11\n#1183 @ 545,282: 24x16\n#1184 @ 606,940: 11x17\n#1185 @ 22,583: 11x20\n#1186 @ 156,916: 19x25\n#1187 @ 343,382: 11x18\n#1188 @ 566,484: 18x12\n#1189 @ 160,747: 16x17\n#1190 @ 308,263: 28x21\n#1191 @ 310,854: 23x10\n#1192 @ 681,497: 13x16\n#1193 @ 716,480: 20x16\n#1194 @ 932,367: 23x21\n#1195 @ 171,739: 11x14\n#1196 @ 817,459: 11x10\n#1197 @ 110,289: 10x20\n#1198 @ 751,701: 19x29\n#1199 @ 112,552: 10x20\n#1200 @ 377,819: 12x21\n#1201 @ 461,34: 29x23\n#1202 @ 80,412: 14x19\n#1203 @ 572,123: 18x26\n#1204 @ 756,243: 21x21\n#1205 @ 262,659: 15x12\n#1206 @ 472,0: 18x17\n#1207 @ 726,373: 22x12\n#1208 @ 581,264: 10x24\n#1209 @ 253,652: 14x19\n#1210 @ 958,812: 17x11\n#1211 @ 899,388: 18x23\n#1212 @ 622,141: 14x14\n#1213 @ 195,632: 27x25\n#1214 @ 543,956: 27x23\n#1215 @ 579,607: 28x17\n#1216 @ 850,237: 29x18\n#1217 @ 552,665: 14x26\n#1218 @ 234,40: 15x22\n#1219 @ 716,678: 24x25\n#1220 @ 928,112: 23x11\n#1221 @ 21,406: 27x14\n#1222 @ 986,814: 11x25\n#1223 @ 8,667: 28x17\n#1224 @ 382,948: 27x19\n#1225 @ 692,99: 27x22\n#1226 @ 344,871: 29x25\n#1227 @ 215,253: 22x22\n#1228 @ 33,780: 11x20\n#1229 @ 248,884: 11x25\n#1230 @ 504,106: 26x26\n#1231 @ 240,264: 23x27\n#1232 @ 656,570: 11x10\n#1233 @ 195,410: 10x13\n#1234 @ 802,933: 10x15\n#1235 @ 835,224: 23x17\n#1236 @ 887,490: 28x23\n#1237 @ 960,947: 8x7\n#1238 @ 649,648: 22x18\n#1239 @ 173,584: 23x13\n#1240 @ 326,851: 25x10\n#1241 @ 878,304: 9x10\n#1242 @ 87,945: 22x14\n#1243 @ 718,871: 14x24\n#1244 @ 137,846: 23x15\n#1245 @ 588,177: 16x23\n#1246 @ 825,795: 20x27\n#1247 @ 249,209: 25x10\n#1248 @ 179,646: 22x13\n#1249 @ 956,535: 18x24\n#1250 @ 78,148: 14x28\n#1251 @ 519,202: 28x16\n#1252 @ 540,192: 28x17\n#1253 @ 240,131: 22x25\n#1254 @ 786,204: 19x16\n#1255 @ 748,705: 12x22\n#1256 @ 435,626: 19x29\n#1257 @ 386,848: 23x29\n#1258 @ 243,596: 10x27\n#1259 @ 721,489: 13x17\n#1260 @ 761,784: 10x29\n#1261 @ 736,10: 20x27\n#1262 @ 128,37: 11x25\n#1263 @ 92,102: 26x19\n#1264 @ 905,386: 12x26\n#1265 @ 357,120: 18x19\n#1266 @ 14,589: 22x19\n#1267 @ 704,920: 18x10\n#1268 @ 49,642: 10x26\n#1269 @ 306,634: 28x28\n#1270 @ 226,513: 22x16\n#1271 @ 451,467: 12x21\n#1272 @ 588,922: 24x29\n#1273 @ 130,445: 13x29\n#1274 @ 917,539: 14x23\n#1275 @ 839,125: 13x11\n#1276 @ 434,866: 23x21\n#1277 @ 215,290: 29x21\n#1278 @ 127,371: 16x27\n#1279 @ 718,933: 20x18\n#1280 @ 701,208: 26x13\n#1281 @ 432,443: 26x28\n#1282 @ 71,129: 10x15\n#1283 @ 665,661: 12x14\n#1284 @ 548,489: 19x23\n#1285 @ 36,718: 10x18\n#1286 @ 410,888: 10x22\n#1287 @ 146,440: 11x19\n#1288 @ 122,529: 14x23\n#1289 @ 753,130: 22x10\n#1290 @ 685,201: 11x28\n#1291 @ 103,403: 20x24\n#1292 @ 661,670: 25x10\n#1293 @ 675,789: 21x21\n#1294 @ 44,44: 17x10\n#1295 @ 497,58: 13x10\n#1296 @ 892,892: 21x10\n#1297 @ 788,461: 17x25\n#1298 @ 134,271: 22x19\n#1299 @ 228,583: 19x29\n#1300 @ 526,954: 29x27\n#1301 @ 176,276: 23x28';
var author$project$DayThreeInput$Dimensions = F2(
	function (width, height) {
		return {height: height, width: width};
	});
var author$project$DayThreeInput$Rectangle = F3(
	function (id, coordinate, dimensions) {
		return {coordinate: coordinate, dimensions: dimensions, id: id};
	});
var author$project$DynamicMatrix$Coordinate = F2(
	function (x, y) {
		return {x: x, y: y};
	});
var elm$core$Basics$always = F2(
	function (a, _n0) {
		return a;
	});
var elm$parser$Parser$Advanced$Bad = F2(
	function (a, b) {
		return {$: 'Bad', a: a, b: b};
	});
var elm$parser$Parser$Advanced$Good = F3(
	function (a, b, c) {
		return {$: 'Good', a: a, b: b, c: c};
	});
var elm$parser$Parser$Advanced$Parser = function (a) {
	return {$: 'Parser', a: a};
};
var elm$parser$Parser$Advanced$map2 = F3(
	function (func, _n0, _n1) {
		var parseA = _n0.a;
		var parseB = _n1.a;
		return elm$parser$Parser$Advanced$Parser(
			function (s0) {
				var _n2 = parseA(s0);
				if (_n2.$ === 'Bad') {
					var p = _n2.a;
					var x = _n2.b;
					return A2(elm$parser$Parser$Advanced$Bad, p, x);
				} else {
					var p1 = _n2.a;
					var a = _n2.b;
					var s1 = _n2.c;
					var _n3 = parseB(s1);
					if (_n3.$ === 'Bad') {
						var p2 = _n3.a;
						var x = _n3.b;
						return A2(elm$parser$Parser$Advanced$Bad, p1 || p2, x);
					} else {
						var p2 = _n3.a;
						var b = _n3.b;
						var s2 = _n3.c;
						return A3(
							elm$parser$Parser$Advanced$Good,
							p1 || p2,
							A2(func, a, b),
							s2);
					}
				}
			});
	});
var elm$parser$Parser$Advanced$ignorer = F2(
	function (keepParser, ignoreParser) {
		return A3(elm$parser$Parser$Advanced$map2, elm$core$Basics$always, keepParser, ignoreParser);
	});
var elm$parser$Parser$ignorer = elm$parser$Parser$Advanced$ignorer;
var elm$parser$Parser$ExpectingInt = {$: 'ExpectingInt'};
var elm$parser$Parser$Advanced$consumeBase = _Parser_consumeBase;
var elm$parser$Parser$Advanced$consumeBase16 = _Parser_consumeBase16;
var elm$core$String$slice = _String_slice;
var elm$core$String$toFloat = _String_toFloat;
var elm$parser$Parser$Advanced$bumpOffset = F2(
	function (newOffset, s) {
		return {col: s.col + (newOffset - s.offset), context: s.context, indent: s.indent, offset: newOffset, row: s.row, src: s.src};
	});
var elm$parser$Parser$Advanced$chompBase10 = _Parser_chompBase10;
var elm$parser$Parser$Advanced$isAsciiCode = _Parser_isAsciiCode;
var elm$parser$Parser$Advanced$consumeExp = F2(
	function (offset, src) {
		if (A3(elm$parser$Parser$Advanced$isAsciiCode, 101, offset, src) || A3(elm$parser$Parser$Advanced$isAsciiCode, 69, offset, src)) {
			var eOffset = offset + 1;
			var expOffset = (A3(elm$parser$Parser$Advanced$isAsciiCode, 43, eOffset, src) || A3(elm$parser$Parser$Advanced$isAsciiCode, 45, eOffset, src)) ? (eOffset + 1) : eOffset;
			var newOffset = A2(elm$parser$Parser$Advanced$chompBase10, expOffset, src);
			return _Utils_eq(expOffset, newOffset) ? (-newOffset) : newOffset;
		} else {
			return offset;
		}
	});
var elm$parser$Parser$Advanced$consumeDotAndExp = F2(
	function (offset, src) {
		return A3(elm$parser$Parser$Advanced$isAsciiCode, 46, offset, src) ? A2(
			elm$parser$Parser$Advanced$consumeExp,
			A2(elm$parser$Parser$Advanced$chompBase10, offset + 1, src),
			src) : A2(elm$parser$Parser$Advanced$consumeExp, offset, src);
	});
var elm$parser$Parser$Advanced$AddRight = F2(
	function (a, b) {
		return {$: 'AddRight', a: a, b: b};
	});
var elm$parser$Parser$Advanced$DeadEnd = F4(
	function (row, col, problem, contextStack) {
		return {col: col, contextStack: contextStack, problem: problem, row: row};
	});
var elm$parser$Parser$Advanced$Empty = {$: 'Empty'};
var elm$parser$Parser$Advanced$fromState = F2(
	function (s, x) {
		return A2(
			elm$parser$Parser$Advanced$AddRight,
			elm$parser$Parser$Advanced$Empty,
			A4(elm$parser$Parser$Advanced$DeadEnd, s.row, s.col, x, s.context));
	});
var elm$parser$Parser$Advanced$finalizeInt = F5(
	function (invalid, handler, startOffset, _n0, s) {
		var endOffset = _n0.a;
		var n = _n0.b;
		if (handler.$ === 'Err') {
			var x = handler.a;
			return A2(
				elm$parser$Parser$Advanced$Bad,
				true,
				A2(elm$parser$Parser$Advanced$fromState, s, x));
		} else {
			var toValue = handler.a;
			return _Utils_eq(startOffset, endOffset) ? A2(
				elm$parser$Parser$Advanced$Bad,
				_Utils_cmp(s.offset, startOffset) < 0,
				A2(elm$parser$Parser$Advanced$fromState, s, invalid)) : A3(
				elm$parser$Parser$Advanced$Good,
				true,
				toValue(n),
				A2(elm$parser$Parser$Advanced$bumpOffset, endOffset, s));
		}
	});
var elm$parser$Parser$Advanced$fromInfo = F4(
	function (row, col, x, context) {
		return A2(
			elm$parser$Parser$Advanced$AddRight,
			elm$parser$Parser$Advanced$Empty,
			A4(elm$parser$Parser$Advanced$DeadEnd, row, col, x, context));
	});
var elm$parser$Parser$Advanced$finalizeFloat = F6(
	function (invalid, expecting, intSettings, floatSettings, intPair, s) {
		var intOffset = intPair.a;
		var floatOffset = A2(elm$parser$Parser$Advanced$consumeDotAndExp, intOffset, s.src);
		if (floatOffset < 0) {
			return A2(
				elm$parser$Parser$Advanced$Bad,
				true,
				A4(elm$parser$Parser$Advanced$fromInfo, s.row, s.col - (floatOffset + s.offset), invalid, s.context));
		} else {
			if (_Utils_eq(s.offset, floatOffset)) {
				return A2(
					elm$parser$Parser$Advanced$Bad,
					false,
					A2(elm$parser$Parser$Advanced$fromState, s, expecting));
			} else {
				if (_Utils_eq(intOffset, floatOffset)) {
					return A5(elm$parser$Parser$Advanced$finalizeInt, invalid, intSettings, s.offset, intPair, s);
				} else {
					if (floatSettings.$ === 'Err') {
						var x = floatSettings.a;
						return A2(
							elm$parser$Parser$Advanced$Bad,
							true,
							A2(elm$parser$Parser$Advanced$fromState, s, invalid));
					} else {
						var toValue = floatSettings.a;
						var _n1 = elm$core$String$toFloat(
							A3(elm$core$String$slice, s.offset, floatOffset, s.src));
						if (_n1.$ === 'Nothing') {
							return A2(
								elm$parser$Parser$Advanced$Bad,
								true,
								A2(elm$parser$Parser$Advanced$fromState, s, invalid));
						} else {
							var n = _n1.a;
							return A3(
								elm$parser$Parser$Advanced$Good,
								true,
								toValue(n),
								A2(elm$parser$Parser$Advanced$bumpOffset, floatOffset, s));
						}
					}
				}
			}
		}
	});
var elm$parser$Parser$Advanced$number = function (c) {
	return elm$parser$Parser$Advanced$Parser(
		function (s) {
			if (A3(elm$parser$Parser$Advanced$isAsciiCode, 48, s.offset, s.src)) {
				var zeroOffset = s.offset + 1;
				var baseOffset = zeroOffset + 1;
				return A3(elm$parser$Parser$Advanced$isAsciiCode, 120, zeroOffset, s.src) ? A5(
					elm$parser$Parser$Advanced$finalizeInt,
					c.invalid,
					c.hex,
					baseOffset,
					A2(elm$parser$Parser$Advanced$consumeBase16, baseOffset, s.src),
					s) : (A3(elm$parser$Parser$Advanced$isAsciiCode, 111, zeroOffset, s.src) ? A5(
					elm$parser$Parser$Advanced$finalizeInt,
					c.invalid,
					c.octal,
					baseOffset,
					A3(elm$parser$Parser$Advanced$consumeBase, 8, baseOffset, s.src),
					s) : (A3(elm$parser$Parser$Advanced$isAsciiCode, 98, zeroOffset, s.src) ? A5(
					elm$parser$Parser$Advanced$finalizeInt,
					c.invalid,
					c.binary,
					baseOffset,
					A3(elm$parser$Parser$Advanced$consumeBase, 2, baseOffset, s.src),
					s) : A6(
					elm$parser$Parser$Advanced$finalizeFloat,
					c.invalid,
					c.expecting,
					c._int,
					c._float,
					_Utils_Tuple2(zeroOffset, 0),
					s)));
			} else {
				return A6(
					elm$parser$Parser$Advanced$finalizeFloat,
					c.invalid,
					c.expecting,
					c._int,
					c._float,
					A3(elm$parser$Parser$Advanced$consumeBase, 10, s.offset, s.src),
					s);
			}
		});
};
var elm$parser$Parser$Advanced$int = F2(
	function (expecting, invalid) {
		return elm$parser$Parser$Advanced$number(
			{
				binary: elm$core$Result$Err(invalid),
				expecting: expecting,
				_float: elm$core$Result$Err(invalid),
				hex: elm$core$Result$Err(invalid),
				_int: elm$core$Result$Ok(elm$core$Basics$identity),
				invalid: invalid,
				octal: elm$core$Result$Err(invalid)
			});
	});
var elm$parser$Parser$int = A2(elm$parser$Parser$Advanced$int, elm$parser$Parser$ExpectingInt, elm$parser$Parser$ExpectingInt);
var elm$parser$Parser$Advanced$keeper = F2(
	function (parseFunc, parseArg) {
		return A3(elm$parser$Parser$Advanced$map2, elm$core$Basics$apL, parseFunc, parseArg);
	});
var elm$parser$Parser$keeper = elm$parser$Parser$Advanced$keeper;
var elm$parser$Parser$Advanced$isSubChar = _Parser_isSubChar;
var elm$parser$Parser$Advanced$chompWhileHelp = F5(
	function (isGood, offset, row, col, s0) {
		chompWhileHelp:
		while (true) {
			var newOffset = A3(elm$parser$Parser$Advanced$isSubChar, isGood, offset, s0.src);
			if (_Utils_eq(newOffset, -1)) {
				return A3(
					elm$parser$Parser$Advanced$Good,
					_Utils_cmp(s0.offset, offset) < 0,
					_Utils_Tuple0,
					{col: col, context: s0.context, indent: s0.indent, offset: offset, row: row, src: s0.src});
			} else {
				if (_Utils_eq(newOffset, -2)) {
					var $temp$isGood = isGood,
						$temp$offset = offset + 1,
						$temp$row = row + 1,
						$temp$col = 1,
						$temp$s0 = s0;
					isGood = $temp$isGood;
					offset = $temp$offset;
					row = $temp$row;
					col = $temp$col;
					s0 = $temp$s0;
					continue chompWhileHelp;
				} else {
					var $temp$isGood = isGood,
						$temp$offset = newOffset,
						$temp$row = row,
						$temp$col = col + 1,
						$temp$s0 = s0;
					isGood = $temp$isGood;
					offset = $temp$offset;
					row = $temp$row;
					col = $temp$col;
					s0 = $temp$s0;
					continue chompWhileHelp;
				}
			}
		}
	});
var elm$parser$Parser$Advanced$chompWhile = function (isGood) {
	return elm$parser$Parser$Advanced$Parser(
		function (s) {
			return A5(elm$parser$Parser$Advanced$chompWhileHelp, isGood, s.offset, s.row, s.col, s);
		});
};
var elm$parser$Parser$Advanced$spaces = elm$parser$Parser$Advanced$chompWhile(
	function (c) {
		return _Utils_eq(
			c,
			_Utils_chr(' ')) || (_Utils_eq(
			c,
			_Utils_chr('\n')) || _Utils_eq(
			c,
			_Utils_chr('\r')));
	});
var elm$parser$Parser$spaces = elm$parser$Parser$Advanced$spaces;
var elm$parser$Parser$Advanced$succeed = function (a) {
	return elm$parser$Parser$Advanced$Parser(
		function (s) {
			return A3(elm$parser$Parser$Advanced$Good, false, a, s);
		});
};
var elm$parser$Parser$succeed = elm$parser$Parser$Advanced$succeed;
var elm$parser$Parser$ExpectingSymbol = function (a) {
	return {$: 'ExpectingSymbol', a: a};
};
var elm$parser$Parser$Advanced$Token = F2(
	function (a, b) {
		return {$: 'Token', a: a, b: b};
	});
var elm$core$Basics$not = _Basics_not;
var elm$core$String$isEmpty = function (string) {
	return string === '';
};
var elm$parser$Parser$Advanced$isSubString = _Parser_isSubString;
var elm$parser$Parser$Advanced$token = function (_n0) {
	var str = _n0.a;
	var expecting = _n0.b;
	var progress = !elm$core$String$isEmpty(str);
	return elm$parser$Parser$Advanced$Parser(
		function (s) {
			var _n1 = A5(elm$parser$Parser$Advanced$isSubString, str, s.offset, s.row, s.col, s.src);
			var newOffset = _n1.a;
			var newRow = _n1.b;
			var newCol = _n1.c;
			return _Utils_eq(newOffset, -1) ? A2(
				elm$parser$Parser$Advanced$Bad,
				false,
				A2(elm$parser$Parser$Advanced$fromState, s, expecting)) : A3(
				elm$parser$Parser$Advanced$Good,
				progress,
				_Utils_Tuple0,
				{col: newCol, context: s.context, indent: s.indent, offset: newOffset, row: newRow, src: s.src});
		});
};
var elm$parser$Parser$Advanced$symbol = elm$parser$Parser$Advanced$token;
var elm$parser$Parser$symbol = function (str) {
	return elm$parser$Parser$Advanced$symbol(
		A2(
			elm$parser$Parser$Advanced$Token,
			str,
			elm$parser$Parser$ExpectingSymbol(str)));
};
var author$project$DayThreeInput$rectangleParser = A2(
	elm$parser$Parser$keeper,
	A2(
		elm$parser$Parser$keeper,
		A2(
			elm$parser$Parser$keeper,
			A2(
				elm$parser$Parser$ignorer,
				elm$parser$Parser$succeed(author$project$DayThreeInput$Rectangle),
				elm$parser$Parser$symbol('#')),
			A2(
				elm$parser$Parser$ignorer,
				A2(
					elm$parser$Parser$ignorer,
					A2(elm$parser$Parser$ignorer, elm$parser$Parser$int, elm$parser$Parser$spaces),
					elm$parser$Parser$symbol('@')),
				elm$parser$Parser$spaces)),
		A2(
			elm$parser$Parser$ignorer,
			A2(
				elm$parser$Parser$ignorer,
				A2(
					elm$parser$Parser$keeper,
					A2(
						elm$parser$Parser$keeper,
						elm$parser$Parser$succeed(author$project$DynamicMatrix$Coordinate),
						A2(
							elm$parser$Parser$ignorer,
							elm$parser$Parser$int,
							elm$parser$Parser$symbol(','))),
					elm$parser$Parser$int),
				elm$parser$Parser$symbol(':')),
			elm$parser$Parser$spaces)),
	A2(
		elm$parser$Parser$keeper,
		A2(
			elm$parser$Parser$keeper,
			elm$parser$Parser$succeed(author$project$DayThreeInput$Dimensions),
			A2(
				elm$parser$Parser$ignorer,
				elm$parser$Parser$int,
				elm$parser$Parser$symbol('x'))),
		elm$parser$Parser$int));
var elm$core$List$map = F2(
	function (f, xs) {
		return A3(
			elm$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						elm$core$List$cons,
						f(x),
						acc);
				}),
			_List_Nil,
			xs);
	});
var elm$core$Result$toMaybe = function (result) {
	if (result.$ === 'Ok') {
		var v = result.a;
		return elm$core$Maybe$Just(v);
	} else {
		return elm$core$Maybe$Nothing;
	}
};
var elm$parser$Parser$DeadEnd = F3(
	function (row, col, problem) {
		return {col: col, problem: problem, row: row};
	});
var elm$parser$Parser$problemToDeadEnd = function (p) {
	return A3(elm$parser$Parser$DeadEnd, p.row, p.col, p.problem);
};
var elm$parser$Parser$Advanced$bagToList = F2(
	function (bag, list) {
		bagToList:
		while (true) {
			switch (bag.$) {
				case 'Empty':
					return list;
				case 'AddRight':
					var bag1 = bag.a;
					var x = bag.b;
					var $temp$bag = bag1,
						$temp$list = A2(elm$core$List$cons, x, list);
					bag = $temp$bag;
					list = $temp$list;
					continue bagToList;
				default:
					var bag1 = bag.a;
					var bag2 = bag.b;
					var $temp$bag = bag1,
						$temp$list = A2(elm$parser$Parser$Advanced$bagToList, bag2, list);
					bag = $temp$bag;
					list = $temp$list;
					continue bagToList;
			}
		}
	});
var elm$parser$Parser$Advanced$run = F2(
	function (_n0, src) {
		var parse = _n0.a;
		var _n1 = parse(
			{col: 1, context: _List_Nil, indent: 1, offset: 0, row: 1, src: src});
		if (_n1.$ === 'Good') {
			var value = _n1.b;
			return elm$core$Result$Ok(value);
		} else {
			var bag = _n1.b;
			return elm$core$Result$Err(
				A2(elm$parser$Parser$Advanced$bagToList, bag, _List_Nil));
		}
	});
var elm$parser$Parser$run = F2(
	function (parser, source) {
		var _n0 = A2(elm$parser$Parser$Advanced$run, parser, source);
		if (_n0.$ === 'Ok') {
			var a = _n0.a;
			return elm$core$Result$Ok(a);
		} else {
			var problems = _n0.a;
			return elm$core$Result$Err(
				A2(elm$core$List$map, elm$parser$Parser$problemToDeadEnd, problems));
		}
	});
var author$project$DayThreeInput$input = A2(
	elm$core$List$filterMap,
	elm$core$Result$toMaybe,
	A2(
		elm$core$List$map,
		elm$parser$Parser$run(author$project$DayThreeInput$rectangleParser),
		A2(elm$core$String$split, '\n', author$project$DayThreeInput$rawInput)));
var author$project$DynamicMatrix$empty = function (defaultVal) {
	return {
		data: elm$core$Array$fromList(
			A2(elm$core$List$repeat, 16, defaultVal)),
		_default: defaultVal,
		size: 4
	};
};
var author$project$DayThree$matrixSolution = A2(
	author$project$DayThree$addRectangles,
	author$project$DayThreeInput$input,
	author$project$DynamicMatrix$empty(0));
var author$project$DayThree$partOne = elm$core$String$fromInt(
	A3(
		author$project$DayThree$countWhere,
		0,
		function (a) {
			return a > 1;
		},
		elm$core$Array$toList(author$project$DayThree$matrixSolution.data)));
var author$project$DayThree$rectangleIsUnique = F2(
	function (rectangle, matrix) {
		var coordinates = author$project$DayThree$toCoordinateList(rectangle);
		return 1 === A3(
			elm$core$List$foldl,
			elm$core$Basics$mul,
			1,
			A2(
				elm$core$List$map,
				function (a) {
					return A2(
						elm$core$Maybe$withDefault,
						2,
						A2(author$project$DynamicMatrix$get, a, matrix));
				},
				coordinates));
	});
var author$project$DayThree$findUniqueRectangle = F2(
	function (rectangleList, matrix) {
		findUniqueRectangle:
		while (true) {
			if (rectangleList.b) {
				var head = rectangleList.a;
				var tail = rectangleList.b;
				if (A2(author$project$DayThree$rectangleIsUnique, head, matrix)) {
					return head.id;
				} else {
					var $temp$rectangleList = tail,
						$temp$matrix = matrix;
					rectangleList = $temp$rectangleList;
					matrix = $temp$matrix;
					continue findUniqueRectangle;
				}
			} else {
				return -1;
			}
		}
	});
var author$project$DayThree$partTwo = elm$core$String$fromInt(
	A2(author$project$DayThree$findUniqueRectangle, author$project$DayThreeInput$input, author$project$DayThree$matrixSolution));
var author$project$DayTwo$letterCountsIterator = F2(
	function (chars, dictionary) {
		letterCountsIterator:
		while (true) {
			if (!chars.b) {
				return dictionary;
			} else {
				var _char = chars.a;
				var remainder = chars.b;
				var $temp$chars = remainder,
					$temp$dictionary = A3(
					elm$core$Dict$insert,
					_char,
					A2(
						elm$core$Maybe$withDefault,
						0,
						A2(elm$core$Dict$get, _char, dictionary)) + 1,
					dictionary);
				chars = $temp$chars;
				dictionary = $temp$dictionary;
				continue letterCountsIterator;
			}
		}
	});
var elm$core$String$foldr = _String_foldr;
var elm$core$String$toList = function (string) {
	return A3(elm$core$String$foldr, elm$core$List$cons, _List_Nil, string);
};
var author$project$DayTwo$letterCounts = function (string) {
	return A2(
		author$project$DayTwo$letterCountsIterator,
		elm$core$String$toList(string),
		elm$core$Dict$empty);
};
var elm$core$Dict$values = function (dict) {
	return A3(
		elm$core$Dict$foldr,
		F3(
			function (key, value, valueList) {
				return A2(elm$core$List$cons, value, valueList);
			}),
		_List_Nil,
		dict);
};
var elm$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			if (!list.b) {
				return false;
			} else {
				var x = list.a;
				var xs = list.b;
				if (isOkay(x)) {
					return true;
				} else {
					var $temp$isOkay = isOkay,
						$temp$list = xs;
					isOkay = $temp$isOkay;
					list = $temp$list;
					continue any;
				}
			}
		}
	});
var elm$core$List$member = F2(
	function (x, xs) {
		return A2(
			elm$core$List$any,
			function (a) {
				return _Utils_eq(a, x);
			},
			xs);
	});
var author$project$DayTwo$hasNOfAKind = F2(
	function (n, string) {
		return A2(
			elm$core$List$member,
			n,
			elm$core$Dict$values(
				author$project$DayTwo$letterCounts(string)));
	});
var author$project$DayTwo$checksumTuple = function (string) {
	return _Utils_Tuple2(
		A2(author$project$DayTwo$hasNOfAKind, 2, string) ? 1 : 0,
		A2(author$project$DayTwo$hasNOfAKind, 3, string) ? 1 : 0);
};
var author$project$DayTwo$sum = A2(
	elm$core$List$foldl,
	F2(
		function (a, b) {
			return a + b;
		}),
	0);
var author$project$DayTwoInput$rawInput = 'kqzxdenujwcsthbzgvyioflcsp\nvqwxdenujwcsthbmggyioflarp\nkqzxienujwcsthbmglyioclarp\nkuzxdetujwcsthbmgvyioflcrp\nkqnxdenujwcsthbmgvlooflarp\nkqzxdknpjwcsthwmgvyioflarp\nkgzxdenujwcsthbfgvyicflarp\nkqzxdenujrnsthbmgjyioflarp\nlqzxdeeujwcsthbmrvyioflarp\niqfxdenujwcsthbmgvyiofyarp\nkvzxbenujwcstabmgvyioflarp\nkmzxdenujwcsthbmglyioolarp\nkqzxdenujhcsthbmgbyioflanp\nnqzxdenujwcsehbmgvsioflarp\nkqzlgenujwcsthbmgvyiofjarp\nkqzxdyfujwcsihbmgvyioflarp\nkqzxdsnujwcqthbmgvyiorlarp\nkqzxdenuywcsthbmgvyinflmrp\nknzxderujwcsthbmgvyioflaop\nkqxxdenujwczthbmgvyioflajp\nkqzxdevujwcsthbmgvyqoxlarp\nkqzxdenujwclmhbmgvyioslarp\nkqzldenujwcsthbmgvnisflarp\nkjtxdenujwcsthbmgvyfoflarp\nkqzxwenujwcstxbmgvyihflarp\nkqzxdenuhecsthbmgvyeoflarp\nkqzxdenhjwesthbmgvyioklarp\nkqkxdenujwcsthbcgvyiofgarp\nkqyxmenujwcsthbmgvyioflara\nkqzxdqnrjwcwthbmgvyioflarp\nkqzxdenufwcgyhbmgvyioflarp\nlqzxdenujwcsthbmtvyiofearp\nkqzxdenujwcsthbvgvthoflarp\nkqzxeenujwcsahbmgvyioflamp\npqzxdenujwcsshbmjvyioflarp\nkqzxdesujwcstdbmgvyioflatp\nkqzxpenujwcsthimgvyioflhrp\nkqzxdmkujwcsthbmgvpioflarp\nkszxdenujwcsthbybvyioflarp\nkqzxdvnujwcsthbmgvyqoslarp\nkkzxdetujwcsthbmgvyiofltrp\nkqzxdenujwcsthomgvyiozlaro\ncqzfdenubwcsthbmgvyioflarp\nkqzxdenyjwcsthbmhvyiofldrp\nkqzxdenujwcsthbmghfiofxarp\nkmqxdebujwcsthbmgvyioflarp\nkqzxdenufwcsthbmvvypoflarp\nkqnxdenujwcsthbmgvtzoflarp\nbqzxdenujwcithbmgvyiohlarp\nkqzxdenurwrsthbmgvyioelarp\nkqzxdenujwcsthbmgpyiodlarl\nkqzxdengjwcxthbmgvjioflarp\nkizxdenujwcsnhqmgvyioflarp\njqzxdenajwcsthbmnvyioflarp\nkqzcdenujwcsphbigvyioflarp\nkezxdenujwcsthbfgvyioflaqp\nkqzxdenujwcstybmgvyivfyarp\nkqzxdenujwcsthbmgvbiofsnrp\nkqzxdenujwcsthbmgvyhxfnarp\nkvzxdenqjfcsthbmgvyioflarp\nkqzxywnljwcsthbmgvyioflarp\nkqzxdenujwcsbhbzgvyioxlarp\nkqkxdenufwcsthbmgvyiofxarp\ndqzxddnujwcsthsmgvyioflarp\nyqrxdenujwcsthbagvyioflarp\nkqzxdenujwcsajbmgvyiovlarp\nkqztdunujwcsthbmgvyioilarp\nkqzxdequjwcsthbmgvyyoflarm\nkqzxdlnujwksthbmgvkioflarp\ntqvxdenujwcsthbmgveioflarp\nkqzndezupwcsthbmgvyioflarp\nkqzctsnujwcsthbmgvyioflarp\nkqzxdenujwmstkbmgvyioflgrp\nkqzxdenujwzsthdmgvyiofdarp\nkqzxdynujwcsthcmgvyioflasp\nkqzxdesujwcstybmgcyioflarp\nkqzxdenujwcsthbvgvyiyglarp\nkqzxpenujwcsthbogvyioflard\nkhzxdenujwcsthbmgvyikflaep\nkqzxdedujwchthbmgvyeoflarp\nkxzxsepujwcsthbmgvyioflarp\nxqzxdenujwcsthbpgvyioelarp\njfzxdenujwcsthbmgvyiollarp\nkqzxcenujwcethbmgvwioflarp\nkqzxdenujwcithbmgvysoflarg\nkqlxdenujwnsthbmgvyiotlarp\nwqzydenujwcsthbmgvyioftarp\nkqzxienuwwcsthbmgayioflarp\nkqzxdetujwcsthbmgvyhoflawp\nkqzxdqnujwrsthbmgvyxoflarp\nkqzxdenujwcvthbmgjiioflarp\nkqzxdenujwcjthbxgvaioflarp\nkqzxpenujwcsthymgvyioklarp\nkqzxdenujwcsthbmswygoflarp\nkqzxdenujwcsthbmgvyiaxiarp\nkqzxdenudkcsthbmgvyzoflarp\nkqzxdvndjwcsthbmgvyioflaxp\nkqzxdenujwcsthbmdvymoflvrp\nkqzxvenujwcsihbmgvyiofllrp\nkqzxdqnujwcsthbmgtyioflprp\nkqzxdenuuwcathbmgvsioflarp\nkqzrdenujwesthbjgvyioflarp\nkqzxdexujwcstzbmgvyyoflarp\nkqzxpenujwjstabmgvyioflarp\nkozxdenejwcsthbmgvpioflarp\nkbzxdenvjwcsthbmgvyiofsarp\nkolxdenujwcjthbmgvyioflarp\nkqzxdenujwcsthbmgvyiffsakp\nkqzxdelujwcsthbmlvyioflxrp\nkqzxdenugwcsthrmgvyioflprp\nkqzxdelujwcsthqmgvyiozlarp\nkqzxienujwosthbmgvykoflarp\nkqzxdeuujwicthbmgvyioflarp\nkqzxdenbjwcsthbmcvyaoflarp\nkrzxdqnujwcsthbmgvyioflerp\nwqzxzenujwcsthbmgvyioclarp\nkqzxyenujwcsthbmgejioflarp\nkqzxdenujwcstsbmgvtidflarp\nkqnxdenejwcsthbmgvyioflara\nkqzsdmnujwcsthbmgvyioflaep\nkqzxdedujwnsthymgvyioflarp\nkqzxdenujwusthbmgnyioflarx\nkqzxlenujwcsthbmgayvoflarp\nkqzxdenujwcsthbmgvyiofngrh\nzqzxdenujwcsthbmgvyiofvxrp\nkqzydenujwmsthbmgvyiuflarp\nkqzxdenujkrsthbmdvyioflarp\nkqzxdlnujocsthbmgvyiofaarp\nkqzxdenujwcstybmgvyiofrwrd\nkqzxdenupwksthbmgvyiofbarp\nkhzxdentjwcsthbmbvyioflarp\nkqzxdenujwcuphbmgvyihflarp\nkqzxdenhjwcgthbmgvyioflrrp\nkqzxdenujwcsthbmgvyiofakhp\nkqzxdenujwcstfkmgvyioflamp\nkqzxdenujqcsthbmgvkiorlarp\nkqzxdenujwcstvbmgvyioilasp\nkqzxdxnujwcsthbpgayioflarp\nkqzxdenupwysthbmgvyiofljrp\nkqzxdenujwcdthbmgvymoflarv\nkqnxdenujwcstvbmgvyixflarp\nkqjxdenujwcsthbmgvyikflurp\nkqsxdenulwcsthxmgvyioflarp\nbqzxbenujwcsahbmgvyioflarp\nvqzxdenujwcsthbmgvjzoflarp\nkqzhfenujwcsthimgvyioflarp\neqzxdenujwcshhbmgnyioflarp\nkqzxdenujucstubmgvyicflarp\nkuzxdenuewcsthbmgvyiofuarp\nkqzxdenulwcsthbmgpyigflarp\nkqzxdebujwcsthbmgoyioflaro\nkqzxdenujwcuthbmgucioflarp\nkqzxdenujwcschpmgvyioflhrp\nkqzxfenujwcsthbmjvrioflarp\nkqzxdenujqcsthbmgvyndflarp\nkqzxdgnbjwcsthbmgvywoflarp\nkqzxdenujwcsthrmgtbioflarp\nyqzxdenyjwcsthbmgvyioflarg\nkqzxdenuxwxsthbmsvyioflarp\nkqzxdenujwcsthbugqyvoflarp\nqqzxdenujwcsahbmgoyioflarp\nkqsxdenudwcsthbmguyioflarp\nkqzxdenujwcstublgvyioflamp\nkqzxdemujwtstqbmgvyioflarp\nkqzxqvnajwcsthbmgvyioflarp\nkqzxoennjwcstbbmgvyioflarp\nkqzxfenujwcsthbmlvyioflwrp\nkqzjdunujwcsthhmgvyioflarp\nkqzxdenujwcqthbmgvyirfxarp\nkqzxdengjwcsthbmgvyiowlgrp\nkqgxdenujwcswhbmglyioflarp\nmqzxdekuuwcsthbmgvyioflarp\nkqzxdenujwdsthbmgbyiovlarp\nkrzxdenlhwcsthbmgvyioflarp\nkqzxdenmjwcstqbmgvyioflanp\nkqzxdenujwcmthbmgvtioflyrp\nkqzxdenujwcsthbmgvaijflprp\nkqzxdenuywysqhbmgvyioflarp\nkqzxdenujwfsthbmgvyhoflark\nnqzcdefujwcsthbmgvyioflarp\nkqzxdenujrcsthgmgyyioflarp\nkqzxdqnujwzsthbmgvyioftarp\nkqzxdenujwcsthimgvyioolapp\nkqzxdenupwcsthbmggyioflyrp\nkqzxdjnujwcsthbvgvyioflarf\nkqzxdtnujwasthbmgvyiofuarp\nkqzxbensjzcsthbmgvyioflarp\nkqzxdenujwcsphbmwiyioflarp\nkqzgdenuowcsthbmgvyioflarh\nkmzxdenujwasthbmgvtioflarp\nkqzxdenujwcstybmgvyiofrard\nvqzxdenejwcsthbmglyioflarp\nkqhxdenujwcsmhbmgvyioflprp\nkqzxdnnujwcsthzsgvyioflarp\nkczxdenujwcsthbmgvyeoflaop\nkqzxdenujwcsxhbmgvaioflaap\nkqzxdenujwcsthbmgayiofnprp\nkqzxdvnujwcsthbmgvyipjlarp\nkqzxdenubwcskhbmgvyiofkarp\nkqzxdenujwcsthbgggyigflarp\nkqzxdenujncstabvgvyioflarp\nkqzxdenujwcstqimqvyioflarp\nkqzxeenujwcsdhbmgvyqoflarp\nkcpxdenujwcsthbmgvyioilarp\nkqwxuenujwcsthbmgvyiyflarp\nkqzxdwnujwcstgbmgvyioplarp\nkqzxdenuswcstvbmglyioflarp\nkqzxdenujwcsthabgvyiwflarp\nkqzxdpnujwcsthbmwvyiomlarp\nkqzxdenujwcdthbmgvcioffarp\nkqzxdenajwcsthbmtvyiofldrp\nkqzbnenujwcshhbmgvyioflarp\nkqzbdequiwcsthbmgvyioflarp\nkqzxdenuswcsohbmgzyioflarp\nkvzxdenujwcstdbmjvyioflarp\nkqzxoenujwcqthbmpvyioflarp\nkqzxhenujwcsthbmgoyiofoarp\nklzxdenujwczthbmgvyioflanp\nkqpxdenujwcsthbmgvyioflafz\nkqkxdenujwcstxbngvyioflarp\nkqzepenuxwcsthbmgvyioflarp\nbqzxdenujmcithbmgvyioflarp\nkdzxdjnujwcstnbmgvyioflarp\nkszxdenujwcsthbmgeyiofrarp\nkqzxdenijwcsthbmgvhiaflarp\nkqzadenujwcbtxbmgvyioflarp\nkqkxwenujwcsthbmgvyiowlarp\npqzddenujwcsthbmgvyboflarp\nkqzxxenujwcsthbwgvyioflmrp\nkqzxdjnujwcsthbmgvyipilarp\npqzxdenujwcsthbmgvyieflark\nsqzxdenujtcsthbmgiyioflarp\nkqzxdznujwcsthbmgvzioflajp\nkqzxdrnujqcsthbmgvyiofvarp\ngqzxdenujwcsthemgvlioflarp\nkqzxdenujjcsthbmgvuiofljrp\nkqzsdenujmcsthbmggyioflarp\nkqzxienujwcsthbmgvaioflaip\nkqzxdwnujwcstfkmgvyioflarp\nkqzqdenujwcithbmzvyioflarp\nkqzxdedpjwcsthbmgvyiofbarp\nkqzxdeaujwcbtdbmgvyioflarp\nkqzewenyjwcsthbmgvyioflarp\nkqzxddnujwcsthbmgyyiofrarp\nkqzxdtnujwcsthbmgvyiodlard\nkqzxdefujwcsthbmgvyiffwarp\nxczxdenujwcsthbmgvyooflarp\nkuzxdenujucsthbmgvykoflarp\nkqzxtenujwcwthbmgvyioplarp\nkqzxdencllcsthbmgvyioflarp';
var author$project$DayTwoInput$input = A2(elm$core$String$split, '\n', author$project$DayTwoInput$rawInput);
var elm$core$List$unzip = function (pairs) {
	var step = F2(
		function (_n0, _n1) {
			var x = _n0.a;
			var y = _n0.b;
			var xs = _n1.a;
			var ys = _n1.b;
			return _Utils_Tuple2(
				A2(elm$core$List$cons, x, xs),
				A2(elm$core$List$cons, y, ys));
		});
	return A3(
		elm$core$List$foldr,
		step,
		_Utils_Tuple2(_List_Nil, _List_Nil),
		pairs);
};
var elm$core$Tuple$second = function (_n0) {
	var y = _n0.b;
	return y;
};
var author$project$DayTwo$partOne = function () {
	var checksumParts = elm$core$List$unzip(
		A2(elm$core$List$map, author$project$DayTwo$checksumTuple, author$project$DayTwoInput$input));
	var threes = author$project$DayTwo$sum(checksumParts.b);
	var twos = author$project$DayTwo$sum(checksumParts.a);
	return elm$core$String$fromInt(twos * threes);
}();
var author$project$DayTwo$findSomething = function (aList) {
	return A3(
		elm$core$List$foldl,
		F2(
			function (a, b) {
				return _Utils_eq(a, elm$core$Maybe$Nothing) ? b : a;
			}),
		elm$core$Maybe$Nothing,
		aList);
};
var author$project$DayTwo$head = function (string) {
	return A2(
		elm$core$Maybe$withDefault,
		_Utils_Tuple2(
			_Utils_chr(' '),
			''),
		elm$core$String$uncons(string)).a;
};
var author$project$DayTwo$tail = function (string) {
	return A2(
		elm$core$Maybe$withDefault,
		_Utils_Tuple2(
			_Utils_chr(' '),
			''),
		elm$core$String$uncons(string)).b;
};
var elm$core$String$cons = _String_cons;
var elm$core$String$length = _String_length;
var author$project$DayTwo$matchingSubstring = F2(
	function (stringA, stringB) {
		matchingSubstring:
		while (true) {
			if (!elm$core$String$length(stringA)) {
				return '';
			} else {
				if (_Utils_eq(
					author$project$DayTwo$head(stringA),
					author$project$DayTwo$head(stringB))) {
					return A2(
						elm$core$String$cons,
						author$project$DayTwo$head(stringA),
						A2(
							author$project$DayTwo$matchingSubstring,
							author$project$DayTwo$tail(stringA),
							author$project$DayTwo$tail(stringB)));
				} else {
					var $temp$stringA = author$project$DayTwo$tail(stringA),
						$temp$stringB = author$project$DayTwo$tail(stringB);
					stringA = $temp$stringA;
					stringB = $temp$stringB;
					continue matchingSubstring;
				}
			}
		}
	});
var author$project$DayTwo$withinOne = F2(
	function (stringA, stringB) {
		var stringMatch = A2(author$project$DayTwo$matchingSubstring, stringA, stringB);
		return ((elm$core$String$length(stringA) - elm$core$String$length(stringMatch)) <= 1) ? elm$core$Maybe$Just(stringMatch) : elm$core$Maybe$Nothing;
	});
var author$project$DayTwo$anyWithinOne = F2(
	function (idPattern, idList) {
		return author$project$DayTwo$findSomething(
			A2(
				elm$core$List$map,
				author$project$DayTwo$withinOne(idPattern),
				idList));
	});
var author$project$DayTwo$idMatchFinder = function (ids) {
	idMatchFinder:
	while (true) {
		if (!ids.b) {
			return '';
		} else {
			var next = ids.a;
			var rest = ids.b;
			var _n1 = A2(author$project$DayTwo$anyWithinOne, next, rest);
			if (_n1.$ === 'Just') {
				var string = _n1.a;
				return string;
			} else {
				var $temp$ids = rest;
				ids = $temp$ids;
				continue idMatchFinder;
			}
		}
	}
};
var author$project$DayTwo$partTwo = author$project$DayTwo$idMatchFinder(author$project$DayTwoInput$input);
var author$project$Answers$main = A2(
	elm$html$Html$div,
	_List_fromArray(
		[
			A2(elm$html$Html$Attributes$style, 'font-family', 'Helvetica'),
			A2(elm$html$Html$Attributes$style, 'flex-wrap', 'wrap'),
			A2(elm$html$Html$Attributes$style, 'display', 'flex')
		]),
	_List_fromArray(
		[
			A3(
			author$project$Answers$dayDiv,
			'December One',
			elm$core$Maybe$Just(author$project$DayOne$partOne),
			elm$core$Maybe$Just(author$project$DayOne$partTwo)),
			A3(
			author$project$Answers$dayDiv,
			'December Two',
			elm$core$Maybe$Just(author$project$DayTwo$partOne),
			elm$core$Maybe$Just(author$project$DayTwo$partTwo)),
			A3(
			author$project$Answers$dayDiv,
			'December Three',
			elm$core$Maybe$Just(author$project$DayThree$partOne),
			elm$core$Maybe$Just(author$project$DayThree$partTwo)),
			A3(author$project$Answers$dayDiv, 'December Four', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Five', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Six', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Seven', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Eight', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Nine', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Ten', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Eleven', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Twelve', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Thirteen', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Fourteen', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Fifteen', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Sixteen', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Seventeen', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Eighteen', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Nineteen', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Twenty', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Twenty-One', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Twenty-Two', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Twenty-Three', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Twenty-Four', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A3(author$project$Answers$dayDiv, 'December Twenty-Five', elm$core$Maybe$Nothing, elm$core$Maybe$Nothing),
			A2(
			elm$html$Html$div,
			_List_fromArray(
				[
					elm$html$Html$Attributes$class('flex-spacer')
				]),
			_List_Nil)
		]));
_Platform_export({'Answers':{'init':_VirtualDom_init(author$project$Answers$main)(0)(0)}});}(this));