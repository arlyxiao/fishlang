jQuery ->
  jQuery(document).on 'click', 'a.show-translations', ->
  	id = jQuery(this).data('id')
  	jQuery('.translations-' + id).toggle();