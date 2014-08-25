require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))
require 'rexml/document'
require 'requests/logoutrequest_fixtures'
class RubySamlTest < Test::Unit::TestCase

  context "SloLogoutrequest" do
    context "#new" do
      should "raise an exception when request is initialized with nil" do
        assert_raises(ArgumentError) { Onelogin::Saml::SloLogoutrequest.new(nil) }
      end
      should "accept constructor-injected options" do
        logoutrequest= Onelogin::Saml::SloLogoutrequest.new(valid_request, { :foo => :bar} )
        assert !logoutrequest.options.empty?
      end
      should "support base64 encoded responses" do
        expected_request = valid_request
        logoutrequest= Onelogin::Saml::SloLogoutrequest.new(Base64.encode64(expected_request))

        assert_equal expected_request, logoutrequest.request
      end
    end

    context "#validate!" do
      should "validates good requests" do
        logoutrequest = Onelogin::Saml::SloLogoutrequest.new(valid_request)
        logoutrequest.validate!
      end

      should "raise error for invalid xml" do
        logoutrequest = Onelogin::Saml::SloLogoutrequest.new(invalid_xml_request)
        assert_raises(Onelogin::Saml::ValidationError) { logoutrequest.validate! }
      end
    end

  end

  # logoutresponse fixtures
  def random_id
    "_#{UUID.new.generate}"
  end

end
