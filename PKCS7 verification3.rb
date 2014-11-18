require 'base64'
require 'active_support/core_ext/hash'
require 'nokogiri'

DATA = "
-----BEGIN PKCS7-----
MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAaCA JIAEggPoPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiID8+PGNo ZWNrT3JkZXJSZXF1ZXN0IHBheW1lbnRQYXllckNvZGU9IjQxMDAzMjI0Njg1NTci IG9yZGVyU3VtQmFua1BheWNhc2g9IjEwMDMiIHNob3BTdW1CYW5rUGF5Y2FzaD0i MTAwMyIgaW52b2ljZUlkPSIyMDAwMDAwMTAyMzM5IiByZXF1ZXN0RGF0ZXRpbWU9 IjIwMTQtMDEtMTZUMTQ6MjI6MDUuNzk1KzA0OjAwIiBzaG9wSWQ9IjE0MDEwIiBj dXN0b21lck51bWJlcj0iNzEwIiBzaG9wU3VtQW1vdW50PSI4MS43MCIgb3JkZXJT dW1DdXJyZW5jeVBheWNhc2g9IjEwNjQzIiBzaG9wU3VtQ3VycmVuY3lQYXljYXNo PSIxMDY0MyIgb3JkZXJTdW1BbW91bnQ9Ijg2LjAwIiBvcmRlckNyZWF0ZWREYXRl dGltZT0iMjAxNC0wMS0xNlQxNDoyMTo1MC44MDUrMDQ6MDAiPjxwYXJhbSBrZXk9 InRhcmdldGN1cnJlbmN5IiB2YWw9IjY0MyI+PC9wYXJhbT48cGFyYW0ga2V5PSJj cHNfdGhlbWUiIHZhbD0iZGVmYXVsdCI+PC9wYXJhbT48cGFyYW0ga2V5PSJpc09V VHNob3AiIHZhbD0idHJ1ZSI+PC9wYXJhbT48cGFyYW0ga2V5PSJtZXJjaGFudF9v cmRlcl9pZCIgdmFsPSI3MTBfMTYwMTE0MTQyMTQ5XzAwMDAwXzE0MDEwIj48L3Bh cmFtPjxwYXJhbSBrZXk9InN1bUN1cnJlbmN5IiB2YWw9IjAwMCI+PC9wYXJhbT48 cGFyYW0ga2V5PSJmYWlsVXJsIiB2YWw9Imh0dHA6Ly93d3cuc2hhcmFuYXZ0aS5y dSI+PC9wYXJhbT48cGFyYW0ga2V5PSJ5bV9uZWVkX3N5c3RlbV9wYXJhbXMiIHZh bD0iMSI+PC9wYXJhbT48cGFyYW0ga2V5PSJFcnJvclRlbXBsYXRlIiB2YWw9Inlt MnhtbGVycm9yIj48L3BhcmFtPjxwYXJhbSBrZXk9InN1Y2Nlc3NVcmwiIHZhbD0i aHR0cDovL3d3dy5zaGFyYW5hdnRpLnJ1Ij48L3BhcmFtPjxwYXJhbSBrZXk9Imlz VmlhV2ViIiB2YWw9InRydWUiPjwvcGFyYW0+PHBhcmFtIGtleT0iU3VjY2Vzc1Rl bXBsYXRlIiB2YWw9InltMnhtbHN1Y2Nlc3MiPjwvcGFyYW0+PHBhcmFtIGtleQSB mj0iY3BzLXNvdXJjZSIgdmFsPSJkZWZhdWx0Ij48L3BhcmFtPjxwYXJhbSBrZXk9 ImJhY2t1cmwiIHZhbD0iaHR0cDovL3d3dy5zaGFyYW5hdnRpLnJ1Ij48L3BhcmFt PjxwYXJhbSBrZXk9InNjaWQiIHZhbD0iNTAzMTQiPjwvcGFyYW0+PC9jaGVja09y ZGVyUmVxdWVzdD4AAAAAAACggDCCBMQwggQtoAMCAQICCjEgBRcAAgAAL9cwDQYJ KoZIhvcNAQEFBQAwSTELMAkGA1UEBhMCUlUxGDAWBgNVBAoTD1BTIFlhbmRleC5N b25leTEgMB4GA1UEAxMXWWFuZGV4IE1vbmV5IElzc3VpbmcgQ0EwHhcNMTMwNTA3 MDc1NzQwWhcNMTQwNTA3MDc1NzQwWjCBlDELMAkGA1UEBhMCUlUxGTAXBgNVBAcT EFNhaW50LVBldGVyc2J1cmcxFTATBgNVBAoTDFlhbmRleC5Nb25leTELMAkGA1UE CxMCSVQxFjAUBgNVBAMTDVBheW1lbnRDZW50ZXIxLjAsBgkqhkiG9w0BCQEWH3N5 c3RlbWFkbWluaXN0cmF0b3JzQHlhbW9uZXkucnUwggEiMA0GCSqGSIb3DQEBAQUA A4IBDwAwggEKAoIBAQDMfwnMwk0oNW7rhsxrQuzD1CmKlwHcHsC4o5VHe3kgXh4F 4EwRVCaeXMj+g9xnK9FddraNX0QZ9caOrEwuDveQQ5J0Hcz1PTOi+5yYxJQeKYyY zB5OK0Xuu1OzSJ9nJUU3nV6JT1K320972I19G6mM9DaIjN206Ia/YlDjOqzVCXL5 Qi2ZVCb9YybKQnkRUawp6avlfzS9LTdZ554dI9xwJxi7XYU5qJPtyLvqljVQzLFy xZeHPM128IwyCsq/kBQeFmw8wE7SWHs1Dq81DJgEkJmMr+3yhFrh2TSMQ0uS2WMI jHMDPQw2Zztiqm8f9mlDWGhB/23/1uQ/G38+bdk7AgMBAAGjggHhMIIB3TAdBgNV HQ4EFgQUYcahPUftJnzcwhs3dWL62954fGMwHwYDVR0jBBgwFoAU5izniFVpyCw6 PXZgFuNW2l4yktwwNQYDVR0fBC4wLDAqoCigJoYkaHR0cDovL2NybHMueWFtb25l eS5ydS9pc3N1aW5nY2EuY3JsMIHOBggrBgEFBQcBAQSBwTCBvjCBuwYIKwYBBQUH MAKGga5sZGFwOi8vL0NOPVlhbmRleCUyME1vbmV5JTIwSXNzdWluZyUyMENBLENO PUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1D b25maWd1cmF0aW9uLERDPXlhbW9uZXksREM9cnU/Y0FDZXJ0aWZpY2F0ZT9iYXNl P29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwCwYDVR0PBAQDAgeA MD4GCSsGAQQBgjcVBwQxMC8GJysGAQQBgjcVCITT0DWE9OoUg8mNJYfvtzOEtswB gWeCm+IVgZ25fgIBZAIBCTAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIw JwYJKwYBBAGCNxUKBBowGDAKBggrBgEFBQcDBDAKBggrBgEFBQcDAjANBgkqhkiG 9w0BAQUFAAOBgQAM5P13fLOcfLlncgSyYl8r/quuOCf1qAE5eMzq9M9pqBQ7De2o /XdKG8qcUPqOXaFIqxisn91St+m8pNdfwYg0EjOlLtNvA82ZztYu7NVKckISoyJ5 YP23/zABMH4kOM8ECAm59ZOAMdPiErTjtbPOwCpVFgb+pVXc12kHUwqM4QAAMYIB 3TCCAdkCAQEwVzBJMQswCQYDVQQGEwJSVTEYMBYGA1UEChMPUFMgWWFuZGV4Lk1v bmV5MSAwHgYDVQQDExdZYW5kZXggTW9uZXkgSXNzdWluZyBDQQIKMSAFFwACAAAv 1zAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG 9w0BCQUxDxcNMTQwMTE2MTAyMjA1WjAjBgkqhkiG9w0BCQQxFgQUhpg/5sFyd8xK T9NzZn3eY6yOBCowDQYJKoZIhvcNAQEBBQAEggEAEyU7TOVDC8PIlQ+87iU+jGbq PE0KEz+LoQyoceAB9LqCZXPwzWSS9a5bDXaZajyf9SurBNaNXu649AZgjcotNt/l 1kCoqNJO9ea/pGVIl8ImQ6LcVPLpXe7X+iUg7j8iuiGAJIrF2MZaMOPAXQFJWnhx VJbDBIWErz68xB0ID1NEgv3my2qdOcLkw1F08SxpHHM9KEvgDLyrQUgTUliVScnO WU/5OJqXBh8rpO/h7VDf1v3Y3YsmmvYfkcIQK42rjabAaphxLrJh1uP8MxN1ZsHv tFFNvk9fe3DyQuzvYPAkOPDqyLKPVZtF1L3LehOK1fhb7jO3Gd1aqQ6rtKwfQAAA AAAAAA==
-----END PKCS7-----
"

def decrypt_yandex_enterence_body(response_body)
  data = response_body
  
  data = data.sub! '-----BEGIN PKCS7-----', ''
  data = data.sub! '-----END PKCS7-----', ''
  data += "=="

  data = Base64.decode64(data)
  data = get_xml_from_data(data)
  response_body = data.encode('UTF-8', invalid: :replace, undef: :replace, replace: '').delete("\u0004")
end

def get_xml_from_data(data)
  # find index of <?xml (=> startIndex)
  startIndex = data.index("<?xml")
  # read <\?xml version="1\.0" encoding="UTF\-8" \?><(\w+)\s ((\w+) => rootTag)
  rootTag, temp = data.match(/<\?xml version="1\.0" encoding="UTF\-8" \?><(\w+)\s/i).captures
  # find index of </{rootTag}> (=> endIndex)
  endTag = "</#{rootTag}>"
  endIndex = data.index(endTag) + endTag.length

  data[startIndex, endIndex - startIndex]
end

def get_yandex_params_from_enterence_body(params, xml)
  hash = Hash.from_xml(xml)
  params = params.merge(yandex: {
        requestDatetime:         hash['paymentAvisoRequest']['requestDatetime'],
        action:                  hash.keys[0],
        shopId:                  hash['paymentAvisoRequest']['shopId'],
        invoiceId:               hash['paymentAvisoRequest']['invoiceId'],
        customerNumber:          hash['paymentAvisoRequest']['customerNumber'],
        orderCreatedDatetime:    hash['paymentAvisoRequest']['orderCreatedDatetime'],
        orderSumAmount:          hash['paymentAvisoRequest']['orderSumAmount'],
        orderSumCurrencyPaycash: hash['paymentAvisoRequest']['orderSumCurrencyPaycash'],
        orderSumBankPaycash:     hash['paymentAvisoRequest']['orderSumBankPaycash'],
        shopSumAmount:           hash['paymentAvisoRequest']['shopSumAmount'],
        shopSumCurrencyPaycash:  hash['paymentAvisoRequest']['shopSumCurrencyPaycash'],
        shopSumBankPaycash:      hash['paymentAvisoRequest']['shopSumBankPaycash'],
        paymentDatetime:         hash['paymentAvisoRequest']['paymentDatetime'],
        paymentPayerCode:        hash['paymentAvisoRequest']['paymentPayerCode'],
        user_id:                 hash['paymentAvisoRequest']['user_id'],
        gemSum:                  hash['paymentAvisoRequest']['gemSum']
  })
end

puts 'Decrypted XML: '
xml = decrypt_yandex_enterence_body(DATA)
xml = Nokogiri::XML(xml)
puts xml
puts 'NOKOGIRI'
puts "css first checkOrderRequest: #{xml.css("checkOrderRequest").first['shopId']}"
xml_css_first = (xml.css("checkOrderRequest") || xml.css("paymentAvisoRequest")).first
puts 'FIRST []'
puts xml_css_first['shopId']
puts 'Hash from XML'
# puts Hash.from_xml(xml)
puts 'Get yandex params'
# puts get_yandex_params_from_enterence_body({action: 'action', controller: 'controller'}, xml)