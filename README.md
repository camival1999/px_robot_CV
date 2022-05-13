Date of creation 06/May/2022.

This repository will contain the work from Camilo Valencia and Sara Jiménez for the course "Robótica 2022-1" in the Universidad Nacional de Colombia Sede Bogotá, continuing with "Taller 2"
# px_robot
Copia del repo px_robot modificado por Camilo Valencia y Sara Jiménez.
Contendrá los archivos necesarios para manejar el robot PhantomX PX100 nuevo del laboratorio, inlcuyendo archivos de configuración y modelos URDF.

# Laboratorio 2: Cinemática directa PhantomX ROS
## Sección 1: Modelo DH
### Medidas
Para definir el modelo y parámetros que vamos a emplear para el laboratorio necesitamos conocer sus dimensiones, especialmente aquellas entre las articulaciones dado que este modelo nuevo posee algunas diferencias respecto al anterior. A continuación se muestran las medidas tomadas en laboratorio con un calibrador y aquellas proporcionadas por el fabricante para verificarlas.
 
inserte fotos de las medidas en la tablet y el plano del fabricante en favoritos

### Diagama DH
Una vez definidas estas dimensiones procedemos a definir los marcos coordenados del diagrama DH std que vamos a emplear visto a continuación:

inserte foto del diagrama DH
### Parámetros DH 
Una vez definidos estos marcos de referencia procedemos a generar la tabla de parámetros que requieren softwares como Matlab para obtener el modelo del robot virtual

insertar tabla de parámetros DH

#### Materiales:
    -Robot PhantomX Pincher
        -6 motores Dynamixel AX12
        -Fuente 12V
        -FTDI
        -HUB
    -Computador
        -Ubuntu 20.04
        -Ros noetic
        -Dynamixel 
        -Matlab 2020b
            -Toolbox Peter Corke 9.10
    -Calibrador pie de rey
    
## Sección 2: Python
#### Materiales:
    -Robot PhantomX Pincher
        -6 motores Dynamixel AX12
        -Fuente 12V
        -FTDI
        -HUB
    -Computador
        -Ubuntu 20.04
        -Ros noetic
        -Dynamixel 


### Materiales, metodología y Resultados
Explicación del programa

Para realizar este programa, iniciamos definiendo las posiciones de home y destino, para luego realizar el programa de python que por medio de las teclas que el usuario presiones se cambie entre estas poses cada motor.

-Definición de poses: 
Por medio del Dynamixel con el robot conectado encontramos los valores que nosotros consideramos para los límites articulares, para así evitar que cualquier pose futura ocasionara un overload en los motores 

| ID | Mín  | Máx  | Home | Destino |
|----|------|------|------|---------|
| 1  | 0    | 4095 | 2048 | 3073    |
| 2  | 1100 | 3300 | 2048 | 2477    |
| 3  | 1000 | 3333 | 3073 | 1925    |
| 4  | 600  | 3333 | 2048 | 835     |
| 5  | 1550 | 3600 | 3110 | 2180    |

Control mediante script de Python: https://youtu.be/I8w1deoKF24

### Análisis:

Como se puede observar en el vídeo, Python nos permite generar scripts, es posible tener un manejo completo de ROS desde Matlab, lo cual es muy útil a la hora de emplear cálculos complejos y automatizaciones que no son posibles en el terminal. La parte más compleja es el manejo de servicios, dado que difiere bastante de su forma en el terminal, pero desde luego es de gran utilidad para controlar la pose de la tortuga directamente. Respecto a los resultados obtenidos podemos decir que son satisfactorios: Se logró controlar la tortuga mediante el manejo de publicadores y velocidades, incluso combinando en este caso dos movimientos dirigidos por velocidades lineares y angulares, además de ser capaces de extraer la información de la pose en ciertos puntos con el uso de suscripciones a tópicos, en este caso al tópico de pose. Finalmente no hubo problemas en definir el servidor y cliente necesarios para el uso del servicio de teletransporte y emplear este para manipular de forma directa la pose de la tortuga, junto a la verificación de este cambio empleando la suscripción mencionada y el cierre del nodo maestro en Matlab para finalizar la práctica de esta sección.


## Sección 3: Toolbox

### Materiales, metodología y Resultados
Para el uso del toolbox de Peter Corke empleamos Matlab y la tabla de parámetros definida en el punto anterior para obtener el siguiente código:

![SerialLink](https://user-images.githubusercontent.com/55710287/168346238-dc6b90d1-89cf-44c6-ae46-f894365c79c2.png)

Este código nos permite definir una serie de articulaciones, las cuales luego son unidas con el comando SerialLink para conformar el modelo del robot y finalmente graficarlo según los ángulos definidos en el vector q1:

![Plot](https://user-images.githubusercontent.com/55710287/168346282-c9e6eb96-ed17-45b3-a575-05c41a36a02c.png)

Una vez definido el robot, podemos emplear funciones propias del toolbox para hallar las MTH entre eslabones y entre el TCP y la base como se ve a continuación:

![TCP](https://user-images.githubusercontent.com/55710287/168346334-81c85b0f-4995-4b90-96c2-0b0279fd2f0f.png)
![TCPMatrices](https://user-images.githubusercontent.com/55710287/168346353-01333af7-9931-46a7-a9a4-39219ca47d56.png)

Finalmente podemos graficar el robot en distintas poses asignando ángulos concretos a cada articulación como se explicó empleando la variable q1:

![posHome](https://user-images.githubusercontent.com/55710287/168346684-b176a5dd-7041-4174-9fd4-bedac5d4003e.png)
![pos1](https://user-images.githubusercontent.com/55710287/168346647-1673e9fa-d02b-4266-ae96-f3be807f137e.png)
![pos2](https://user-images.githubusercontent.com/55710287/168346712-f577c2b5-8c95-46ae-ad27-e56e319ac8cd.png)

### Análisis:

Como podemos ver, el modelo generado en Matlab es idéntico al PhantomX real cinemáticamente hablando, y con ello el Toolbox nos permite simular diferentes configuraciones sin tener riesgo alguno de causar alguna colision con el robot real. Sin embargo no se tienen en cuenta colisiones propias, es decir cuando se intersecta consigo mismo, entonces hay que tomar las gráficas teniendo en cuenta alguna posible interseccón propia.

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
