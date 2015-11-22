RSpec.configure do |config|
  # If you do not include FactoryGirl::Syntax::Methods in your test suite, then
  # all factory_girl methods will need to be prefaced with FactoryGirl.
  # config.include FactoryGirl::Syntax::Methods


  # additional factory_girl configuration...

  # `FactoryGirl.lint` builds each factory and subsequently calls `#valid?` on it
  # (if `#valid?` is defined); if any calls to `#valid?` return false,
  # `FactoryGirl::InvalidFactoryError` is raised with a list of the offending
  # factories. Recommended usage of `FactoryGirl.lint` is to invoke this once
  # before the test suite is run.
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
