angular.module('rupert-demo.hello.service', [

]).factory 'HelloSvc', ($http, $q)->
  names = {}
  sayhello = (name)->
    name = name.toLowerCase()
    if names[name]
      return $q((r)-> r({alreadymet: true, name}))
    $http.post('/api/hello', {name}).then (_)-> names[name] = _.data

  { sayhello }
