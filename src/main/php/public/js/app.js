// Handle clickable rows
$(function() {
  $(".clickable-row, [data-link]").click(function() {
    window.document.location = $(this).data("href");
  });
});
