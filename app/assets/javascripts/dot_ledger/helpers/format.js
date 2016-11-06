DotLedger.module('Helpers', function () {
  this.Format = {
    money: function (number) {
      number = (number || 0);
      return '$' + (parseFloat(number).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'));
    },

    pluralize: function (count, singular, plural) {
      var word;
      word = count === 1 ? singular : plural;
      return (count || 0) + ' ' + word;
    },

    shortDateTime: function (date) {
      return moment(date).format('D MMM YYYY hh:mm:ss');
    },

    shortDate: function (date) {
      return moment(date).format('D MMM YYYY');
    },

    queryDate: function (date) {
      return moment(date).format('YYYY-MM-DD');
    },

    titleDate: function (date) {
      return moment(date).format('LL');
    },

    unixTimestamp: function (date) {
      return moment(date).format('X');
    },

    unixMilliTimestamp: function (date) {
      return moment(date).format('x');
    },

    agoDate: function (date) {
      return moment(date).fromNow();
    }
  };
});
