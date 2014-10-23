mappings = require '../mappings'

steps = ->
  @Given /on the (?:site|page)/, =>
    @world.visit(@ROOT)
    .then => @protractor.waitForAngular()

  @When /give.*name.*"([^"]+)"/, (name)=>
    @world.fill('Name', name, yes)
    .then => @protractor.waitForAngular()

  @When /give.*name.*"([^"]+)" again/, (name)=>
    @world.visit(@ROOT)
    @world.fill('Name', name, yes)
    .then => @protractor.waitForAngular()

  @Then /friendly greeting/, =>
    @world.find(mappings.greeting).isDisplayed()
    .then (isDisplayed)->
      isDisplayed.should.equal true

  @Then /friendly already met you/, =>
    @world.find(mappings.metyou).isDisplayed()
    .then (isDisplayed)->
      isDisplayed.should.equal true

module.exports = require('rupert-grunt/steps')(steps, {protractor: yes})
