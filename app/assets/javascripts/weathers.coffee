# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  tempButton = $(".temp_toggle.active")
  tempType = $(tempButton).data('temp-type')

  window.toggleTempType = (tempType) ->
    $(".temp_data").hide().promise().done ->
      $(".temp_data." + tempType).show()

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

  $(".temp_toggle").unbind().on "click", (e) ->
    e.preventDefault()
    $(".temp_toggle").toggleClass('active').promise().done ->
      tempType = $(e.target).data('temp-type')
      toggleTempType(tempType)

  $(".refresh_temp").unbind().on "click", (e) ->
    e.preventDefault()
    locationId = $(this).attr('data-location-id')
    locationZip = $(this).data('location-zip')
    $.ajax(
      url: '/refresh_weather?location_id=' + locationId + '&zipcode=' + locationZip
      type: 'POST'
      data: { location_id: locationId, zipcode: locationZip }
      statusCode: {
        200: (response) ->
          # Success response
          $.getScript(window.location.pathname + window.location.search)
        404: (response) ->
          # Not Found response
        422: (response) ->
          # UE response
      }
    )

  window.removeTemp = ->
    $('.remove_temp').unbind().on "click", (e) ->
      e.preventDefault()
      url = $(this).data('path')
      $.ajax(
        url: url
        type: 'DELETE'
        statusCode: {
          200: (response) ->
            $.getScript(window.location.pathname + window.location.search)
          422: (response) ->
        }
      )


  toggleTempType(tempType)
  removeTemp()
