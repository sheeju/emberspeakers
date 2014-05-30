// ember/app/routes/speakers/index.js
export default Ember.Route.extend({
  model: function() {
    return this.store.find('speaker');
  }
});