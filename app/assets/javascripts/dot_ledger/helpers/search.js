DotLedger.module('Helpers', function () {
  this.Search = function (input) {
    var query = new DotLedger.Models.QueryParams();
    var data = {};

    input.category = input.category || input.category_id;
    input.account = input.account || input.account_id;
    input.date_from = input.date_from || input.actual_date_from;
    input.date_to = input.date_to || input.actual_date_to;
    input.tags = _.compact(input.tags);
    if (input.tags.length === 0) {
      input.tags = _.compact(input.tag_ids);
    }

    data['query'] = input.query;
    if (input.category > 0) {
      data['category_id'] = input.category;
    } else if (input.category === -1) {
      data['unsorted'] = 'true';
    } else {
      data['category_type'] = input.category_type;
    }
    if (input.date_from && input.date_from != "") {
      data['date_from'] = DotLedger.Helpers.Format.queryDate(moment(input.date_from).zone(input.date_from));
    }
    if (input.date_to && input.date_to != "") {
      data['date_to'] = DotLedger.Helpers.Format.queryDate(moment(input.date_to).zone(input.date_to));
    }
    if (input.tags.length > 0) {
      data['tag_ids'] = input.tags;
    }

    if (input.account) {
      data['account_id'] = input.account;
    }

    data['review'] = input.review;

    query.set(_.compactObject(data));

    return query;
  };
});