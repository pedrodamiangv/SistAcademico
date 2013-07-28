pdf.page_count.times do |i|
  pdf.go_to_page(i+1)
  pdf.text "Pagina #{(i+1)} de #{pdf.page_count}", :size => 8
end

pdf.text "Colegio Monseñor Wiesen", :size => 20, :style => :bold, :align => :center
pdf.text "Misiones e/ Cristophersen. Ciudad de Fram-Itapúa-Paraguay.", :size => 11, :style => :italic, :align => :center
pdf.text "Teléfono/Fax: 0761265221. Email: cmjw.fram@gmail.com", :size => 11, :style => :italic, :align => :center
pdf.move_down(10) 
@addresses = Address.all
if @total
  pdf.text "Listado de Direcciones", :size => 15, :style => :bold 
else
  pdf.text "Listado de Direcciones #{Date.today.year}", :size => 15, :style => :bold 
end
pdf.text "Cantidad de direcciones: #{@addresses.size}", :size => 11, :style => :italic
pdf.move_down(20)  
items = [ ["<b>Cant</b>","<b>Direccion</b>", "<b>Barrio</b>", "<b>Ciudad</b>", "<b>Pais</b>"]  ]
items += @addresses.each_with_index.map do |item, i|  
  [  
        i+1,
        item.direccion,  
        item.barrio,
        item.city_city,
        item.city.country_pais
  ]  
end 

pdf.table(items, 
          :header => true, 
          :row_colors => ["F0F0F0", "FFFFCC"],
          :cell_style => { :inline_format => true, :font => "Times-Roman", :font_style => :italic })

  
  
pdf.move_down(350)

pdf.text "Autor: #{current_user.full_name.inspect}", :size => 8, :align => :center
pdf.text "Fecha y Hora: #{Time.now}", :size => 8, :align => :center