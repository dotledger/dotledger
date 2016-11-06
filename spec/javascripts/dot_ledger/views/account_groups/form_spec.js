describe('DotLedger.Views.AccountGroups.Form', function () {
  var createView;
  createView = function (model) {
    var view;
    model = (model || new DotLedger.Models.AccountGroup());

    view = new DotLedger.Views.AccountGroups.Form({
      model: model
    });
    return view;
  };

  it('should be defined', function () {
    expect(DotLedger.Views.AccountGroups.Form).toBeDefined();
  });

  it('should use the correct template', function () {
    expect(DotLedger.Views.AccountGroups.Form).toUseTemplate('account_groups/form');
  });

  it('can be rendered', function () {
    var view;
    view = createView();
    expect(view.render).not.toThrow();
  });

  it('renders the form fields', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('input[name=name]');
  });

  it('renders the heading for new account_group', function () {
    var view;
    view = createView().render();
    expect(view.$el).toHaveText(/New Account Group/);
  });

  it('renders the heading existing account_group', function () {
    var model, view;
    model = new DotLedger.Models.AccountGroup({
      name: 'Some Account Group'
    });
    view = createView(model).render();
    expect(view.$el).toHaveText(/Some Account Group/);
  });

  it('renders the cancel link', function () {
    var view;
    view = createView().render();
    expect(view.$el).toContainElement('a[href="/account-groups"]');
  });

  it('should set the values on the model when update is called', function () {
    var model, view;
    model = new DotLedger.Models.AccountGroup();
    view = createView(model).render();
    view.$el.find('input[name=name]').val('Something');
    spyOn(model, 'set');
    view.update();
    expect(model.set).toHaveBeenCalledWith({
      name: 'Something'
    });
  });

  it('renders the form fields with the model values', function () {
    var model, view;
    model = new DotLedger.Models.AccountGroup({
      name: 'Account Group'
    });
    view = createView(model).render();
    expect(view.$el.find('input[name=name]')).toHaveValue('Account Group');
  });
});
