config = Configuracion.first
if config.logo?
  pdf.image  Rails.root.to_s + "/public/" + config.logo_url(:thumb), :align => :center, :at => [30,730], :width => 60, :height => 60
end
pdf.text config.nombre, :size => 20, :style => :bold, :align => :center
pdf.text config.direccion + " - " + config.ciudad + " - " + config.departamento + " - Paraguay", :size => 11, :style => :italic, :align => :center
pdf.text "Teléfono/Fax: "+ config.telefono + " - Email: " + config.email, :size => 11, :style => :italic, :align => :center
pdf.move_down(10) 

if @total
  @cursos = Curso.all
  pdf.text "Listado de Cursos", :size => 15, :style => :bold 
else
  pdf.text "Listado de Cursos #{Date.today.year}", :size => 15, :style => :bold 
end
pdf.text "Cantidad de Cursos: #{@cursos.size}", :size => 11, :style => :italic
pdf.move_down(20)  
items = [ ["<b>Cant</b>","<b>Curso</b>", "<b>Turno</b>", "<b>Nivel</b>", "<b>Enfasis</b>", "<b>Cantidad de Alumnos</b>"]  ]
items += @cursos.each_with_index.map do |item, i|  
  [  
        i+1,
        item.curso_grado,  
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

pdf.move_down(20)

pdf.text "Autor: #{current_user.full_name.inspect}", :size => 8, :align => :center
pdf.text "Fecha y Hora: #{Time.now}", :size => 8, :align => :center

pdf.page_count.times do |i|
  pdf.go_to_page(i+1)
  pdf.text "#{(i+1)}/#{pdf.page_count}", :size => 8, :align => :right
end