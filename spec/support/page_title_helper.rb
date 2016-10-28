module PageTitleHelper
  def expect_page_title_to_be(*parts)
    seperator = " \u00B7 " # &middot;

    parts.push 'Dot Ledger'

    title = parts.join seperator

    expect(page).to have_title title
  end
end
