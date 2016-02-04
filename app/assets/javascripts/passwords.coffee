# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery(document).on "page:change", ->
  jQuery('#table-link').click ->
    jQuery('#password-table').fadeToggle()

jQuery(document).on "page:change", ->
  jQuery('#import-link').click ->
    jQuery('#import-passwords').fadeToggle()

jQuery(document).on "page:change", ->
  jQuery('#create-password-link').click ->
    jQuery('#password-form').fadeToggle()
