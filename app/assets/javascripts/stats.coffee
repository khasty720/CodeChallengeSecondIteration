# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  Morris.Bar
    element: 'stats-bar-chart'
    data: $('#stats-bar-chart').data('stats')
    xkey: 'plain_text_pass'
    ykeys: ['count']
    labels: ['Password Reuse Count']
    resize: true
    hideHover: 'auto'
