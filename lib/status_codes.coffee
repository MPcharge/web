# Defines the reverse of http.STATUS_CODES (and wraps that for convenience, too)

status = {}
for num, str of (require 'http').STATUS_CODES
    status[str.toUpperCase().replace /\s/g,'_'] = Number(num)
    status[num] = str

module.exports = status
