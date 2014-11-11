angular.module('rupert-demo.hello', [
  'rupert-demo.hello.service'
  'hello.hello-template.template'
]).directive 'hello', (HelloSvc)->
  restrict: 'AE'
  templateUrl: 'hello/hello-template'
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
