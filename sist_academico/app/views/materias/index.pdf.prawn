pdf.text "Colegio Monseñor Wiesen", :size => 20, :style => :bold, :align => :center
pdf.text "Misiones e/ Cristophersen. Ciudad de Fram-Itapúa-Paraguay.", :size => 11, :style => :italic, :align => :center
pdf.text "Teléfono/Fax: 0761265221. Email: cmjw.fram@gmail.com", :size => 11, :style => :italic, :align => :center
pdf.move_down(10) 
if @total
  pdf.text "Listado de Materias", :size => 15, :style => :bold 
else
  pdf.text "Listado de Materias #{Date.today.year}", :size => 15, :style => :bold 
end
pdf.text "Cantidad de Materias: #{@materias.size}", :size => 11, :style => :italic
pdf.move_down(20)  
items = [ ["<b>Materia</b>", "<b>Area</b>", "<b>Curso</b>", "<b>Docente</b>"]  ]
items += @materias.map do |item|  
  [  
        item.materia,  
        item.area,
        item.curso_curso,
        item.docente.full_name 
  ]  
end  

pdf.table(items, 
          :header => true,         
          :row_colors => ["F0F0F0", "FFFFCC"],
          :cell_style => { :inline_format => true, :font => "Times-Roman", :font_style => :italic })
  
  
pdf.move_down(10) 

