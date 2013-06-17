// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  //Ready for calendar
  $("#fecha").datepicker({
  	changeMonth: true,
  	changeYear: true,
  	onSelect: function(dateText, inst) {}
  });
  //ready for search in the table
  $("#kwd_search").keyup(function(){
    if( $(this).val() != "")
    {
      $("#my-table tbody>tr").hide();
      $("#my-table td:contains-ci('" + $(this).val() + "')").parent("tr").show();
    }
    else
    {
      $("#my-table tbody>tr").show();
    }
  });

  $.extend($.expr[":"], 
  {
      "contains-ci": function(elem, i, match, array) 
    {
      return (elem.textContent || elem.innerText || $(elem).text() || "").toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
    }
  });
  
});
    


function muestra_oculta(id){
  var el =document.getElementById(id);
  el.style.display = (el.style.display=='none') ? 'block' : 'none';
}

function edicion_planificacion(){
  $('#campos_edicion').show();
  $('#campos').hide();
}

function edicion_planificacion2(){
  $('#campos_edicion').hide();
  $('#campos').show();
}
