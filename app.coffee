
express = require 'express'
routes = require './routes'
io = require 'socket.io'

console.log routes.ceva
app = module.exports = express.createServer()


app.configure -> 
  app.set 'views', __dirname + '/views' 
  app.set 'view engine', 'coffee'
  app.register '.coffee', require('coffeekup').adapters.express
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static __dirname + '/client/public'


app.configure 'development', ->
  app.use express.errorHandler dumpExceptions: true, showStack: true 


app.configure 'production', -> 
  app.use express.errorHandler() 


app.get '/', routes.index


io.listen app 
app.listen 3000, ->
  console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
