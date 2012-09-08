# provides the base 'path' and 'trie' behavior

path_prototype =
    prototype = String.prototype

# makes a canonicalized path out of a string
# separator: what separates path components
exports.createPath = (path, separator='/') ->
    # canonicalize
    path += separator  # we always want it to end with the separator (just so it is consistent)
    path = path.replace (new RegExp "#{separator}+", 'g'), separator

    path.prototype = path_prototype
    path.separator = separator
    path
