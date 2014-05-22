import Resolver from 'ember/resolver';
import loadInitializers from 'ember/load-initializers';

Ember.MODEL_FACTORY_INJECTIONS = true;

var App = Ember.Application.extend({
  modulePrefix: 'emberspeakers', // TODO: loaded via config
  Resolver: Resolver
});

loadInitializers(App, 'emberspeakers');

export default App;
