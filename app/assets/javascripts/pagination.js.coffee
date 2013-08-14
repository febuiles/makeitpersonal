jQuery ->
  window.paginating = false
  $(".pagination").hide()
  if $('.pagination').length
    $(window).scroll ->
      return if window.paginating
      return unless $('.pagination a[rel=next]').length
      url = $('.pagination a[rel=next]').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 100
        $.getScript url, ->
          window.paginating = false
          loader.stop()
        window.paginating = true
        loader.start()
    $(window).scroll()