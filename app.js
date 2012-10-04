require('coffee-script');

/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , http = require('http')
  , path = require('path');

var app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(require('connect-assets')());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});


// ENV 
app.configure('development', function(){
  app.use(express.errorHandler({
    dumpExceptions: true,
    showStack: true
  }));
});

app.configure('test', function(){
  app.set('port', 3001)
});

app.configure('production', function(){
  app.use(express.errorHandler());
})



// routes
app.get('/', routes.index);


http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port port %d in %s mode", app.settings.port, app.settings.env);
});
