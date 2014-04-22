var chai = require('chai'),
    path = require('path'),
    lazy_require = require('../..');

var should = chai.should();

global.lazy_require = lazy_require;
global.should = should;
