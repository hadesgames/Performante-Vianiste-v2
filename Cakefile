fs            = require 'fs'
{print}       = require 'sys'
{spawn, exec} = require 'child_process'

build = (watch, callback) ->
  if typeof watch is 'function'
    callback = watch
    watch = false
  options = ['-c',  'app.coffee']
  options.unshift '-w' if watch

  coffee = spawn 'coffee', options
  coffee.stdout.on 'data', callback
  coffee.stderr.on 'data', (data) -> print data.toString()
  coffee.on 'exit', (status) -> callback?() if status is 0

spec = (callback) ->
  options = ['spec', '--coffee']
  spec = spawn 'jasmine-node', options
  spec.stdout.on 'data', (data) -> print data.toString()
  spec.stderr.on 'data', (data) -> print data.toString()
  spec.on 'exit', (status) -> callback?() if status is 0


task 'docs', 'Generate annotated source code with Docco', ->
  fs.readdir 'src', (err, contents) ->
    files = ("src/#{file}" for file in contents when /\.coffee$/.test file)
    docco = spawn 'docco', files
    docco.stdout.on 'data', (data) -> print data.toString()
    docco.stderr.on 'data', (data) -> print data.toString()
    docco.on 'exit', (status) -> callback?() if status is 0

task 'build', 'Compile CoffeeScript source files', ->
  build()

task 'watch', 'Recompile CoffeeScript source files when modified', ->
  build true

task 'spec', 'Run Jasmine-Node', ->
  build -> spec -> console.log ":)"

task 'runserver', 'Run Development Server', ->
  server = null
  build true, ->
    if server
      server.kill "SIGHUP"
    server = spawn 'node', ['app.js']
    server.stdout.on 'data', (data) -> print data.toString()
    server.stderr.on 'data', (data) -> print data.toString()
    server.on 'error', (err) -> console.log err
    server.on 'exit', (status) -> console.log status
