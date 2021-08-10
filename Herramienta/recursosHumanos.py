import db
import string
import random
from datetime import datetime
conexion = db.conexion

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
        print(' registos en la tabla empleado')
    except Exception as e:
        print("Ocurrió un error al insertar en la tabla persona: ", e)
    finally:
        conexion.close()


def llenadoEmpleados(numero):
    try:
        with conexion.cursor() as cursor:
            consulta1 = "INSERT INTO P_Persona(IdPersona, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, Tipo) VALUES (?, ?, ?, ?, ?, ?);"
            consulta2 = """INSERT INTO RH_Empleado(IdPersona, TituloProfesional, FechaDeCumpleanios, EstadoCivil, Sexo, FechaDeContratacion, HorasDeVacaciones, HorasPorEnfermedad, Estado)
                VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)"""
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
                fechaDeCumpleanios = FechaCumpleaños()
                estadoCivil = random.choice(['Soltero(a)', 'Casado(a)', 'Union Libre', 'Divorciado(a)', 'Viudo(a)'])
                sexo = random.choice(['F','H'])
                fechaDeContratacion =  FechaDeContratacion()
                horasDeVacaciones = random.randint(0, 40)
                horasPorEnfermedad = random.randint(0, 20)
                Estado = random.choice(['Activo', 'En Vacaciones', 'Enfermo'])
                cursor.execute(consulta2, (IdPersona, tituloProfesional, fechaDeCumpleanios, estadoCivil, sexo, fechaDeContratacion, horasDeVacaciones, horasPorEnfermedad, Estado))

        print('Se han insertado ')
        print(numero)
        print(' registos en la tabla empleado')

    except Exception as e:
        print("Ocurrió un error al insertar en la tabla persona: ", e)
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



llenadoEmpleados(10)