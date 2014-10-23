request = superRupert(require('./route'))

describe "API", ->
  it "checks for a hello", (done)->
    request.post('/api/hello')
    .send({name: 'david'})
    .set('Accept', 'application/json')
    .expect(200)
    .expect('Content-Type', /application\/json/)
    .end (err, response)->
      return done(err) if err
      try
        response.body.should.have.property('name')
        response.body.should.not.have.property('alreadymet')
        response.body.name.should.equal('david')
      catch e
        reurn done e
      done()

  it "checks for a repeat hello", (done)->
    request.post('/api/hello')
    .send({name: 'rupert'})
    .set('Accept', 'application/json')
    .expect(200)
    .expect('Content-Type', /application\/json/)
    .end (err, response)->
      return done(err) if err
      try
        # The first request should not have already met Rupert.
        response.body.should.have.property('name')
        response.body.should.not.have.property('alreadymet')
        response.body.name.should.equal('rupert')
      catch e
        return done e
      request.post('/api/hello')
        .send({name: 'rupert'})
        .expect(200)
        .expect('Content-Type', /application\/json/)
        .end (err, response)->
          return done(err) if err
          try
            # The second request, of course, should have already met Rupert.
            response.body.should.have.property('name')
            response.body.should.have.property('alreadymet')
            response.body.name.should.equal('rupert')
            response.body.alreadymet.should.equal(true)
          catch e
            return done e
          done()
