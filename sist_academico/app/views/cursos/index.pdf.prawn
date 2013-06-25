pdf.text "Colegio Monseñor Wiesen", :size => 20, :style => :bold, :align => :center
pdf.text "Misiones e/ Cristophersen. Ciudad de Fram-Itapúa-Paraguay.", :size => 11, :style => :italic, :align => :center
pdf.text "Teléfono/Fax: 0761265221. Email: cmjw.fram@gmail.com", :size => 11, :style => :italic, :align => :center
pdf.move_down(10) 
pdf.text "Listado de Cursos #{Date.today.year}", :size => 15, :style => :bold 
pdf.text "Cantidad de Cursos: #{@cursos.count}", :size => 11, :style => :italic
pdf.move_down(20)  
items = [ ["<b>Curso</b>", "<b>Turno</b>", "<b>Nivel</b>", "<b>Enfasis</b>", "<b>Cantidad de Alumnos</b>"]  ]
items += @cursos.map do |item|  
  [  
        item.curso,  
        item.turno,
        item.nivel,
        item.enfasis,
        item.alumnos.count 
  ]  
end  

pdf.table(items, 
          :header => true, 
          :row_colors => ["F0F0F0", "FFFFCC"],
          :cell_style => { :inline_format => true, :font => "Times-Roman", :font_style => :italic })

  
  
pdf.move_down(10) 
cant_alumnos = 0
@cursos.each do |curso|
  cant_alumnos += curso.alumnos.count
end 
pdf.text "Cantidad de Alumnos en el Colegio: #{cant_alumnos}", :size => 12, :style => :bold 