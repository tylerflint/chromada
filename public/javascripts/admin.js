jQuery(function ($) {

	var csrf_token = $('meta[name=csrf-token]').attr('content'),
    	csrf_param = $('meta[name=csrf-param]').attr('content');

	$('.delete').click(function (event){
		var link = $(this),
	        href = link.attr('href'),
	        form = $('<form method="post" action="'+href+'"></form>'),
	        metadata_input = '<input name="_method" value="delete" type="hidden" />';

	    if (csrf_param != null && csrf_token != null) {
	      metadata_input += '<input name="'+csrf_param+'" value="'+csrf_token+'" type="hidden" />';
	    }

	    form.hide()
	        .append(metadata_input)
	        .appendTo('body');

	    event.preventDefault();
	    form.submit();
	})

});
