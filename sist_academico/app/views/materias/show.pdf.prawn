pdf.text "Colegio Monseñor Wiesen", :size => 20, :style => :bold, :align => :center
pdf.text "Misiones e/ Cristophersen. Ciudad de Fram-Itapúa-Paraguay.", :size => 11, :style => :italic, :align => :center
pdf.text "Teléfono/Fax: 0761265221. Email: cmjw.fram@gmail.com", :size => 11, :style => :italic, :align => :center
pdf.move_down(10) 
pdf.text "Listado de Tareas", :size => 15, :style => :bold 
pdf.text "Curso: #{@materia.curso.curso_grado}", :size => 11, :style => :italic
pdf.move_down(20)
tareas = @materia.planificaciones.order("created_at desc")
items = [ ["<b>Tarea</b>", "<b>Etapa</b>", "<b>Fecha de Entrega</b>", "<b>Total de Puntos</b>", "<b>Descripcion</b>"]  ]
items += tareas.map do |item|  
  [  
        item.tarea,  
        item.etapa,
        item.fecha_entrega.to_s[5..10],
        item.total_puntos,
        item.descripcion
  ]  
end  

pdf.table(items, 
          :header => true, 
          :row_colors => ["F0F0F0", "FFFFCC"],
          :cell_style => { :inline_format => true, :font => "Times-Roman", :font_style => :italic })

pdf.move_down(10) 

cant_tarea = 0 
tareas.each do |tarea|
  if tarea.fecha_entrega >= Date.today 
    cant_tarea += 1
  end 
end

pdf.text "Tareas abiertas: #{cant_tarea}", :size => 12, :style => :bold 
pdf.text "Cantidad de Tareas: #{tareas.count}", :size => 12, :style => :bold 