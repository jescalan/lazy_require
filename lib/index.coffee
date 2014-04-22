###*
 * Requires a library, but only loads it when it's actually used.
 *
 * @param  {String} lib - name of the lib you want to load
 * @param  {String} name - name of the var you want to assign the lib to
 * @return {*} a getter for the library you wanted to load
###

module.exports = (lib, name) ->
  if not name then name = lib
  @__defineGetter__(name, (-> require(lib)));
