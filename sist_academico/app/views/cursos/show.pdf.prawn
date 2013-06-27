pdf.text "Colegio Monseñor Wiesen", :size => 20, :style => :bold, :align => :center
pdf.text "Misiones e/ Cristophersen. Ciudad de Fram-Itapúa-Paraguay.", :size => 11, :style => :italic, :align => :center
pdf.text "Teléfono/Fax: 0761265221. Email: cmjw.fram@gmail.com", :size => 11, :style => :italic, :align => :center
pdf.move_down(10) 
pdf.text "Listado de Alumno", :size => 15, :style => :bold 
pdf.text "Curso: #{@curso.curso_grado}", :size => 11, :style => :italic
pdf.move_down(20)  
items = [ ["<b>Alumno</b>", "<b>Edad</b>", "<b>Telefono</b>", "<b>Responsable</b>", "<b>Fecha de Inscripcion</b>"]  ]
items += @curso.alumnos.map do |item|  
  [  
        item.full_name,  
        item.user_edad,
        item.user_telefono,
        item.responsable_full,
        item.user_created_at.strftime("%d/%m/%Y") 
  ]  
end  

pdf.table(items, 
          :header => true, 
          :row_colors => ["F0F0F0", "FFFFCC"],
          :cell_style => { :inline_format => true, :font => "Times-Roman", :font_style => :italic })

  
  
pdf.move_down(10) 
pdf.text "Cantidad de Alumnos en el Curso: #{@curso.alumnos.count}", :size => 12, :style => :bold 