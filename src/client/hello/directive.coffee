angular.module('rupert-demo.hello', [
  'rupert-demo.hello.service'
  'hello.template'
]).directive 'hello', (HelloSvc)->
  restrict: 'AE'
  templateUrl: 'hello'
  controller: ($scope)->
    $scope.sayhello = (name)->
      HelloSvc.sayhello(name)
      .then (reply)->
        if reply.alreadymet is true
          $scope.met = reply.name
        else
          $scope.hello = reply.name
      .catch (err)->
        $scope.error = err
