
$("#time-sheet-list").html("<%= escape_javascript( render(:partial => "list") ) %>");
$("#timeclock").html("<%= escape_javascript( render(:partial => "timeclock") ) %>");