$ ->
#the above is equal to document ready
  a = 10

  b = 5 if a > 10

  c = 5 if a == 10

  capitalize = (string) ->
    string.charAt(0).toUpperCase() + string.slice(1)

  console.log capitalize("cristian")

  $(".btn").on "click", ->
    $(@).toggleClass('btn-danger')
# the @ is equivalent to "this"
