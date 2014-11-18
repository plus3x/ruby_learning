require 'base64'
require 'active_support/core_ext/hash'

DATA = "
-----BEGIN PKCS7-----
  MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAaCA JIAEggPoPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiID8+PHBh eW1lbnRBdmlzb1JlcXVlc3QgcGF5bWVudFBheWVyQ29kZT0iNDEwMDMyMjQ2ODU1 NyIgb3JkZXJTdW1CYW5rUGF5Y2FzaD0iMTAwMyIgcGF5bWVudERhdGV0aW1lPSIy MDE0LTAxLTE2VDE0OjIyOjA2LjAyMCswNDowMCIgc2hvcFN1bUJhbmtQYXljYXNo PSIxMDAzIiBpbnZvaWNlSWQ9IjIwMDAwMDAxMDIzMzkiIHJlcXVlc3REYXRldGlt ZT0iMjAxNC0wMS0xNlQxNDoyMjowNi40NDArMDQ6MDAiIHNob3BJZD0iMTQwMTAi IGN1c3RvbWVyTnVtYmVyPSI3MTAiIHNob3BTdW1BbW91bnQ9IjgxLjcwIiBvcmRl clN1bUN1cnJlbmN5UGF5Y2FzaD0iMTA2NDMiIHNob3BTdW1DdXJyZW5jeVBheWNh c2g9IjEwNjQzIiBvcmRlclN1bUFtb3VudD0iODYuMDAiIG9yZGVyQ3JlYXRlZERh dGV0aW1lPSIyMDE0LTAxLTE2VDE0OjIxOjUwLjgwNSswNDowMCI+PHBhcmFtIGtl eT0idGFyZ2V0Y3VycmVuY3kiIHZhbD0iNjQzIj48L3BhcmFtPjxwYXJhbSBrZXk9 ImNwc190aGVtZSIgdmFsPSJkZWZhdWx0Ij48L3BhcmFtPjxwYXJhbSBrZXk9Imlz T1VUc2hvcCIgdmFsPSJ0cnVlIj48L3BhcmFtPjxwYXJhbSBrZXk9Im1lcmNoYW50 X29yZGVyX2lkIiB2YWw9IjcxMF8xNjAxMTQxNDIxNDlfMDAwMDBfMTQwMTAiPjwv cGFyYW0+PHBhcmFtIGtleT0ic3VtQ3VycmVuY3kiIHZhbD0iMDAwIj48L3BhcmFt PjxwYXJhbSBrZXk9ImZhaWxVcmwiIHZhbD0iaHR0cDovL3d3dy5zaGFyYW5hdnRp LnJ1Ij48L3BhcmFtPjxwYXJhbSBrZXk9InltX25lZWRfc3lzdGVtX3BhcmFtcyIg dmFsPSIxIj48L3BhcmFtPjxwYXJhbSBrZXk9IkVycm9yVGVtcGxhdGUiIHZhbD0i eW0yeG1sZXJyb3IiPjwvcGFyYW0+PHBhcmFtIGtleT0ic3VjY2Vzc1VybCIgdmFs PSJodHRwOi8vd3d3LnNoYXJhbmF2dGkucnUiPjwvcGFyYW0+PHBhcmFtIGtleT0i aXNWaWFXZWIiIHZhbD0idHJ1ZSI+PC9wYXJhbT48cGFyYW0ga2V5PSJTdWNjZQSB znNzVGVtcGxhdGUiIHZhbD0ieW0yeG1sc3VjY2VzcyI+PC9wYXJhbT48cGFyYW0g a2V5PSJjcHMtc291cmNlIiB2YWw9ImRlZmF1bHQiPjwvcGFyYW0+PHBhcmFtIGtl eT0iYmFja3VybCIgdmFsPSJodHRwOi8vd3d3LnNoYXJhbmF2dGkucnUiPjwvcGFy YW0+PHBhcmFtIGtleT0ic2NpZCIgdmFsPSI1MDMxNCI+PC9wYXJhbT48L3BheW1l bnRBdmlzb1JlcXVlc3Q+AAAAAAAAoIAwggTEMIIELaADAgECAgoxIAUXAAIAAC/X MA0GCSqGSIb3DQEBBQUAMEkxCzAJBgNVBAYTAlJVMRgwFgYDVQQKEw9QUyBZYW5k ZXguTW9uZXkxIDAeBgNVBAMTF1lhbmRleCBNb25leSBJc3N1aW5nIENBMB4XDTEz MDUwNzA3NTc0MFoXDTE0MDUwNzA3NTc0MFowgZQxCzAJBgNVBAYTAlJVMRkwFwYD VQQHExBTYWludC1QZXRlcnNidXJnMRUwEwYDVQQKEwxZYW5kZXguTW9uZXkxCzAJ BgNVBAsTAklUMRYwFAYDVQQDEw1QYXltZW50Q2VudGVyMS4wLAYJKoZIhvcNAQkB Fh9zeXN0ZW1hZG1pbmlzdHJhdG9yc0B5YW1vbmV5LnJ1MIIBIjANBgkqhkiG9w0B AQEFAAOCAQ8AMIIBCgKCAQEAzH8JzMJNKDVu64bMa0Lsw9QpipcB3B7AuKOVR3t5 IF4eBeBMEVQmnlzI/oPcZyvRXXa2jV9EGfXGjqxMLg73kEOSdB3M9T0zovucmMSU HimMmMweTitF7rtTs0ifZyVFN51eiU9St9tPe9iNfRupjPQ2iIzdtOiGv2JQ4zqs 1Qly+UItmVQm/WMmykJ5EVGsKemr5X80vS03WeeeHSPccCcYu12FOaiT7ci76pY1 UMyxcsWXhzzNdvCMMgrKv5AUHhZsPMBO0lh7NQ6vNQyYBJCZjK/t8oRa4dk0jENL ktljCIxzAz0MNmc7YqpvH/ZpQ1hoQf9t/9bkPxt/Pm3ZOwIDAQABo4IB4TCCAd0w HQYDVR0OBBYEFGHGoT1H7SZ83MIbN3Vi+tveeHxjMB8GA1UdIwQYMBaAFOYs54hV acgsOj12YBbjVtpeMpLcMDUGA1UdHwQuMCwwKqAooCaGJGh0dHA6Ly9jcmxzLnlh bW9uZXkucnUvaXNzdWluZ2NhLmNybDCBzgYIKwYBBQUHAQEEgcEwgb4wgbsGCCsG AQUFBzAChoGubGRhcDovLy9DTj1ZYW5kZXglMjBNb25leSUyMElzc3VpbmclMjBD QSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMs Q049Q29uZmlndXJhdGlvbixEQz15YW1vbmV5LERDPXJ1P2NBQ2VydGlmaWNhdGU/ YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MAsGA1UdDwQE AwIHgDA+BgkrBgEEAYI3FQcEMTAvBicrBgEEAYI3FQiE09A1hPTqFIPJjSWH77cz hLbMAYFngpviFYGduX4CAWQCAQkwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUF BwMCMCcGCSsGAQQBgjcVCgQaMBgwCgYIKwYBBQUHAwQwCgYIKwYBBQUHAwIwDQYJ KoZIhvcNAQEFBQADgYEADOT9d3yznHy5Z3IEsmJfK/6rrjgn9agBOXjM6vTPaagU Ow3tqP13ShvKnFD6jl2hSKsYrJ/dUrfpvKTXX8GINBIzpS7TbwPNmc7WLuzVSnJC EqMieWD9t/8wATB+JDjPBAgJufWTgDHT4hK047WzzsAqVRYG/qVV3NdpB1MKjOEA ADGCAd0wggHZAgEBMFcwSTELMAkGA1UEBhMCUlUxGDAWBgNVBAoTD1BTIFlhbmRl eC5Nb25leTEgMB4GA1UEAxMXWWFuZGV4IE1vbmV5IElzc3VpbmcgQ0ECCjEgBRcA AgAAL9cwCQYFKw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ KoZIhvcNAQkFMQ8XDTE0MDExNjEwMjIwNlowIwYJKoZIhvcNAQkEMRYEFF+tw1Ig tJeQ2z2huAIjXXE9aAE3MA0GCSqGSIb3DQEBAQUABIIBADolrQPryo65RZeLQ1Yq YuCNECpwLr1B4XireEMTvGJKv11Dx/CjYcFEq1uw0N8DQ3EW+8g04ZM6DnlmY9Gz Ts7r/Z5b/UP+7UiAhPzmH2U8ewnT+EWmOuAtLYaL7NDkGSooiT3gCfQjFGmuFetb VToWouo3vDw6Mb835sAOojBOWKeC5u2WLQ6u37Noa/rM9+dhirnh4PMFEeTw1eUK z0yV752Ey1qGUgRM5RAf78w0xG6OiKzM8RX3LH2aQhb36Gcrachokt/TfAThtPbx 4iIg+xWa77ikRtuLQUMfYRuMcbqn+lAf9lMRfwbbdLt48vBNwf4t2KsO8V8Tnqc8 mBgAAAAAAAA=
-----END PKCS7-----
"
 
def extract_pkcs7_data(raw_pkcs7)
  data = raw_pkcs7
  data = data.sub! '-----BEGIN PKCS7-----', ''
  data = data.sub! '-----END PKCS7-----', ''

  data += "=="
  
  # base64 decode
  decoded = Base64.decode64(data)
  
  # find index of <?xml (=> startIndex)
  startIndex = decoded.index("<?xml")
  # read <\?xml version="1\.0" encoding="UTF\-8" \?><(\w+)\s ((\w+) => rootTag)
  rootTag, temp = decoded.match(/<\?xml version="1\.0" encoding="UTF\-8" \?><(\w+)\s/i).captures
  # find index of </{rootTag}> (=> endIndex)
  endTag = "</#{rootTag}>"
  endIndex = decoded.index(endTag) + endTag.length
  
  result = decoded[startIndex, endIndex - startIndex]
  
  result.encode('UTF-8', invalid: :replace, undef: :replace, replace: '').delete "\u0004"
 end
 
 puts "Decoded data: #{data = extract_pkcs7_data(DATA)}"
 puts 'HASH FROM XML'
 puts "Hash from xml: #{data = Hash.from_xml(data)}"
 
 puts 'HASH'
 data.each_key do |key, value|
   print "Key #{key} = "
   if value.is_a?(Hash)
     value.each_key do |key2, value2|
       print "->Key #{key2} = "
       if value2.is_a?(Hash)
         value2.each_key do |key3, value3|
           puts "-->Key #{key3} = Value #{value3} : Value class #{value3.class}"
         end
       else
         print "Value #{value2}"
       end
     end
   else
     print "Value #{value}"
   end
 end