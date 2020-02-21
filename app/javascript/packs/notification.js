$(document).ready(function() {
    pageLoaded();
});

function pageLoaded() {
    $('.delete').click(function() {
        $(this).parent().remove();
    });
}