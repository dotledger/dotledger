DotLedger.module('Helpers', function () {
  this.SortTransactions = {
    sort: function (accountID) {
      var data = {};

      if (accountID) {
        data.account_id = accountID;
      }

      $.ajax({
        url: '/api/transactions/sort',
        type: 'POST',
        data: data,
        success: function (response) {
          DotLedger.Helpers.Notification.success(response.message);
          DotLedger.Helpers.Loading.stop();
        }
      });
    }
  };
});
