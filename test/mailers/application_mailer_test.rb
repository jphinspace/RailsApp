require "test_helper"

class ApplicationMailerTest < ActionMailer::TestCase
  test "should inherit from ActionMailer::Base" do
    assert_equal ActionMailer::Base, ApplicationMailer.superclass
  end

  test "should have default from address configured" do
    # Test the default from address
    assert_equal "from@example.com", ApplicationMailer.default[:from]
  end

  test "should have mailer layout configured" do
    # Test that the layout is set to "mailer"
    assert_equal "mailer", ApplicationMailer._layout
  end

  test "should support ActionMailer features" do
    # Test that ApplicationMailer responds to common ActionMailer methods
    mailer_instance = ApplicationMailer.new
    assert_respond_to mailer_instance, :mail
    assert_respond_to ApplicationMailer, :default
  end

  test "should have proper configuration" do
    # Test basic mailer properties
    assert ApplicationMailer.respond_to?(:default)
    assert ApplicationMailer.ancestors.include?(ActionMailer::Base)
  end

  test "should have view paths configured" do
    # Test that view paths are set up
    assert_not_nil ApplicationMailer.view_paths
    assert_kind_of ActionView::PathSet, ApplicationMailer.view_paths
  end
end

# Create a test mailer for inheritance testing
class TestMailer < ApplicationMailer
  def welcome_email(user_email)
    @user_email = user_email
    mail(to: user_email, subject: "Welcome!")
  end
end

class ApplicationMailerInheritanceTest < ActionMailer::TestCase
  test "should allow subclassing through named class" do
    # Test that mailers can inherit from ApplicationMailer
    assert_equal ApplicationMailer, TestMailer.superclass

    mailer = TestMailer.new
    assert_kind_of ApplicationMailer, mailer
  end

  test "should inherit default configuration in subclasses" do
    # Test that subclass inherits the default from address
    mail = TestMailer.welcome_email("user@example.com")
    assert_equal "from@example.com", mail.from.first
    assert_equal "user@example.com", mail.to.first
    assert_equal "Welcome!", mail.subject
  end

  test "should use mailer layout by default" do
    # The layout should be inherited from ApplicationMailer
    assert_equal "mailer", TestMailer._layout
  end

  test "should handle mail creation" do
    # Test mail creation without delivery
    mail = TestMailer.welcome_email("test@example.com")
    assert_instance_of ActionMailer::MessageDelivery, mail
    assert_equal [ "test@example.com" ], mail.to
  end
end
