path    = require 'path'
mockery = require 'mockery'
sinon   = require 'sinon'

describe 'lazy_require', ->

  it 'should require a library and automatically assign it', ->
    lazy_require('fs')
    fs.should.exist

  it 'should require a library and assign it to another variable', ->
    lazy_require('os', 'wow')
    wow.should.exist
    wow.should.deep.equal(require('os'))

  it "should not execute a module's code until it's called", ->
    spy = sinon.spy()
    mockery.enable()
    mockery.registerMock('foobar', spy)

    lazy_require('foobar')
    spy.should.not.have.been.called
    foobar
    spy.should.have.been.called

    mockery.deregisterAll()
    mockery.disable()

