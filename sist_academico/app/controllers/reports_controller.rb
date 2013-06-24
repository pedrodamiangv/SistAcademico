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
      head_general_report  = [{:type=>"string",:label=> "Materia"},{:type=>"number",:label=> "Cantidad de " + range + " en el " + type}]
      hash = generate_hash range, type, 10, lower_limit, upper_limit
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
      chart1 = GoogleVisualr::Interactive::AreaChart.new(table, opts)
      return chart1
    end

end
