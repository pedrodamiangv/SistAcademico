pdf.page_count.times do |i|
  pdf.go_to_page(i+1)
  pdf.text "Pagina #{(i+1)} de #{pdf.page_count}", :size => 8
end

pdf.text "Colegio Monseñor Wiesen", :size => 20, :style => :bold, :align => :center
pdf.text "Misiones e/ Cristophersen. Ciudad de Fram-Itapúa-Paraguay.", :size => 11, :style => :italic, :align => :center
pdf.text "Teléfono/Fax: 0761265221. Email: cmjw.fram@gmail.com", :size => 11, :style => :italic, :align => :center
pdf.move_down(10) 
if @total
  @alumnos = Alumno.all
  pdf.text "Listado de Alumnos", :size => 15, :style => :bold 
else
  pdf.text "Listado de Alumnos #{Date.today.year}", :size => 15, :style => :bold 
end
pdf.text "Cantidad de alumnos: #{@alumnos.size}", :size => 11, :style => :italic
pdf.move_down(20)  
items = [ ["<b>Cant</b>","<b>Alumno</b>", "<b>CINro</b>", "<b>Curso</b>", "<b>Responsable|Telefono</b>", "<b>Fecha de Registro</b>"]  ]

items += @alumnos.each_with_index.map do |item,i|  
  [  
        i+1,
        item.full_name,  
        item.user_CINro,
        item.curso_curso,
        item.responsable_full,
        item.created_at.to_s.slice(0,10)
  ]  
end 

pdf.table(items, 
          :header => true, 
          :row_colors => ["F0F0F0", "FFFFCC"],
          :cell_style => { :inline_format => true, :font => "Times-Roman", :font_style => :italic })
 
pdf.move_down(20)

pdf.text "Autor: #{current_user.full_name.inspect}", :size => 8, :align => :center
pdf.text "Fecha y Hora: #{Time.now}", :size => 8, :align => :center