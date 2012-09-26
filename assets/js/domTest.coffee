
# Dynamically create an iframe, inject the html into it, then pass a jQuery object
# representing the DOM of the frame in the callback so the testing code can make 
# assertions. The test should invoke the done callback when finished so that the frame
# can be removed.

window.domTest = (html, asserts) ->
  # Write the html to a dynamic iframe
  frame = $('<iframe />').css('display','none').appendTo('body')
  doc = if frame[0].contentWindow? then frame[0].contentWindow else frame[0].contentDocument.document
  doc.document.open()
  doc.document.write(html)
  doc.close()

  dom = $(doc.document)
  asserts dom, ->
    frame.remove()