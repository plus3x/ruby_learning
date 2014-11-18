require 'active_support/core_ext/hash'

DATA = '<?xml version="1." encoding="UTF-8" ?>
  <paymentAvisoReqest
    paymentPayerCode="132268557"
    orderSmBankPaycash="13"
    paymentDatetime="21-1-16T1:22:6.2+:"
    shopSmBankPaycash="13"
    invoiceId="212339"
    reqestDatetime="21-1-16T1:22:6.+:"
    shopId="11"
    cstomerNmber="71"
    shopSmAmont="81.7"
    orderSmCrrencyPaycash="163"
    shopSmCrrencyPaycash="163"
    orderSmAmont="86."
    orderCreatedDatetime="21-1-16T1:21:5.85+:"
  >
    <param key="targetcrrency" val="63"></param>
    <param key="cps_theme" val="defalt"></param>
    <param key="isOUTshop" val="tre"></param>
    <param key="merchant_order_id" val="71_16111219__11"></param>
    <param key="smCrrency" val=""></param>
    <param key="failUrl" val="http://www.sharanavti.r"></param>
    <param key="ym_need_system_params" val="1"></param>
    <param key="ErrorTemplate" val="ym2xmlerror"></param>
    <param key="sccessUrl" val="http://www.sharanavti.r"></param>
    <param key="isViaWeb" val="tre"></param>
    <param key="SccessTemplate" val="ym2xmlsccess"></param>
    <param key="cps-sorce" val="defalt"></param>
    <param key="backrl" val="http://www.sharanavti.r"></param>
    <param key="scid" val="531"></param>
</paymentAvisoReqest>'

puts hash = Hash.from_xml(DATA)
puts "Payment payer code: #{hash['paymentAvisoReqest']['paymentPayerCode']}"