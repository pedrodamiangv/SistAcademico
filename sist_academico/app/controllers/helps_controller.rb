require 'custom_logger'

class HelpsController < ApplicationController
  
  def index
    @link = [
      "Como ingresar al Sistema?"
      "Como registrar un Alumno?",
      "Como registrar un Docente?",
      "Como registrar un Administrativo?",
      "Como registrar una Ciudad?",
      "Como registrar un Pais?",
      "Como registrar una Direccion?",
      "Como registrar una Materia?",
      "Como registrar un Curso?",
      "Como cargar una tarea (Practico, Examenes o Defensas)?",
      "Como subir un material de apoyo?",
      "Como registrar una calificacion?",
      "Como ver el perfil del Alumno/Administrativo/Docente?",
      "Como ver el log de Auditoria?",
      "Como ver los reportes del sistema ?",
      "Como ver los informes .pdf e imprimir ?",
      "Como ver el historial de la institucion?",
      "Como encontrar a la institucion en las redes sociales?"
    ]
    @link_helps=[
      "Vaya al menu, luego click en la opcion de Sesion del lado derecho superior; completa los campos USUARIO y CONTRASENA y click en el boton entrar.",
      "Vaya al menu, Usuarios, Nuevo y click en Alumno. Aqui debes completar todos los campos del alumno, una vez completo haz click en el boton guardar, esto te redirecciona a la lista de alumnos donde puedes ver todos los alumnos con sus diferentes atributos. Para realizar dicha accion de registrar debes ser un administrativo.",
      "Vaya al menu, Usuarios, Nuevo y click en Docente. Aqui debes completar todos los campos del docente, una vez completo haz click en el boton guardar, esto te redirecciona a la lista de docentes donde puedes ver todos los docentes con sus diferentes atributos. Para realizar dicha accion de registrar debes ser un administrativo.",
      "Vaya al menu, Usuarios, Nuevo y click en Administrativo. Aqui debes completar todos los campos del usuario administrativo, una vez completo haz click en el boton guardar, esto te redirecciona a la lista de los administrativos donde puedes ver todos los administrativos con sus diferentes atributos. Para realizar dicha accion de registrar debes ser un administrativo.",
      "Vaya al menu, Usuarios, Direccion y click en  Agregar Ciudad. Aqui debes completar todos los campos de la ciudad, una vez completo haz click en el boton guardar, esto te redirecciona a la lista de las ciudades con que ya se cuenta. Para realizar dicha accion de registrar debes ser un administrativo.",
      "Vaya al menu, Usuarios, Direccion y click en  Agregar Pais. Aqui debes completar todos los campos del pais, una vez completo haz click en el boton guardar, esto te redirecciona a la lista de los paises con que ya se cuenta. Para realizar dicha accion de registrar debes ser un administrativo.",
      "Vaya al menu, Usuarios, Direccion y click en  Agregar Direccion. Aqui debes completar todos los campos de direccion, una vez completo haz click en el boton guardar, esto te redirecciona a la lista de las direcciones con que ya se cuenta. Para realizar dicha accion de registrar debes ser un administrativo.",
      "Vaya al menu, Materias y click en Registrar Nueva Materia. Aqui debes completar todos los campos de materia, una vez completo haz click en el boton guardar, esto te redirecciona en la lista de materias con que ya se cuenta. Para realizar dicha accion de registrar debes de ser un administrativo",
      "Vaya al menu, Cursos y click en Registrar Nuevo Curso. Aqui debes completar todos los campos de curso, una vez completo haz click en el boton guardar, esto te redirecciona en la lista de cursos con que ya se cuenta. Para realizar dicha accion de registrar debes de ser un administrativo",
      "Para cargar una tarea respecto a una materia, debes ir hasta el menu Materias y click en Listar Materias. Una vez que estas en la lista de materias, puedes hacer clik en el nombre de la materia, esto te redirecciona a una nueva pagina donde encuentras una opcion en el lado izquierdo Nueva Tarea, haz click alli y te aparece un formulario a rellenar, completa todos los campos y haz click en el boton guardar, y alli puedes observar la tarea que has cargado en la tabla que se encuentra en la misma pagina. Para realizar dicha accion debes ser un administrativo o docente",
      "Para poder subir un material respecto a una materia, debes ir hasta el menu Materias y click en Listar Materias. Una vez que estas en la lista de materias, puedes hacer clik en el nombre de la materia, esto te redirecciona a una nueva pagina donde encuentras una opcion en el lado izquierdo Subir Material de Estudio, haz click alli y te aparece una ventana donde al hacer click en Subir Archivo te muestra la ventana para cargar el material que deseas, una vez seleccionado haz click en guardar. Y alli ya puedes ver en la misma pagina del lado derecho superior el material que has subido con su respectivo nombre. Para realizar dicha accion debes ser un administrativo o docente",
      "Para registrar una calificacion respecto a una materia, debes ir hasta el menu Materias y click en Listar Materias. Una vez que estas en la lista de materias, puedes hacer clik en el nombre de la materia, esto te redirecciona a una nueva pagina donde encuentras una opcion en el lado izquierdo Cargar Calificaciones, haz click alli y esto te redirecciona a una nueva pagina con los datos de la materia y la lista de alumnos que llevan esa materia, alli puedes rellenar todos los campos necesarios, en este caso las calificaciones obtenidas por los alumnos y haz click en el boton guardar. Para realizar dicha accion debes ser un administrativo o docente",
      "Para poder ver el perfil del alumno, vaya al menu cuenta, y haz click en Perfil. Esto te muestra el perfil del usuario logueado con todos sus datos que puede ser un alumno, docente y/o administrativo, ademas de ver tu perfil puedes editar algunos campos haciendo click en la opcion Editar que se encuentra en el lado izquierdo especificamente debajo del nombre del usuario logueado.",
      "Para poder ver el log de auditoria, vaya al menu Reportes y haz click en auditoria, alli puedes ver una tabla donde puedes ver todas las acciones realizadas por el usuario logueado. Para poder tener acceso a auditoria debes de ser un administrativo.",
      "Para poder ver los reportes, vaya al menu Reportes y haz click en las opciones que deseas(Calificaciones, Alumnos, etc). Esto te llevara a ver el reporte de la opcion seleccionada. Para poder realizar dicha accion debes de ser un administrativo.",
      "Para poder ver los informes de extension .pdf del sistema y poder imprimirlos, ya sea de Alumnos, Docentes, Administrativos; debes de encontrarte en los listados del que deseas, y alli puedes ver un link donde te dice Ver Lista como pdf y esto te abre una pagina con la lista que deseas en el formato mencionado. Alli puedes guardar dicho documento, o tambien puedes imprimirlo, haciendo click derecho y seleccionas la opcion imprimir. Para realizar dicha accion debes ser un usuario del sistema.",
      "Para poder ver el historial de la institucion, y conocer un poco mas de ella, debes encontrarte en la pagina principal del sistema sin necesidad de loguearte, haz click en uno de los items con imagenes y puedes seleccionar el de historial.",
      "Para poder conectarse a traves del facebook o twitter a la institucion, debes encontrarte en la pagina principal del sistema sin necesidad de loguearte, y haz click en uno de los items con imagenes, segun lo seleccionado esto te redirecciona directamente a la pagina de las redes sociales seleccionada por usted.",
    ]
  end
  
end


