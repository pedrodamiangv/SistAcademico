pdf.text "Colegio Monseñor Wiesen", :size => 20, :style => :bold, :align => :center
pdf.text "Misiones e/ Cristophersen. Ciudad de Fram-Itapúa-Paraguay.", :size => 11, :style => :italic, :align => :center
pdf.text "Teléfono/Fax: 0761265221. Email: cmjw.fram@gmail.com", :size => 11, :style => :italic, :align => :center
pdf.move_down(10) 
pdf.text "Boletin de Calificaciones", :size => 15, :style => :bold 
pdf.text "Fecha: #{Date.today.to_s.slice(0,10)}", :size => 11, :style => :italic
pdf.text "Alumno: #{@alumno.full_name}", :size => 11, :style => :italic
pdf.text "Curso: #{@alumno.curso_curso_grado}", :size => 11, :style => :italic
pdf.move_down(20)  

items = [ ["<b>Materia</b>", "<b>Primera Etapa</b>", "<b>Segunda Etapa</b>", "<b>Tercera Etapa</b>"]  ]
items += @calificaciones_general 

pdf.table(items, 
          :header => true, 
          :row_colors => ["F0F0F0", "FFFFCC"],
          :cell_style => { :inline_format => true, :font => "Times-Roman", :font_style => :italic })

  
  
pdf.move_down(10)  