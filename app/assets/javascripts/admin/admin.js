// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery_ujs
//= require jquery.ui.autocomplete
//= require jquery.ui.sortable
//= require jquery.jcrop
//= require admin/pixel-admin
//= require admin/events
//= require admin/respond.min
//= require admin/utils
//= require admin/pixel-tasks
//= require admin/jquery.slimscroll
//= require admin/pixel-slimscroll
//= require papercrop
//= require admin/bootstrap
//= require admin/main-navbar
//= require admin/main-menu
//= require admin/switcher.js
//= require admin/fastclick
//= require admin/jquery.searchable
//= require admin/jquery.timer
//= require admin/jquery.ui.touch-punch
//= require admin/jquery.tokeninput
//= require admin/file-input
//= require admin/froala-editor.min.js
//= require admin/jquery.bind_with_delay
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require dataTables/extras/dataTables.responsive
//= require dataTables/extras/dataTables.tableTools
//= require admin/yt_player
//= require cocoon
//= require autonumeric
//= require admin/chat
//= require_self


var ready;
ready = function() {

  PixelAdmin.start(init);
};

$(document).ready(ready);
$(document).on('page:load', ready);


