Date of creation 06/May/2022.

This repository will contain the work from Camilo Valencia and Sara Jiménez for the course "Robótica 2022-1" in the Universidad Nacional de Colombia Sede Bogotá, continuing with "Taller 2"
# px_robot
Copia del repo px_robot modificado por Camilo Valencia y Sara Jiménez.
Contendrá los archivos necesarios para manejar el robot PhantomX PX100 nuevo del laboratorio, inlcuyendo archivos de configuración y modelos URDF.

# Laboratorio 2: Cinemática directa PhantomX ROS
## Sección 1: Modelo DH
### Medidas
Empleando como guía el artículo compartido (http://www.informit.com/blogs/blog.aspx?uk=The-10-Most-Important-Linux-Commands), comenzamos a explorar el uso del terminal en Linux, en este caso Ubuntu corriendo distintos comando en una variante del terminal instalada llamada Kitty:
1. `pwd`. Este comando sirve  para ver la ubicación donde nos encontramos ahora mismo en el sistema de archivos, tal como "/home/CamiloPC" o cualquier carpeta donde nos encontremos.
2. `ls`. Comando que nos permite ver el contenido en la ruta/carpeta actual o ruta que especifiquemos.
3. `cd`. Uno de los comandos más empleados. Permite moverse entre directorios/carpetas o a rutas que especifiquemos directamte. Se puede combinar con ".." para simplemente regresar al directorio anterior.
4. `touch`. Permite crear archivos, generalmente de texto, con el nombre que especifiquemos.
5. `rm`. Comando que elimina el archivo que deseemos de el directorio actual generalmente. Se puede combinar con más argumentos para eliminar directorios y otro tipo de archivos.
6. `mkdir`. Contrario al caso anterior, permite crear directorios/carpetas nuevas.
7. `rmdir`. Realiza la misma función de `rm` con argumentos adicionales para eliminar directorios directamente.
8. `mv`. Como se puede intuir, proviene del inglés "move" y permite mover archivos o directorios a la ubicación deseada.
9. `cp`. En lugar de mover archivos y/o directorios, los copia.
10. `man`. El comando más útil si se desea revisar información adicional de un comando, muestra el manual del comando que especifiquemos.
 
### Parámetros DH 
Aquí podemos ver el resultado de correr cada uno de estos comandos en orden:
![Screenshot from 2022-04-07 18-42-22](https://user-images.githubusercontent.com/55710287/162336786-a43e6b44-1382-4de6-82ef-d69f93cbb326.png)
Y el manual de usuario resultante al llamar `man rm`:
![Screenshot from 2022-04-07 18-42-11](https://user-images.githubusercontent.com/55710287/162336791-09f16a88-31df-419b-9d3d-1c5191302810.png)
### Diagama DH


## Sección 2: Python
### Materiales, metodología y Resultados
Explicación del programa

Control mediante script de Python: https://youtu.be/I8w1deoKF24

### Análisis:

Como se pudo observar, es posible tener un manejo completo de ROS desde Matlab, lo cual es muy útil a la hora de emplear cálculos complejos y automatizaciones que no son posibles en el terminal. La parte más compleja es el manejo de servicios, dado que difiere bastante de su forma en el terminal, pero desde luego es de gran utilidad para controlar la pose de la tortuga directamente. Respecto a los resultados obtenidos podemos decir que son satisfactorios: Se logró controlar la tortuga mediante el manejo de publicadores y velocidades, incluso combinando en este caso dos movimientos dirigidos por velocidades lineares y angulares, además de ser capaces de extraer la información de la pose en ciertos puntos con el uso de suscripciones a tópicos, en este caso al tópico de pose. Finalmente no hubo problemas en definir el servidor y cliente necesarios para el uso del servicio de teletransporte y emplear este para manipular de forma directa la pose de la tortuga, junto a la verificación de este cambio empleando la suscripción mencionada y el cierre del nodo maestro en Matlab para finalizar la práctica de esta sección.


## Sección 3: Toolbox

### Materiales, metodología y Resultados
Explicación del Código, función Link y Serial Link. Fotos del modelo en Matlab .plot


`       #configuración vel linal en x `
`        velocidad.linear.x=velLinear`
`        velocidad.linear.y=0`
`        velocidad.linear.z=0`
`        #Configuración vel angular` 
`        velocidad.angular.x=0`
`        velocidad.angular.y=0`
`        velocidad.angular.z=velAngular`

### Análisis:

Este ejercicio es muy interesante ya que permite no solo conocer cómo funcionan los topicos y los servicios, pero tambien permitió crear un script ejecutable que permite realizar estas funciones desde la consola solo presionando teclas. Una de las dificultades que encontré fue al momento de usar el nodo ya que desconocía que solo se puede crear un nodo por script, por lo que se pudo solucionar creandolo cómo una variable global.



## Sección 4: Conexión con Matlab

### Materiales, metodología y Resultados
Explicación del Código, función Link y Serial Link. Fotos del modelo en Matlab .plot


`       #configuración vel linal en x `
`        velocidad.linear.x=velLinear`
`        velocidad.linear.y=0`
`        velocidad.linear.z=0`
`        #Configuración vel angular` 
`        velocidad.angular.x=0`
`        velocidad.angular.y=0`
`        velocidad.angular.z=velAngular`

### Análisis:

Este ejercicio es muy interesante ya que permite no solo conocer cómo funcionan los topicos y los servicios, pero tambien permitió crear un script ejecutable que permite realizar estas funciones desde la consola solo presionando teclas. Una de las dificultades que encontré fue al momento de usar el nodo ya que desconocía que solo se puede crear un nodo por script, por lo que se pudo solucionar creandolo cómo una variable global.

## Sección 5: Matlab+Ros+Toolbox

### Materiales, metodología y Resultados
Explicación del Código, función Link y Serial Link. Fotos del modelo en Matlab .plot


`       #configuración vel linal en x `
`        velocidad.linear.x=velLinear`
`        velocidad.linear.y=0`
`        velocidad.linear.z=0`
`        #Configuración vel angular` 
`        velocidad.angular.x=0`
`        velocidad.angular.y=0`
`        velocidad.angular.z=velAngular`
Control mediante Matlab+ROS+Dynamixel+Rviz: https://youtu.be/3_T5Dx4dea4

### Análisis:

Este ejercicio es muy interesante ya que permite no solo conocer cómo funcionan los topicos y los servicios, pero tambien permitió crear un script ejecutable que permite realizar estas funciones desde la consola solo presionando teclas. Una de las dificultades que encontré fue al momento de usar el nodo ya que desconocía que solo se puede crear un nodo por script, por lo que se pudo solucionar creandolo cómo una variable global.

## Conclusiones:
- El terminal es una herramienta extremadamente útil para manejar el sistema de archivos, además de tener ciertas capacidades que no son posible de alcanzar mediante las alternativas con GUI.
- Matlab a su vez tiene una gran capacidad para automatizar procesos en ROS como la recolección de datos, realizar cálculos complejos, algoritmos de evasión de objetos y mucho más.
- Es posible obtener en Matlab toda la información que proporciona ROS en el terminal, de una manera más organizada al poder emplear todas las capcidades del software destinadas al manejo de datos.
- Se debe tener en cuenta el manejo de nodos, especialmente los maestro dentro de Matlab, pues no es posible correr más de una instancia del mismo, al igual que las relaciones de publicador/suscriptor entre ellos.
- Los servicios pueden resultar de gran utilidad para poder manipular parámetros que no serían accesibles de forma directa de otras maneras.
- Python es una excelente herramienta para manejar la interfaz humano máquina, además de todas las ventajas que nos ofrece este lenguaje como librerías, estructuras de datos, etc.
- Además permite ejectuar complejas rutinas de manera sencila en un solo comando del terminal con ROS configurado.