import startApp from 'emberspeakers/tests/helpers/start-app';

var App;

module('Integration - Landing Page', {
  setup: function() {
    App = startApp();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
  }
});

test('Should welcome me to Ember Speakers', function() {
  visit('/').then(function() {
    equal(find('h2#title').text(), 'Welcome to Ember Speakers');
  });
});

// ember/tests/integration/landing-page-test.js
test('Should allow navigating back to root from another page', function() {
  visit('/about').then(function() {
    click('a:contains("Home")').then(function() {
      notEqual(find('h3').text(), 'About');
    });
  });
});