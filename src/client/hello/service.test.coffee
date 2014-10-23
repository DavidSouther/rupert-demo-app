describe 'Hello Service', ->
  beforeEach ->
    module 'rupert-demo.hello.service', 'rupert-demo.hello.service.mock'

  beforeEach inject ($httpBackend)->
    $httpBackend
      .whenPOST('/api/hello', '{"name":"david"}')
      .respond(200, JSON.stringify({name: 'david'}))
    $httpBackend
      .whenPOST('/api/hello', '{"name":"rupert"}')
      .respond(200, JSON.stringify({name: 'rupert', alreadymet: yes}))

  afterEach inject ($httpBackend)->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  it 'accepts hellos', inject (HelloSvc, $httpBackend)->
    HelloSvc.should.have.property('sayhello').that.is.instanceof(Function)
    HelloSvc.sayhello('David').then (reply)-> reply.name.should.equal 'david'
    $httpBackend.expectPOST('/api/hello')
    $httpBackend.flush()

  it 'remembers names', inject (HelloSvc, $httpBackend, $timeout)->
    HelloSvc.sayhello('Rupert').then (reply)->
      reply.name.should.equal 'rupert'
      reply.should.have.property('alreadymet').that.equals(true)
    $httpBackend.expectPOST('/api/hello')
    $httpBackend.flush()
    HelloSvc.sayhello('Rupert').then (reply)-> reply.name.should.equal 'rupert'
    $timeout.flush()
    ## NO REQUEST The second time.
