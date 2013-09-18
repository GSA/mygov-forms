
// Tooltips
if (myUsaFormTooltips && myUsaFormTooltips.length > 0 ) {
  myUsaFormTooltips.map( function(tooltip) {
    var tipElement = "#data_" + tooltip;
    $(tipElement).tooltip({trigger:'focus', placement: 'right', container: 'body', html: true});
  });
};