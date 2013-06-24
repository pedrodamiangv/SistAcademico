require "google_visualr"
class ReportsController < ApplicationController
  before_filter :require_login
  def index
  	@cursos = Curso.by_year(Date.today.year)
    @cursos << Curso.new(curso: "Colegio")
    @cant_alumnos = @cursos.first.alumnos.count
    data_table = generate_data_table "5", "Primer Curso"
    @chart = generate_graphic data_table, "Primer Curso", "Materia"
    @table = generate_table data_table

    
    if @table.data_table and @chart.data_table
      respond_to do |format|
        format.html 
        format.js
      end
    else
      respond_to do |format|
        format.html
        format.js { render 'change_report_with_error' }
      end
    end
  end

  def alumnos
    @cursos = Curso.by_year(Date.today.year)
    @cursos << Curso.new(curso: "Colegio")
    @cant_alumnos = @cursos.first.alumnos.count
    data_table = generate_data_table "Sexo", "Primer Curso"
    @chart = generate_graphic data_table, "Primer Curso", "Porcentaje"
    @table = generate_table data_table

    
    if @table.data_table and @chart.data_table
      respond_to do |format|
        format.html 
        format.js
      end
    else
      respond_to do |format|
        format.html
        format.js { render 'change_report_with_error' }
      end
    end
  end
      
  def change_data
    @type = params[:select_type]
    @range = params[:select_range]
    @cursos = Curso.by_year(Date.today.year)
    unless @type == "Colegio"
      @cant_alumnos = @cursos.detect{|w| w.curso == @type }.alumnos.count
    else
      i = 0
      @cursos.each do |curso|
        i += curso.alumnos.count
      end
      @cant_alumnos = i
    end
    data_table = generate_data_table @range, @type
    @chart = generate_graphic data_table, @type , "Materia"
    @table = generate_table data_table
    respond_to do |format|
      format.js { render 'change_report' }
    end
  end

  def consult_between
    @from = params[:from]
    @to = params[:to]
    @type = params[:select_type]
    @range = params[:select_range]
    data_table = generate_data_table(@range, @type, @from, @to)
    respond_to do |format|
      if data_table.rows.size > 0
        @chart = generate_graphic data_table, @type , "Materia"
        @table = generate_table data_table
        format.js { render 'change_report' }
      else
        format.js { render 'change_report_with_error'}
      end
    end
  end

  private

    def generate_hash range, type, limit, lower_limit, upper_limit
      hash = Hash.new
      calificaciones = Calificacion.where("calificacion = ?", range).order("created_at ASC").all
      calificaciones.each do |calificacion|
        materia = calificacion.materia
        unless type == "Colegio"
          if calificacion.created_at.between?(lower_limit,upper_limit) && materia.curso.curso == type
            key = materia.materia
            if hash.has_key?(key)
              hash[key]= hash[key]+1
            else
              hash[key]= 1
            end 
          end 
        else
          if calificacion.created_at.between?(lower_limit,upper_limit)
            key = materia.materia
            if hash.has_key?(key)
              hash[key]= hash[key]+1
            else
              hash[key]= 1
            end 
          end
        end
      end
      hash
    end

    def generate_hash_alumnos range, type, limit, lower_limit, upper_limit
      hash = Hash.new
      unless type == "Colegio"
        cursos = Curso.by_year(Date.today.year)
        curso = cursos.detect{|w| w.curso == type }
        if range == "Sexo"
          cant_mas = 0
          cant_fem = 0
          curso.alumnos.each do |alumno|
            key = alumno.user_sexo
            if key == "Masculino"
              cant_mas += 1
            else
              cant_fem += 1
            end 
          end
          unless  (cant_mas+cant_fem) == 0
            hash["Femenino"] = cant_fem*100/(cant_mas+cant_fem) 
            hash["Masculino"] = cant_mas*100/(cant_mas+cant_fem) 
          end
        else
          hash_edades = Hash.new
          total_alumnos = 0
          curso.alumnos.each do |alumno|
            key = alumno.user_edad
            total_alumnos += 1
            if hash_edades.has_key?(key)
              hash_edades[key]= hash_edades[key]+1
            else
              hash_edades[key]= 1
            end
          end
          hash_edades.each do|name,grade|
            hash[name.to_s] = grade*100/total_alumnos
          end
        end
      else
        cursos = Curso.by_year(Date.today.year)
        if range == "Sexo"
          cant_mas = 0
          cant_fem = 0
          cursos.each do |curso|
            curso.alumnos.each do |alumno|
              key = alumno.user_sexo
              if key == "Masculino"
                cant_mas += 1
              else
                cant_fem += 1
              end 
            end
          end 
          unless  (cant_mas+cant_fem) == 0
            hash["Femenino"] = cant_fem*100/(cant_mas+cant_fem) 
            hash["Masculino"] = cant_mas*100/(cant_mas+cant_fem) 
          end
        else
          hash_edades = Hash.new
          total_alumnos = 0
          cursos.each do |curso|
            curso.alumnos.each do |alumno|
              key = alumno.user_edad
              total_alumnos += 1
              if hash_edades.has_key?(key)
                hash_edades[key]= hash_edades[key]+1
              else
                hash_edades[key]= 1
              end
            end
          end
          hash_edades.each do|name,grade|
            hash[name.to_s] = grade*100/total_alumnos
          end
        end
      end
      hash
    end

    def obtain_key object, range, limit
      key = ""
      if range     == "dia"
        key = object.created_at.to_s.slice(0,limit)
      elsif range  == "ano"
        key = object.created_at.to_s.slice(0,limit)
      else
        key = Date::MONTHNAMES[object.created_at.month]
      end
      key
    end

    def generate_data_table(range, type, param1="2013-01-01", param2="2013-12-31")
      lower_limit   = Date.parse(param1)
      upper_limit   = Date.parse(param2)
      unless range == "Sexo"  || range == "Edad"
        head_general_report  = [{:type=>"string",:label=> "Materia"},{:type=>"number",:label=> "Cantidad de " + range + " en el " + type}]
        hash = generate_hash range, type, 10, lower_limit, upper_limit
      else
        head_general_report  = [{:type=>"string",:label=> range},{:type=>"number",:label=> "Porcentaje en el " + type}]
        hash = generate_hash_alumnos range, type, 10, lower_limit, upper_limit
      end
      data_table = GoogleVisualr::DataTable.new
      data_table.cols= head_general_report
      data_table.add_rows hash.to_a
      data_table
    end

    def generate_table table
      opts   = { :width => 400, :showRowNumber => true }
      chart1 = GoogleVisualr::Interactive::Table.new(table, opts)
      return chart1
    end

    def generate_graphic table, name, legend
      opts   = { width: 500, height: 500, title: name, hAxis: {title: legend, titleTextStyle: {color: '#FF0000'}} }
      chart1 = GoogleVisualr::Interactive::ColumnChart.new(table, opts)
      return chart1
    end

end
