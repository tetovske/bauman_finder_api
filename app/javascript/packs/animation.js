$(document).ready(function() {
    pageLoaded();
});

function pageLoaded() {
    setInterval(changeCursor, 500);
}

function changeCursor() {
    if ($('.main-page-subtitle').text().slice(-1) == '_') {
        oldText = $('.main-page-subtitle').text();
        $('.main-page-subtitle').text(`${oldText.substring(0, oldText.length - 1)}`);
    } else {
        oldText = $('.main-page-subtitle').text();
        $('.main-page-subtitle').text(`${oldText}_`);
    }
}