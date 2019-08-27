# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $("#logout").on "click", (e) ->
    e.preventDefault()
    $.ajax(
      url: "/logout"
      type: "DELETE"
      statusCode: {
        200: (response) ->
          window.location.reload()
      }
    )
