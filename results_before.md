running in gem static analyzer directly:

```
➜  mailjet-gem git:(memory_profile) ✗ bundle exec derailed bundle:mem
TOP: 22.6289 MiB
  mailjet: 18.2305 MiB
    mailjet/resource: 15.8164 MiB
      mailjet/connection: 10.7539 MiB
        rest_client: 10.7148 MiB
          /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient: 10.7148 MiB
            /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/abstract_response: 5.0273 MiB
              http-cookie: 4.9766 MiB
                http/cookie: 4.9766 MiB
                  domain_name: 4.8086 MiB
                    domain_name/etld_data: 4.6328 MiB
            openssl: 2.4805 MiB
              openssl.so: 1.2383 MiB
              openssl/ssl: 1.1406 MiB
            /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request: 1.7656 MiB
              tempfile: 1.0352 MiB (Also required by: /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/payload)
                tmpdir: 0.8281 MiB
                  fileutils: 0.668 MiB
              cgi: 0.4258 MiB (Also required by: /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/abstract_response, i18n/exceptions)
            net/http: 0.9297 MiB
              /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/protocol: 0.3125 MiB
      active_support/core_ext/string: 4.8711 MiB
        active_support/core_ext/string/conversions: 4.6445 MiB (Also required by: active_support/core_ext/string/zones)
          active_support/core_ext/time/calculations: 4.6445 MiB
            active_support/core_ext/time/conversions: 2.707 MiB (Also required by: active_support/core_ext/date_time/conversions)
              active_support/values/time_zone: 2.6875 MiB (Also required by: active_support/time_with_zone, active_support/core_ext/date_time/conversions)
                tzinfo: 2.5469 MiB
                  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/tzinfo-2.0.5/lib/tzinfo/string_deduper: 1.9063 MiB
                    concurrent: 1.875 MiB (Also required by: /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/tzinfo-2.0.5/lib/tzinfo/data_source)
                      concurrent/configuration: 0.3711 MiB (Also required by: concurrent/scheduled_task, concurrent/options, and 2 others)
                      concurrent/promises: 0.3281 MiB
                      concurrent/executors: 0.3203 MiB
            active_support/duration: 1.2539 MiB (Also required by: active_support/time_with_zone, active_support/core_ext/date/calculations)
              active_support/core_ext/array/conversions: 1.0859 MiB
                active_support/core_ext/string/inflections: 1.0313 MiB (Also required by: active_support/core_ext/string, active_support/core_ext/hash/conversions)
                  active_support/inflector/methods: 0.9883 MiB (Also required by: active_support/core_ext/time/conversions, active_support/core_ext/date_time/conversions)
                    active_support/inflections: 0.9102 MiB
                      active_support/inflector/inflections: 0.7578 MiB
                        concurrent/map: 0.3945 MiB (Also required by: i18n, active_support/core_ext/object/blank, and 2 others)
                        active_support/i18n: 0.3242 MiB (Also required by: active_support/inflector/transliterate)
            active_support/time_with_zone: 0.5078 MiB (Also required by: active_support/core_ext/time/zones)
              yaml: 0.3672 MiB
                psych: 0.3633 MiB
  mime-types: 3.3633 MiB
    mime/types: 3.3633 MiB (Also required by: mime/types/columnar)
      mime/types/registry: 2.9805 MiB
  memory_profiler: 0.7422 MiB
    memory_profiler/cli: 0.5625 MiB
```

```
➜  mailjet-gem git:(memory_profile) ✗ bundle exec derailed bundle:objects
Measuring objects created by gems in groups [:default, "production"]
Total allocated: 21598518 bytes (251114 objects)
Total retained:  4769137 bytes (46190 objects)

allocated memory by gem
-----------------------------------
  11131246  dead_end-4.0.0
   5304274  mime-types-3.4.1
   1566124  activesupport-7.0.4
   1444040  set
    466272  domain_name-0.5.20190701
    312502  x86_64-darwin21
    299959  concurrent-ruby-1.1.10
    266675  mailjet-gem/lib
    105173  rest-client-2.1.0
     95833  net
     77472  fileutils
     69996  tzinfo-2.0.5
     67669  json-2.6.3
     54724  forwardable
     54537  openssl
     50448  delegate
     46780  psych
     33356  pathname
     26347  i18n-1.12.0
     25320  http-accept-1.7.0
     19488  benchmark-ips-2.10.0
     18064  cgi
     13560  erb
      7424  logger
      6168  rack-2.2.5
      6038  http-cookie-1.0.5
      5785  ipaddr
      4214  unf-0.1.4
      3696  netrc-0.11.0
      3592  stackprof-0.2.23
      3580  timeout-0.3.1
      1904  tempfile
      1760  bundler
      1608  ostruct
      1274  tmpdir
       792  socket
       632  mime-types-data-3.2022.0105
       112  digest
        40  derailed_benchmarks-2.1.2
        40  yaml

allocated memory by file
-----------------------------------
  11131246  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/dead_end-4.0.0/lib/dead_end/core_ext.rb
   4103529  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/mime-types-3.4.1/lib/mime/type.rb
   1444040  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/set.rb
```

dinmic analyzer with code
```
require 'dotenv/load'
require 'memory_profiler'
require 'mailjet'

Mailjet.configure do |config|
  config.api_key = ENV['MJ_APIKEY_PUBLIC']
  config.secret_key = ENV['MJ_APIKEY_PRIVATE']
end

report = MemoryProfiler.report do
  10.times do
    Mailjet::Send.create({
          messages: [{
          'From'=> {
              'Email'=> '$SENDER_EMAIL',
              'Name'=> 'Me'
          },
          'To'=> [
              {
                  'Email'=> '$RECIPIENT_EMAIL',
                  'Name'=> 'You'
              }
          ],
          'Subject'=> 'My first Mailjet Email!',
          'TextPart'=> 'Greetings from Mailjet!',
          'HTMLPart'=> '<h3>Dear passenger 1, welcome to <a href=\'https://www.mailjet.com/\'>Mailjet</a>!</h3><br />May the delivery force be with you!'
        }]
      },
      version: 'v3.1'
    )

    Mailjet::Listrecipient.all(limit: 0)
    Mailjet::Listrecipient.first
  end
end

report.pretty_print
```

```
Total allocated: 2620378 bytes (30115 objects)
Total retained:  28107 bytes (121 objects)

allocated memory by gem
-----------------------------------
   1020934  net
    446808  rest-client-2.1.0
    263404  openssl
    239988  mailjet-gem/lib
    147200  activesupport-7.0.4
    126970  json-2.6.3
     83240  uri
     73587  http-cookie-1.0.5
     66657  i18n-1.12.0
     46478  netrc-0.11.0
     31680  mime-types-3.4.1
     24672  set
     24360  http-accept-1.7.0
     19120  other
      4080  monitor
      1200  rubygems

allocated memory by file
-----------------------------------
    571310  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/protocol.rb
    314052  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb
    226400  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb
    204778  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb
    193100  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb
    126970  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/json-2.6.3/lib/json/common.rb
    100240  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/inflector/methods.rb
     88210  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/response.rb
     80584  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http.rb
     70304  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/buffering.rb
     55320  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/uri/rfc3986_parser.rb
     54430  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/generic_request.rb
     53700  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/abstract_response.rb
     46478  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/netrc-0.11.0/lib/netrc.rb
     39120  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/resource.rb
     36340  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb
     35210  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/connection.rb
     31680  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/mime-types-3.4.1/lib/mime/types.rb
     27291  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb
     27125  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/backend/fallbacks.rb
     24672  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/set.rb
     24160  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/uri/generic.rb
     21136  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/response.rb
     20240  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/core_ext/hash/reverse_merge.rb
     17880  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-accept-1.7.0/lib/http/accept/media_types.rb
     14080  memory_profile.rb
     12790  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb
     12763  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/simple.rb
     12667  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag.rb
     12480  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/hash_with_indifferent_access.rb
     10080  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/core_ext/hash/indifferent_access.rb
      9956  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/hash_store.rb
      8800  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/utils.rb
      6720  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/platform.rb
      6480  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-accept-1.7.0/lib/http/accept/sort.rb
      5040  <internal:pack>
      4160  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/core_ext/hash/keys.rb
      4080  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/monitor.rb
      3280  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/payload.rb
      2160  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/uri/http.rb
      1600  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/uri/common.rb
      1200  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/rubygems/version.rb
       720  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/parents.rb
       592  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale.rb

allocated memory by location
-----------------------------------
    560510  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/protocol.rb:234
    124970  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/json-2.6.3/lib/json/common.rb:216
     84960  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:561
     84000  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/inflector/methods.rb:100
     70400  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:221
     49508  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:268
     47490  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:172
     38064  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/buffering.rb:182
     36126  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:334
     31200  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:265
     30552  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:267
     30200  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/uri/rfc3986_parser.rb:22
     28700  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/response.rb:57
     27125  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/backend/fallbacks.rb:18
     25358  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/netrc-0.11.0/lib/netrc.rb:43
     25280  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:240
     22860  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/response.rb:64
     22720  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:130
     22470  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:136
     21560  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:154
     21043  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb:18
     20240  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/core_ext/hash/reverse_merge.rb:15
     19936  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/response.rb:50
     19680  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/mime-types-3.4.1/lib/mime/types.rb:155
     18890  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:214
     18620  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb:18
     18560  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/resource.rb:51
     17760  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/buffering.rb:383
     17600  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:232
     17280  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:559
     16810  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:40
     16800  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:205
     16750  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/generic_request.rb:332
     16250  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/connection.rb:73
     16120  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/abstract_response.rb:181
     16000  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/response.rb:59
     16000  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:208
     14640  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http.rb:987
     14400  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/generic_request.rb:37
     14400  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:266
     14400  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:303
     14400  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:309
     14400  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:563
     12480  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:862
     12480  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/connection.rb:38
     12000  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:565
     11686  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:86
     11520  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:312
     11307  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag.rb:13
     10860  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:478

allocated memory by class
-----------------------------------
   1475579  String
    355424  Hash
    209680  Array
    183296  MatchData
     67392  File
     48560  JSON::Ext::Parser
     32000  ActiveSupport::HashWithIndifferentAccess
     24000  OpenSSL::X509::Extension
     23536  Thread::Backtrace
     17288  OpenSSL::ASN1::ASN1Data
     14400  URI::HTTPS
     12755  Regexp
     12240  Enumerator
     12000  Proc
     10848  Net::HTTP
      9600  OpenSSL::ASN1::Sequence
      7740  Time
      6960  TCPSocket
      6720  JSON::Ext::Generator::State
      6600  Class
      6016  RestClient::Request
      5280  StringScanner
      4800  OpenSSL::ASN1::ObjectId
      4800  OpenSSL::ASN1::OctetString
      4800  Set
      3608  OpenSSL::SSL::SSLSocket
      3600  OpenSSL::X509::Certificate
      3600  URI::HTTP
      3376  RestClient::Response
      2888  OpenSSL::SSL::SSLContext
      2880  Net::BufferedIO
      2648  HTTP::CookieJar::HashStore
      2648  Mailjet::Connection
      2640  OpenSSL::X509::Store
      2400  Net::HTTP::Get
      2400  Net::HTTPOK
      2400  Netrc
      2400  OpenSSL::SSL::Session
      2168  Errno::ENOENT
      2160  Thread::Mutex
      1920  Monitor
      1760  DateTime
      1656  Module
      1200  HTTP::Accept::MediaTypes::MediaRange
      1200  HTTP::CookieJar
      1200  Net::HTTP::Post
      1200  Net::HTTPBadRequest
      1200  Netrc::TokenArray
      1200  RestClient::Resource
       800  Mailjet::Listrecipient

allocated objects by gem
-----------------------------------
      8854  net
      7175  rest-client-2.1.0
      4299  openssl
      2448  mailjet-gem/lib
      1700  activesupport-7.0.4
      1383  json-2.6.3
      1010  uri
       773  http-cookie-1.0.5
       600  mime-types-3.4.1
       600  netrc-0.11.0
       361  i18n-1.12.0
       331  http-accept-1.7.0
       301  set
       190  other
        60  monitor
        30  rubygems

allocated objects by file
-----------------------------------
      5572  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb
      4654  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb
      3751  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb
      2108  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb
      1720  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/response.rb
      1383  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/json-2.6.3/lib/json/common.rb
      1290  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/inflector/methods.rb
      1013  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/abstract_response.rb
      1010  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/generic_request.rb
       750  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/protocol.rb
       720  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http.rb
       600  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/mime-types-3.4.1/lib/mime/types.rb
       600  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/netrc-0.11.0/lib/netrc.rb
       548  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/buffering.rb
       480  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/uri/rfc3986_parser.rb
       460  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/uri/generic.rb
       355  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb
       340  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/connection.rb
       324  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb
       301  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/set.rb
       280  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/hash_with_indifferent_access.rb
       241  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-accept-1.7.0/lib/http/accept/media_types.rb
       220  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/utils.rb
       161  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/backend/fallbacks.rb
       160  memory_profile.rb
       120  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/platform.rb
       120  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/resource.rb
        94  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/hash_store.rb
        90  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-accept-1.7.0/lib/http/accept/sort.rb
        90  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/response.rb
        69  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb
        67  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag.rb
        60  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/monitor.rb
        60  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/core_ext/hash/indifferent_access.rb
        58  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/simple.rb
        40  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/uri/common.rb
        40  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/core_ext/hash/keys.rb
        40  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/payload.rb
        30  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/rubygems/version.rb
        30  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/uri/http.rb
        30  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/core_ext/hash/reverse_merge.rb
        30  <internal:pack>
         4  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/parents.rb
         2  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale.rb

allocated objects by location
-----------------------------------
      1740  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:561
      1440  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:221
      1333  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/json-2.6.3/lib/json/common.rb:216
       980  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/activesupport-7.0.4/lib/active_support/inflector/methods.rb:100
       660  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:265
       660  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:268
       550  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/response.rb:57
       540  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:136
       516  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:172
       500  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/response.rb:64
       481  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:267
       480  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/protocol.rb:234
       420  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:205
       420  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:334
       403  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/abstract_response.rb:181
       400  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:40
       400  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/response.rb:59
       380  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:214
       360  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/generic_request.rb:37
       360  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:266
       360  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:303
       360  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:309
       360  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:563
       323  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:154
       318  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/buffering.rb:182
       300  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/mime-types-3.4.1/lib/mime/types.rb:155
       300  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:565
       264  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:87
       260  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:25
       260  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:84
       240  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:141
       240  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:325
       240  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:330
       240  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:559
       240  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:208
       230  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:39
       221  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb:18
       210  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:570
       200  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/abstract_response.rb:184
       200  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/abstract_response.rb:187
       190  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/generic_request.rb:332
       190  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:211
       190  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:213
       190  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:215
       180  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:366
       180  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:374
       180  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/mime-types-3.4.1/lib/mime/types.rb:156
       170  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/net/http/header.rb:192
       161  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb:18
       161  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/backend/fallbacks.rb:18

allocated objects by class
-----------------------------------
     20024  String
      4244  Array
      2096  Hash
       952  MatchData
       600  OpenSSL::X509::Extension
       240  OpenSSL::ASN1::ASN1Data
       150  Proc
       120  OpenSSL::ASN1::Sequence
       120  Set
       120  URI::HTTPS
       100  ActiveSupport::HashWithIndifferentAccess
        90  Enumerator
        90  OpenSSL::X509::Certificate
        90  Time
        60  OpenSSL::ASN1::ObjectId
        60  OpenSSL::ASN1::OctetString
        60  OpenSSL::SSL::Session
        50  JSON::Ext::Parser
        41  Thread::Backtrace
        30  Errno::ENOENT
        30  HTTP::Accept::MediaTypes::MediaRange
        30  HTTP::CookieJar
        30  HTTP::CookieJar::HashStore
        30  JSON::Ext::Generator::State
        30  Mailjet::Connection
        30  Monitor
        30  Net::BufferedIO
        30  Net::HTTP
        30  Netrc
        30  Netrc::TokenArray
        30  OpenSSL::SSL::SSLContext
        30  OpenSSL::SSL::SSLSocket
        30  OpenSSL::X509::Store
        30  RestClient::Request
        30  RestClient::Resource
        30  RestClient::Response
        30  StringScanner
        30  TCPSocket
        30  Thread::Mutex
        30  URI::HTTP
        20  DateTime
        20  Mailjet::Listrecipient
        20  Net::HTTP::Get
        20  Net::HTTPOK
        11  Regexp
        10  Mailjet::Send
        10  Net::HTTP::Post
        10  Net::HTTPBadRequest
        10  RestClient::BadRequest
        10  RestClient::Payload::Base

retained memory by gem
-----------------------------------
     12082  mailjet-gem/lib
      6716  http-cookie-1.0.5
      6554  i18n-1.12.0
      2371  rest-client-2.1.0
       192  openssl
       192  set

retained memory by file
-----------------------------------
     12082  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb
      3127  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb
      2533  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb
      2371  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb
      1761  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/simple.rb
      1344  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag.rb
      1321  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb
      1056  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/hash_store.rb
       896  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/backend/fallbacks.rb
       640  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/parents.rb
       592  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale.rb
       192  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb
       192  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/set.rb

retained memory by location
-----------------------------------
     12082  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:172
      2371  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:334
      1784  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb:8
      1456  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/simple.rb:37
      1336  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb:5
      1303  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb:18
      1056  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/hash_store.rb:161
      1029  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb:18
       896  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/backend/fallbacks.rb:18
       784  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:96
       640  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/parents.rb:22
       592  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale.rb:8
       592  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag.rb:27
       528  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag.rb:26
       377  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:86
       265  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/simple.rb:13
       224  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag.rb:13
       192  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:267
       192  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/set.rb:424
       168  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb:9
        40  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb:30
        40  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:50
        40  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:56
        40  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:58
        40  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:85
        40  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/simple.rb:15

retained memory by class
-----------------------------------
     12755  Regexp
      6600  Class
      6112  String
      1656  Module
       592  Hash
       200  Array
       192  I18n::Locale::Fallbacks

retained objects by gem
-----------------------------------
        44  i18n-1.12.0
        36  http-cookie-1.0.5
        21  rest-client-2.1.0
        18  mailjet-gem/lib
         1  openssl
         1  set

retained objects by file
-----------------------------------
        21  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb
        21  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb
        18  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb
        13  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb
        13  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/backend/fallbacks.rb
        13  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb
         8  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/simple.rb
         6  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag.rb
         2  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/hash_store.rb
         2  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale.rb
         2  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/parents.rb
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/set.rb

retained objects by location
-----------------------------------
        21  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/rest-client-2.1.0/lib/restclient/request.rb:334
        18  /Users/mhryshk/develop/mailjet-gem/lib/mailjet/resource.rb:172
        17  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb:18
        13  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/backend/fallbacks.rb:18
         9  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb:18
         7  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:86
         4  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/simple.rb:13
         3  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb:8
         3  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb:5
         3  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag.rb:13
         3  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/simple.rb:37
         2  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/hash_store.rb:161
         2  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale.rb:8
         2  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:96
         2  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag.rb:27
         2  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/parents.rb:22
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/openssl/ssl.rb:267
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/2.7.0/set.rb:424
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar.rb:30
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/http-cookie-1.0.5/lib/http/cookie_jar/abstract_store.rb:9
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:50
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:56
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:58
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/fallbacks.rb:85
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag.rb:26
         1  /Users/mhryshk/.rbenv/versions/2.7.7/lib/ruby/gems/2.7.0/gems/i18n-1.12.0/lib/i18n/locale/tag/simple.rb:15

retained objects by class
-----------------------------------
        88  String
        11  Regexp
         9  Class
         5  Array
         4  Hash
         3  Module
         1  I18n::Locale::Fallbacks
```