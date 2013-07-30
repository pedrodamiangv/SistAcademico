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
//= require bootstrap-modal
//= require calendar
//= require bootstrap-dropdown
//= require jquery-ui.min
//= require jsapi
//= require bootstrap-button
//= require jquery.corner
//= require simple_pagination
//= require_tree .
//= require rails.validations




function validarText(e,div) {
  txt = $(div).val();
  if (txt.length > 2){
    chart_one = txt.charAt(txt.length - 1);
    chart_two = txt.charAt(txt.length - 2);
    chart_three = txt.charAt(txt.length - 3);
    if (chart_one == chart_two && chart_two == chart_three){
      $(div).val(txt.substring(0, txt.length-1));
    }
  }
  return true;
}


function cerrar(){
  $("#error").hide();

}

function refresh(){
  location.reload(true);
}
function test(pageNumber)
{
  $('.selection').hide();
  for(var i=0; i<10; i++){
    var page=".page-"+(pageNumber+i);
    $(page).show();
  }
}

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
      $(".selection").show();
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

function validar(obj) {
  txt = obj.value;
  if ( txt != "" ) {
    if(parseInt(txt) != parseFloat(txt) || parseInt(txt) > 6) {
      alert('Solo debe ser número entero menor a 6');
      $(obj).val("");
      $('#guardar').attr("disabled", "disabled");
    } else {
      var total = 0;
      var correctos = 0;
      $('.calificacion').each(function(){
        total += 1;
        if ($(this).val() != "" ){
          correctos += 1;
        }
      });
      if( total == correctos ){
        $('#guardar').removeAttr("disabled");
      }
    }
  }
}

function validarNumero(obj){
  txt = obj.value;
  if (!/^([0-9])*$/.test(txt)){
    return false;
  } else {
    return true;
  }
}


function validarCedula(campo) {
    var RegExPattern = /^\d{1}\s?\d{3}\s?\d{3}$/;
    var RegExPattern2 = /^\d{3}\s?\d{3}$/;
    if ((campo.value.match(RegExPattern)) && (campo.value!='')) {
         
    } else if ((campo.value.match(RegExPattern2)) && (campo.value!='')){
      
    }else {
        alert('El Numero de cedula es incorrecto');
        campo.focus();
    } 
}

function change_data_by_select(path){
  $('#select_type').on('change', function(){
    var _type = $("#select_type").val();
    var range = $("#6").val();
    $.ajax({
      url: path,
      data: { "select_type": _type, "select_range": range },
      async: true,
      dataType: 'script'
     });
     return false;
  });
}

function change_data_by_tipo(path){
  $('#curso_tipo, #curso_curso').on('change', function(){
    var _type = $("#curso_tipo").val();
    var _curso = $("#curso_curso").val();
    var _id = $("#curso_id").val();
    $.ajax({
      url: path,
      data: { "tipo": _type, "curso": _curso, "id": _id },
      async: true,
      dataType: 'script'
     });
     return false;
  });
}

function aparecer_en_administrativo(alumno, docente){
  if (!alumno){
    $('#administrativo_user_attributes_is_docente').on('change', function(){
        muestra_oculta('campos_docente');
    });
  }
  if (!docente){
    $('#administrativo_user_attributes_is_alumno').on('change', function(){
        muestra_oculta('campos_alumno');
    });
  }
}

function aparecer_en_alumno(docente, administrativo){
  if (!docente){
    $('#alumno_user_attributes_is_docente').on('change', function(){
        muestra_oculta('campos_docente');
    });
  }
  if (!administrativo){
    $('#alumno_user_attributes_is_administrativo').on('change', function(){
        muestra_oculta('campos_administrativo');
    });
  }
}

function aparecer_en_docente(administrativo, alumno){
  if (!administrativo){
    $('#docente_user_attributes_is_administrativo').on('change', function(){
        muestra_oculta('campos_administrativo');
    });
  }
  if (!alumno){
    $('#docente_user_attributes_is_alumno').on('change', function(){
        muestra_oculta('campos_alumno');
    });
  }
}

function change_data_calificaciones(path){
  $('#x_ano').on('change', function(){
    var _type = $("#x_ano").val();
    $.ajax({
      url: path,
      data: { "ano": _type },
      async: true,
      dataType: 'script'
     });
     return false;
  });
}

function change_select_calificaciones(path){
  $('select#x_curso').on('change', function(){
    var _type = $("#x_ano").val();
    var _curso = $("#x_curso").val();
    $.ajax({
      url: path,
      data: { "ano": _type, "curso": _curso },
      async: true,
      dataType: 'script'
     });
     return false;
  });
}

function change_etapa_calificaciones(path){
  $('select#calificacion_etapa').on('change', function(){
    var _ano = $("#x_ano").val();
    var _curso = $("#x_curso").val();
    var _materia = $("#calificacion_materia_id").val();
    var _etapa = $("#calificacion_etapa").val();
    $.ajax({
      url: path,
      data: { "ano": _ano, "curso": _curso, "materia": _materia, "etapa": _etapa },
      async: true,
      dataType: 'script'
     });
     return false;
  });
}

function change_data_by_note(path){
  $('.btn').on('click', function(){
    $("#6").val($(this).val());
    $(this).button('toggle');
    var _type = $("#select_type").val();
    var range = $("#6").val();
    $.ajax({
      url: path,
      data: { "select_type": _type, "select_range": range },
      async: true,
      dataType: 'script'
     });
     return false;
  });
}

function change_data_by_filters(){
  $('#consult_between_link').on("click", function() {
    var _from = $("#from").val();
    var _to = $("#to").val();
     var _type = $("#select_type").val();
    var range = $("input[name='radio']:checked").attr('id');
    $.ajax({
    url: $(this).attr('ajax_path'),
    data: { "from": _from, "to": _to, "select_type": _type, "select_range": range },
    async: true,
    dataType: 'script'
    });
    return false;
  });
}

function rangeDate() {
    $("#from").datepicker({
      changeMonth: true,
      changeYear: true,
      onSelect: function(dateText, inst) {}
    });
    $("#to").datepicker({
      changeMonth: true,
      changeYear: true,
      onSelect: function(dateText, inst) {}
    });
  }
