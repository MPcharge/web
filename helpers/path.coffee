# Provides the base path behavior

path_prototype =
    prototype = String.prototype

# Makes a canonical path out of a string.
exports.createPath = (path, separator='/') ->
    # canonicalize
    path += separator  # we always want it to end with the separator (just so it is consistent)
    path = path.replace (new RegExp "#{separator}+", 'g'), separator

    path.prototype = path_prototype
    path.separator = separator
    path
