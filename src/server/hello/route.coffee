names = {}

module.exports = (app, config)->
  app.post '/api/hello', (request, response)->
    reply = {name: request.body.name}
    if names[reply.name]
      reply.alreadymet = yes
    names[reply.name] = yes
    response.send reply
