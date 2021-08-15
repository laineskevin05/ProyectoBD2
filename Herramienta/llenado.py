import db
import string
import random
from datetime import datetime
conexion = db.conexion
#cursor = conexion.cursor()

def llenadoPersonas(numero):
    try:
        with conexion.cursor() as cursor:
            consulta = "INSERT INTO P_Persona(IdPersona, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, Tipo) VALUES (?, ?, ?, ?, ?, ?);"
            for i in range(numero):
                IdPersona = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(13))
                primerNombre = random.choice(listaNombres())
                segundoNombre = random.choice(listaNombres())
                primerApellido = random.choice(listaApellidos())
                segundoApellido = random.choice(listaApellidos())
                tipo = random.choice(['Cliente Natural','Cliente Juridico'])
                cursor.execute(consulta, (IdPersona, primerNombre, segundoNombre, primerApellido, segundoApellido, tipo))
        
        print('Se han insertado ')
        print(numero)
        print(' registos en la tabla Persona')
    except Exception as e:
        print("Ocurrió un error al insertar en la tabla persona: ", e)
    finally:
        conexion.close()


def llenadoEmpleados(numero):
    try:
        with conexion.cursor() as cursor:
            consulta1 = "INSERT INTO P_Persona(IdPersona, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, Tipo) VALUES (?, ?, ?, ?, ?, ?);"
            consulta2 = """INSERT INTO RH_Empleado(IdPersona, TituloProfesional, Cargo, FechaDeCumpleanios, EstadoCivil, Sexo, FechaDeContratacion, HorasDeVacaciones, HorasPorEnfermedad, Estado)
                VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"""
            for i in range(numero):
                ## Llenado de persona
                IdPersona = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(13))
                primerNombre = random.choice(listaNombres())
                segundoNombre = random.choice(listaNombres())
                primerApellido = random.choice(listaApellidos())
                segundoApellido = random.choice(listaApellidos())
                tipo = 'Empleado'
                cursor.execute(consulta1, (IdPersona, primerNombre, segundoNombre, primerApellido, segundoApellido, tipo))

                ## Llenado de empleado
                tituloProfesional = random.choice(listaTitulosProfesionales())
                Cargo = random.choice(['Mantenimiento', 'Ventas', 'Ventas', 'Cocina', 'Cocina','Seguridad','Marketing']) #Para que unos departamentos tengan mas probabilidad
                fechaDeCumpleanios = FechaCumpleaños()
                estadoCivil = random.choice(['Soltero(a)', 'Casado(a)', 'Union Libre', 'Divorciado(a)', 'Viudo(a)'])
                sexo = random.choice(['F','H'])
                fechaDeContratacion =  FechaDeContratacion()
                horasDeVacaciones = random.randint(0, 40)
                horasPorEnfermedad = random.randint(0, 20)
                Estado = random.choice(['Activo', 'En Vacaciones', 'Enfermo'])
                cursor.execute(consulta2, (IdPersona, tituloProfesional, Cargo, fechaDeCumpleanios, estadoCivil, sexo, fechaDeContratacion, horasDeVacaciones, horasPorEnfermedad, Estado))

        print('Se han insertado ')
        print(numero)
        print(' registos en la tabla empleado')

    except Exception as e:
        print("Ocurrió un error al insertar en la tabla Empleado: ", e)
    finally:
        conexion.close()

def llenadoHabitaciones(numero):
    try:
        with conexion.cursor() as cursor:
            consulta1 = "INSERT INTO A_Habitaciones(Numero, Piso, Precio, Categoria, Estado) VALUES (?, ?, ?, ?, ?);"
            
            #Para calcular el ultimo numero de habitacion
            cursor.execute("SELECT IdHabitacion, Numero FROM A_Habitaciones;")
            listaHabitaciones =  cursor.fetchall()
            listaHabitaciones.sort(reverse=True)
            if (listaHabitaciones != []):
                ultimoNumeroHabitacion = listaHabitaciones[0][1]
            else:
                ultimoNumeroHabitacion = 0
            
            for i in range(numero):

                ## Llenado de habitaciones
                ultimoNumeroHabitacion += 1
                piso = random.randint(1, 7)
                precio = random.randint(500, 5000)
                Categoria  = random.choice(['Una Cama','Dos Camas','Tres Cama', 'Cuatro Camas'])
                Estado = random.choice(['Disponible','En Uso'])

                ## Ejercucion de la consulta
                cursor.execute(consulta1, (ultimoNumeroHabitacion, piso, precio, Categoria, Estado))

        print('Se han insertado ')
        print(numero)
        print(' registos en la tabla habitaciones')

    except Exception as e:
        print("Ocurrió un error al insertar en la tabla Habitaciones: ", e)
    finally:
        conexion.close()


def llenadoProducto_E_Inventario(numero):
    try:
        with conexion.cursor() as cursor:
            consulta1 = "INSERT INTO A_Producto(Nombre, Precio_venta, Categoria) VALUES (?, ?, ?);"
            consulta2 = "INSERT INTO A_Inventario(IdProducto , Nombre , CantidadExistencia) VALUES(?, ?, ?)"
            
            categorias = ['Abarrotes','Enlatados', 'Lácteos', 'Botanas', 'Confitería',
                'Frutas y verduras', 'Bebidas', 'Bebidas alcohólicas', 'Alimentos preparados', 
                'Medicamentos OTC', 'Higiene personal', 'Uso doméstico', 'Productos de limpieza']

            for i in range(numero):

                ## Llenado de productos
                Nombre = random.choice(listaNombresDeProductos())
                Precio_venta = random.randint(10, 500)
                Categoria = random.choice(categorias)
                cursor.execute(consulta1, (Nombre, Precio_venta, Categoria))

                ## Llenado de inventario
                cursor.execute('SELECT @@identity AS id')
                IdProducto = cursor.fetchall()
                CantidadExistencia = random.randint(300, 800)
                cursor.execute(consulta2, (IdProducto[0][0], Nombre, CantidadExistencia))

        print('Se han insertado ')
        print(numero)
        print(' registos en la tabla Producto_E_Inventario')

    except Exception as e:
        print("Ocurrió un error al insertar en la tabla Producto_E_Inventario: ", e)
    finally:
        conexion.close()

def llenadoReservas_y_ListaReservas(numero):

    try:
        with conexion.cursor() as cursor:
            consulta1 = "INSERT INTO V_Reserva(IdPersona, IdEmpleado, Fecha_ingreso, Fecha_sale, NumeroDeHabitaciones, Estado) VALUES (?, ?, ?, ?, ?, ?);"
            consulta2 = "INSERT INTO V_ListaHabitacionesPorReserva(IdReserva, IdHabitacion) VALUES(?, ?)"
            cursor.execute("SELECT IdPersona FROM P_Persona WHERE Tipo != 'Empleado';")
            listaClientes = cursor.fetchall()
            cursor.execute("SELECT IdEmpleado FROM RH_Empleado;")
            listaEmpleados = cursor.fetchall()

            for i in range(numero):

                ## Llenado de Reservaciones
                
                cliente = random.choice(listaClientes)
                empleado = random.choice(listaEmpleados)
                dia = random.randint(1,23)
                mes = random.randint(1,11)
                fecha_ingreso = datetime(2020, mes, dia)
                fecha_sale = datetime(2020, mes, dia + random.randint(1, 4))
                numeroDeHabitaciones = random.randint(1, 4)
                estado = random.choice(['Activa', 'Activa', 'Activa','Cancelada'])
                cursor.execute(consulta1, (cliente[0], empleado[0], fecha_ingreso, fecha_sale, numeroDeHabitaciones, estado))

                ## Llenado de la tabla detalle listadeReservaciones

                cursor.execute('SELECT @@identity AS id')
                IdReserva = cursor.fetchall()
                    ## Obtener una lista de habitaciones para despues escoger una
                cursor.execute("SELECT IdHabitacion, Categoria FROM A_Habitaciones;")
                listaHabitacion = cursor.fetchall()

                for i in range(numeroDeHabitaciones):
                    habitacion = random.choice(listaHabitacion)
                    cursor.execute(consulta2, (IdReserva[0][0], habitacion[0]))
                
            print('Se han insertado ')
            print(numero)
            print(' registos en la tabla Reservaciones y ListaReservaciones')
    except Exception as e:
        print("Ocurrió un error al insertar en la tabla Reservaciones y ListaReservaciones: ", e)
    finally:
        conexion.close()

def llenadoConsumo(numero):
    try:
        with conexion.cursor() as cursor:
            consulta1 = "INSERT INTO V_Consumo(IdReserva, IdProducto, Cantidad, Precio_total, Fecha) VALUES (?, ?, ?, ?, ?);"
            
            #Para obtener una lista de reservaciones y de productos
            cursor.execute("SELECT IdReserva, Fecha_ingreso FROM V_Reserva;")
            listaReservaciones =  cursor.fetchall()

            cursor.execute("SELECT IdProducto, Precio_venta FROM A_Producto;")
            listaProductos = cursor.fetchall()

            for i in range(numero):

                ## Llenado de habitaciones
                reservacion = random.choice(listaReservaciones)
                for x in range(random.randint(1, 8)):
                    producto = random.choice(listaProductos)
                    cantidad = random.randint(1, 10)
                    precioTotal = cantidad * producto[1] #Este es el precio de cada producto por la cantidad
                    cursor.execute(consulta1, (reservacion[0], producto[0], cantidad, precioTotal, reservacion[1]))

        print('Se han insertado ')
        print(numero)
        print(' registos en la tabla Consumo')

    except Exception as e:
        print("Ocurrió un error al insertar en la tabla Consumo: ", e)
    finally:
        conexion.close()

def llenadoSolicitudes_y_Mantenimientos(numero):

    try:
        with conexion.cursor() as cursor:
            consulta1 = "INSERT INTO A_Solicitud_Mantenimiento(IdHabitacion, Fecha_Solicitud , TipoSolicitud, Descripcion, Estado) VALUES (?, ?, ?, ?, ?);"
            consulta2 = "INSERT INTO A_Mantenimiento(IdSolicitudMantenimiento, IdEmpleado, Fecha_Realizacion) VALUES(?, ?, ?)"

            cursor.execute("SELECT IdHabitacion FROM A_Habitaciones;")
            listaHabitaciones = cursor.fetchall()
            cursor.execute("SELECT IdEmpleado FROM RH_Empleado;")
            listaEmpleados = cursor.fetchall()

            for i in range(numero):

                ## Llenado de Reservaciones
                
                habitacion = random.choice(listaHabitaciones)
                
                dia = random.randint(1,23)
                mes = random.randint(1,11)
                fecha_Solicitud = datetime(2020, mes, dia)
                tipoSolicitud = random.choice(['Reparacion', 'Mantenimiento', 'Mejora', 'Limpieza'])
                descripcion = '----'
                estado = 'Realizado'
                cursor.execute(consulta1, (habitacion[0], fecha_Solicitud.isoformat(), tipoSolicitud, descripcion, estado))

                # Llenado de la tabla detalle listadeReservaciones
                ##Obtengo el ultimo Id insertado
                cursor.execute('SELECT @@identity AS id')
                IdSolicitudMantenimiento = cursor.fetchall()

                ## Obtener una lista de empleados para elegir uno que realice el mantenimiento
                empleado = random.choice(listaEmpleados)
                Fecha_Realizacion = datetime(2020, mes, dia + random.randint(0, 5))
            
                cursor.execute(consulta2, (IdSolicitudMantenimiento[0][0], empleado[0], Fecha_Realizacion.isoformat()))

            print('Se han insertado ')
            print(numero)
            print(' registos en la tabla Solicitudes y Mantenimientos')
    except Exception as e:
        print("Ocurrió un error al insertar en la tabla Solicitudes y Mantenimientos: ", e)
    finally:
        conexion.close()

def listaNombres():
    with  open('datos/nombres.txt', 'r', encoding="utf8") as tf:
        nombres = tf.read().split('\n') 
        tf.close()
    return nombres

def listaApellidos():
    with  open('datos/apellidos.txt', 'r', encoding="utf8") as tf:
        apellidos = tf.read().split('\n') 
        tf.close()
    return apellidos

def FechaCumpleaños():
    inicio = datetime(1980, 1, 1)
    final =  datetime(2001, 12, 28)
    random_date = inicio + (final - inicio) * random.random()
    return random_date

def listaTitulosProfesionales():
    with  open('datos/titulosProfesionales.txt', 'r', encoding="utf8") as tf:
        titulos = tf.read().split('\n') 
        tf.close()
    return titulos

def FechaDeContratacion():
    inicio = datetime(2015, 1, 1)
    final =  datetime(2020, 12, 28)
    random_date = inicio + (final - inicio) * random.random()
    return random_date

def listaNombresDeProductos():
    with  open('datos/nombresProductos', 'r', encoding="utf8") as tf:
        productos = tf.read().split('\n') 
        tf.close()
    return productos







llenadoPersonas(25)
#llenadoEmpleados(20)
#llenadoHabitaciones(30)
#llenadoProducto_E_Inventario(100)
#llenadoReservas_y_ListaReservas(70)
#llenadoConsumo(40)
#llenadoSolicitudes_y_Mantenimientos(40)