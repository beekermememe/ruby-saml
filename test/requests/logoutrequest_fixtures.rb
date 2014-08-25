#encoding: utf-8

def default_request_opts
  {
      :uuid => "_28024690-000e-0130-b6d2-38f6b112be8b",
      :issue_instant => Time.now.strftime('%Y-%m-%dT%H:%M:%SZ'),
      :settings => settings
  }
end

def valid_request(opts = {})
  opts = default_request_opts.merge!(opts)

  "<samlp:LogoutRequest
        xmlns:samlp=\"urn:oasis:names:tc:SAML:2.0:protocol\"
        ID=\"#{random_id}\" Version=\"2.0\"
        IssueInstant=\"#{opts[:issue_instant]}\"
        Destination=\"#{opts[:settings].assertion_consumer_logout_service_url}\">
      <saml:Issuer xmlns:saml=\"urn:oasis:names:tc:SAML:2.0:assertion\">#{opts[:settings].issuer}</saml:Issuer>
      </samlp:LogoutRequest>"
  "<samlp:LogoutRequest ID=\"f8a62847-92f2-4f0c-936a-df9efe0cc42f\"
                 Version=\"2.0\"
                 IssueInstant=\"2013-08-29T20:53:50Z\"
                 Destination=\"https://server/adfs/ls/\"
                 Consent=\"urn:oasis:names:tc:SAML:2.0:consent:unspecified\"
                 xmlns:samlp=\"urn:oasis:names:tc:SAML:2.0:protocol\"
                 >
      <saml:Issuer xmlns:saml=\"urn:oasis:names:tc:SAML:2.0:assertion\">https://sp.com/</saml:Issuer>
      <Signature xmlns=\"http://www.w3.org/2000/09/xmldsig#\">
          <SignedInfo>
              <CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\" />
              <SignatureMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#rsa-sha1\" />
              <Reference URI=\"#f8a62847-92f2-4f0c-936a-df9efe0cc42f\">
                  <Transforms>
                      <Transform Algorithm=\"http://www.w3.org/2000/09/xmldsig#enveloped-signature\" />
                      <Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\" />
                  </Transforms>
                  <DigestMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#sha1\" />
                  <DigestValue>W7F1E2U1OAHRXn/ItbnsYZyXw/8=</DigestValue>
              </Reference>
          </SignedInfo>
          <SignatureValue></SignatureValue>
          <KeyInfo>
              <X509Data>
                  <X509Certificate></X509Certificate>
              </X509Data>
          </KeyInfo>
      </Signature>
      <saml:NameID xmlns:saml=\"urn:oasis:names:tc:SAML:2.0:assertion\"
                   Format=\"http://schemas.xmlsoap.org/claims/UPN\"
                   >user</saml:NameID>
      <samlp:SessionIndex>_2537f94b-a150-415e-9a45-3c6fa2b6dd60</samlp:SessionIndex>
  </samlp:LogoutRequest>"
end

def invalid_xml_request
  "<samlp:SomethingAwful
        xmlns:samlp=\"urn:oasis:names:tc:SAML:2.0:protocol\"
        ID=\"#{random_id}\" Version=\"2.0\">
      </samlp:SomethingAwful>"
end

def settings
  @settings ||= Onelogin::Saml::Settings.new(
      {
          :assertion_consumer_service_url => "http://app.muda.no/sso/consume",
          :assertion_consumer_logout_service_url => "http://app.muda.no/sso/consume_logout",
          :issuer => "http://app.muda.no",
          :sp_name_qualifier => "http://sso.muda.no",
          :idp_sso_target_url => "http://sso.muda.no/sso",
          :idp_slo_target_url => "http://sso.muda.no/slo",
          :idp_cert_fingerprint => "00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00",
          :name_identifier_format => "urn:oasis:names:tc:SAML:2.0:nameid-format:transient",
      }
  )
end

# logoutresponse fixtures
def random_id
  "_#{UUID.new.generate}"
end

