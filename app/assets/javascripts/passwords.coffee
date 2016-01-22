# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $('#table-link').click ->
    $('#password-table').fadeToggle()

$(document).on "page:change", ->
  $('#import-link').click ->
    $('#import-passwords').fadeToggle()

$(document).on "page:change", ->
  $('#create-password-link').click ->
    $('#password-form').fadeToggle()
