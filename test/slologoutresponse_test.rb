require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))
require 'requests/logoutrequest_fixtures'

class SloResponseTest < Test::Unit::TestCase

  context "SloLogoutresponse" do
    settings = Onelogin::Saml::Settings.new
    settings.idp_slo_target_url = "http://unauth.com/logout"
    settings.name_identifier_value = "f00f00"
    logoutrequest = Onelogin::Saml::SloLogoutrequest.new(valid_request)

    should "create the deflated SAMLRequest URL parameter" do

      unauth_url = Onelogin::Saml::SloLogoutresponse.new.create(settings, logoutrequest)
      assert unauth_url =~ /^http:\/\/unauth\.com\/logout\?SAMLResponse=/

      inflated = decode_saml_response_payload(unauth_url)

      assert_match /^<samlp:LogoutResponse/, inflated
    end

    should "set InResponseTo" do

      unauth_url = Onelogin::Saml::SloLogoutresponse.new.create(settings, logoutrequest)
      inflated = decode_saml_response_payload(unauth_url)

      assert_match %r(InResponseTo='#{logoutrequest.id}'), inflated

    end

  end

  def decode_saml_response_payload(unauth_url)
    payload = CGI.unescape(unauth_url.split("SAMLResponse=").last)
    decoded = Base64.decode64(payload)

    zstream = Zlib::Inflate.new(-Zlib::MAX_WBITS)
    inflated = zstream.inflate(decoded)
    zstream.finish
    zstream.close
    inflated
  end

end
