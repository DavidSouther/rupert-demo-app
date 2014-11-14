mappings = require '../mappings'
Q = require 'q'

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
    @world.find(mappings.greeting).isDisplayed().then (_)-> _.should.equal true

  @Then /friendly already met you/, =>
    @world.find(mappings.metyou).isDisplayed().then (_)-> _.should.equal true

baseSteps = require('rupert-grunt/src/features/steps')
module.exports = baseSteps(steps, {protractor: yes})
