config = Configuracion.first
if config.logo?
  pdf.image  Rails.root.to_s + "/public/" + config.logo_url(:thumb), :align => :center, :at => [30,730], :width => 60, :height => 60
end
pdf.text config.nombre, :size => 20, :style => :bold, :align => :center
pdf.text config.direccion + " - " + config.ciudad + " - " + config.departamento + " - Paraguay", :size => 11, :style => :italic, :align => :center
pdf.text "Teléfono/Fax: "+ config.telefono + " - Email: " + config.email, :size => 11, :style => :italic, :align => :center
pdf.move_down(10) 

pdf.text "Boletin de Calificaciones", :size => 15, :style => :bold 
pdf.text "Fecha: #{Date.today.to_s.slice(0,10)}", :size => 11, :style => :italic
pdf.text "Alumno: #{@alumno.full_name}", :size => 11, :style => :italic
pdf.text "Curso: #{@alumno.curso_curso_grado}", :size => 11, :style => :italic
pdf.move_down(20)  

items = [ [<b>Materia</b>", "<b>Primera Etapa</b>", "<b>Segunda Etapa</b>", "<b>Tercera Etapa</b>", "<b>Complementario</b>", "<b>Extraordinario</b>"]  ]
items += @calificaciones_general 

pdf.table(items, 
          :header => true, 
          :row_colors => ["F0F0F0", "FFFFCC"],
          :cell_style => { :inline_format => true, :font => "Times-Roman", :font_style => :italic })

  
  
pdf.move_down(20)

pdf.text "Autor: #{current_user.full_name.inspect}", :size => 8, :align => :center
pdf.text "Fecha y Hora: #{Time.now}", :size => 8, :align => :center

pdf.page_count.times do |i|
  pdf.go_to_page(i+1)
  pdf.text "#{(i+1)}/#{pdf.page_count}", :size => 8, :align => :right
end 
