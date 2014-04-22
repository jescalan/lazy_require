# lazy_require

[![npm](http://img.shields.io/npm/v/lazy_require.svg?style=flat)](https://badge.fury.io/js/lazy_require) [![tests](http://img.shields.io/travis/jenius/lazy_require/master.svg?style=flat)](https://travis-ci.org/jenius/lazy_require)

Like require, but the library is only actually loaded when it's used.

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why should you care?

With node's standard `require` function, as soon as it is run, it loads the linked module along with anything else it requires etc. down the tree. For larger dependencies, this can take a while -- I've seen larger libraries soak up 500ms+ of load time off a `require` call.

At the same time, in 99% of cases, you do not actually need a `require`d module to be executed immediately, you **only need it to be executed when it's used**. But since the convention in node is to load all dependencies at the top of each file, you are always taking on the entire dependency load upfront no matter when, whether you actually end up making a call to that module that uses all of its dependencies. For example, let's look at a basic example module, which serves as an API for interacting with doges:

```js
var DogeCreator = require('foo'),
    DogePetter = require('bar');

module.exports = {
  createDoge: function(name){ return new DogeCreator(name) },
  petDoge: function(){ DogePetter.pet(); return true }
}
```

Now, let's look at another file that requires and uses this module:

```js
var dogeAPI = require('dogeAPI');

dogeAPI.createDoge('fluffy');
```

In this example, although we only _used_ the `DogeCreator` library, we fully loaded both `DogeCreator` and `DogePetter`. So if `DogePetter` was a heavy library, you are simply wasting the time it takes to load that dependency.

What `lazy_require` does is solves this exact issue. You can `lazy_require` a module, but the module will only actually be loaded once you use it. So if we used `lazy_require` in the example above rather than `require`, we would not load `DogePetter` at all, saving any time it took to load that entire module (and its dependency tree).

### Installation

`npm install lazy_require`

### Usage

Lazy require is a hacky hack, but it works, and is, as far as I know, entirely safe. But because it's a hack, it's not quite as smooth as the built in `require` in some ways. By default, it will assign the library name you pass it to a variable of the same name. For example:

```js
lazy_require('fs');
console.log(fs); // it's defined!
```

However, if you want to assign it to a specific name, you need to pass that as the second parameter. For example:

```js
lazy_require('../lib/doge_api', 'doge')
console.log(doge); // it works!
```

Do _not_ try to use the output of `lazy_require` like you would with a normal require -- the assignment has to happen through the second parameter. That's all!

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
