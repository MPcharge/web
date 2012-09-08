# Collects info about all existing resources
# See http://github.com/MPcharge/web/wiki/Resources

# Literal URLs always have precedence over templated ones.
# For templated URLs, the ones nearer the top of the file override the ones below

# Function signatures
# -------------------
#
# If the URL is templated, the first parameter is always a hash of the URL parameters.
# 
# The other parameter is the parsed body object for all but GET (and GET_ALL) methods.
# (Note: bodies will always be short, JSON or form-encoded data, therefore we can pass complete
# parsed objects insted of dealing with streams )
#
# For GET the other parameter is a boolean specifying whether GET_ALL is allowed.

st = require './lib/status_codes'

resource '/',
         'the homepage - general info about MPcharge',
         GET: -> message: 'Welcome to the MPcharge website!'
               , status: 'kind of unfinished'

resource '/test  /test/{p1}  /test/{p1}/blah/{p2}/',
         'Echo resource for testing purposes',
         GET: (params) -> params
         POST: (params, body) -> { params, body }
         PUT: (params, body) -> statusCode: st.INTERNAL_SERVER_ERROR
                              , message: "I would PUT if I could, but I can't, so I shan't."
         DELETE: (params, body) -> statusCode: st.FORBIDDEN, message: "You're ugly!"

resource '/greedy-pattern/{x...}  /greedy/{p1}/{p2...}',
         'Shows that url patterns can be greedy and combined',
         GET: (params) -> params

resource '/test-priv',
         'Test resource that shows how the GET_ALL privilege should be handled',
         GET: (GET_ALL) -> message: if GET_ALL then 'yes, you can' else 'go away'
