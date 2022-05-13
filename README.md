Date of creation 06/May/2022.

This repository will contain the work from Camilo Valencia and Sara Jiménez for the course "Robótica 2022-1" in the Universidad Nacional de Colombia Sede Bogotá, continuing with "Taller 2"
# px_robot_CV
Copia del repo px_robot modificado por Camilo Valencia y Sara Jiménez.
Contendrá los archivos necesarios para manejar el robot PhantomX PX100 nuevo del laboratorio, inlcuyendo archivos de configuración, modelos URDF, scripts de Python y Matlab.

# Laboratorio 2: Cinemática directa PhantomX ROS
## Sección 1: Modelo DH

#### Materiales
- Robot PhantomX Pincher
    - 6 motores Dynamixel AX12
    - Fuente 12V
    - FTDI
    - HUB
- Calibrador pie de rey
### Medidas
Para definir el modelo y parámetros que vamos a emplear para el laboratorio necesitamos conocer sus dimensiones, especialmente aquellas entre las articulaciones dado que este modelo nuevo posee algunas diferencias respecto al anterior. A continuación se muestran las medidas tomadas en laboratorio con un calibrador y aquellas proporcionadas por el fabricante para verificarlas.
 
![Modelo](https://user-images.githubusercontent.com/55710287/168397177-2eed1805-2caf-475f-b450-df4d8117a0ef.png)
![Plano](https://user-images.githubusercontent.com/55710287/168397178-cae7e5ae-cf68-4c07-97bc-80931420fadb.png)

### Diagama y parámetros DH
Una vez definidas estas dimensiones procedemos a definir los marcos coordenados del diagrama DH std que vamos a emplear visto a continuación:

![DHModelo](https://user-images.githubusercontent.com/55710287/168397334-275399d6-47c8-4ac4-84b0-34400c2723b8.png)

Y una vez definidos estos marcos de referencia procedemos a generar la tabla de parámetros DHstd que es requerida por softwares como Matlab para obtener el modelo del robot virtual

| j  | a<sub>i</sub> | α<sub>i</sub>  | d<sub>i</sub> | θ<sub>i</sub>| Offset |
|----|---------------|----------------|---------------|--------------|--------|
| 1  | 0             | -π/2           | 47            | q<sub>1</sub>|   π    |
| 2  | 105.95        |    0           | 0             | q<sub>2</sub>| 1.5986π|
| 3  | 100           |    0           | 0             | q<sub>3</sub>| 0.4014π|
| 4  | 100           |    0           | 0             | q<sub>4</sub>|   0    |


Sin embargo para nuestro análisis decidimos trabajar con una postura de Home distinta, cuyo modelo DH y tabla de parámetros son los siguientes:

![DHHome](https://user-images.githubusercontent.com/55710287/168397356-89bdb070-9af9-451f-a3cb-817231a646c1.png)

| j  | a<sub>i</sub> | α<sub>i</sub>  | d<sub>i</sub> | θ<sub>i</sub>| Offset |
|----|---------------|----------------|---------------|--------------|--------|
| 1  | 0             | -π/2           | 47            | q<sub>1</sub>|   π    |
| 2  | 105.95        |    0           | 0             | q<sub>2</sub>|-0.4014π|
| 3  | 100           |    0           | 0             | q<sub>3</sub>|-0.0986π|
| 4  | 100           |    0           | 0             | q<sub>4</sub>|   0    |
    



## Sección 2: Python
#### Materiales:
Los materiales para esta sección del trabajo son:
- Robot PhantomX Pincher
    - 6 motores Dynamixel AX12
    - Fuente 12V
    - FTDI
    - HUB
- Computador
    - Ubuntu 20.04
    - Ros noetic
    - Dynamixel 



### Metodología y Resultados

Explicación del programa

Para realizar este programa, iniciamos definiendo las posiciones de home y destino, para luego realizar el programa de python que por medio de las teclas que el usuario presiones se cambie entre estas poses cada motor.

- Definición de poses: 
Por medio del Dynamixel con el robot conectado modificamos la cantidad de pasos del motor para encontrar las poses home y destino que queriamos. Además encontramos los valores que nosotros consideramos para los límites articulares, para así evitar que cualquier pose futura ocasionara un overload en los motores.

    | ID | Mín  | Máx  | Home | Destino |
    |----|------|------|------|---------|
    | 1  | 0    | 4095 | 2048 | 3073    |
    | 2  | 1100 | 3300 | 2048 | 2477    |
    | 3  | 1000 | 3333 | 3073 | 1925    |
    | 4  | 600  | 3333 | 2048 | 835     |
    | 5  | 1550 | 3600 | 3110 | 2180    |

     Ya con estos valores podemos pasar a desarrollar el código de phyton que incluye una matriz de 4 x 3 donde se encuentra la información del nombre de la articulación y los pasos para Home y Destino por aticulación.


- Script de python:
Este script tiene el trabajo de navegar entre articulaciones usando las teclas "w" y "s" y cambiando las posiciones entre home y destino con "a" y "s". Para esto realizamos las siguientes funciones:
    - ```jointCommand```: Esta función permite crear el servici'deentro del nodo del launch para comunicarse con el robot.
    - ```getkey```: Esta función permite detectar la tecla que ha sido presionada en el teclado y la retorna.
    - ```mov Art```: Esta función recibe la articulaciíon que se busca mover y los pasos que se requieren para la posición que deseamos.
    - ```selectPos```: Esta información toma la información de la articulación en la que se encuentra y la tacla presionada para así navegrar hacia adeltante y atras en las articulaciones, y finalmente haciendo uso de la función ```mov Art``` se envía la información de la poscición con la articulación para moverla, tomando los valores cómo los que fueron previamente definidos en una matriz. 
![Screenshot from 2022-05-13 14-12-37](https://user-images.githubusercontent.com/82957735/168400198-cc61e843-4e7a-4d8c-b74a-3c887d92c429.png)


    Finalmente pasamos al main que recibe la información de las taclas presionadas usando ```getkey``` luego con esta información según la tecla presionada se cambia de articulación  con "w" o "s" donde si se llega al wait y se presiona s se vuelve al wrist y viceversa. Todo esto se encuentra en un loop.

Para finalizar se pueden observar los resultados de nuestro control mediante  script de python, con el gemelo virtual en Rviz en el siguiente video: https://youtu.be/I8w1deoKF24


### Análisis:

Como se puede observar en el vídeo, Python nos permite generar scripts, lo cual es muy útil a la hora de comunicar por medio de un servicio en ros, además el amplo número de librerías de python permite detectar facilmente las teclas presionadas. Respecto a los resultados obtenidos podemos decir que son satisfactorios: Se logró controlar el PhantomX mediante el manejo de comandos dynamixel exitosamente, además por medio de las diferentes funciones se puede navegar entre las articulaciones sin problema para así en cada una seleccionar su posición.


## Sección 3: Toolbox
### Materiales
- Robot PhantomX Pincher
    - 6 motores Dynamixel AX12
    - Fuente 12V
    - FTDI
    - HUB
- Computador
    - Ubuntu 20.04
    - Matlab R2020b 
### Metodología y Resultados
Para el uso del toolbox de Peter Corke empleamos Matlab y la tabla de parámetros definida en el punto anterior en la pose de Home para obtener el siguiente código incluído en el script `PXrobot.m`:

![SerialLink](https://user-images.githubusercontent.com/55710287/168346238-dc6b90d1-89cf-44c6-ae46-f894365c79c2.png)

Este código nos permite definir una serie de articulaciones, las cuales luego son unidas con el comando SerialLink para conformar el modelo del robot y finalmente graficarlo según los ángulos definidos en el vector q1 con el siguiente código:

![Plot](https://user-images.githubusercontent.com/55710287/168346282-c9e6eb96-ed17-45b3-a575-05c41a36a02c.png)

Una vez definido el robot, podemos emplear funciones propias del toolbox para hallar las MTH entre eslabones y entre el TCP y la base como se ve a continuación:

![TCP](https://user-images.githubusercontent.com/55710287/168346334-81c85b0f-4995-4b90-96c2-0b0279fd2f0f.png)
![TCPMatrices](https://user-images.githubusercontent.com/55710287/168346353-01333af7-9931-46a7-a9a4-39219ca47d56.png)

Como detalle adicional le agregamos un ciclo anidado para recorrer la matriz resultante en busca de valores muy cercanos a 0 y reemplazarlos por exactamente 0 con el fin de limpiar y ordenar la MTH. Esto dado que el Toolbox tiene ciertos errores numéricos en decimales extremos, causando que resultados que  deberían ser 0, resulten en valores muy cercanos del orden de 10<sup>-17</sup> presentes en la matriz. 

Finalmente podemos graficar el robot en distintas poses asignando ángulos concretos a cada articulación como se explicó empleando la variable q1:

Pose Home [0 0 0 0]:
![posHome](https://user-images.githubusercontent.com/55710287/168346684-b176a5dd-7041-4174-9fd4-bedac5d4003e.png)

Pose 1 [1.5707 -0.7 0.2 0.9]:
![pos1](https://user-images.githubusercontent.com/55710287/168346647-1673e9fa-d02b-4266-ae96-f3be807f137e.png)

Pose 2 [-1.5707 1.2 0.4 -2]: 
![pos2](https://user-images.githubusercontent.com/55710287/168346712-f577c2b5-8c95-46ae-ad27-e56e319ac8cd.png)

### Análisis:

Como podemos ver, el modelo generado en Matlab es idéntico al PhantomX real cinemáticamente hablando, y con ello el Toolbox nos permite simular diferentes configuraciones sin tener riesgo alguno de causar alguna colisión o daño con el robot real y obtener de manera sencilla todas sus ecuaciones de cinemática, matrices y demás. Además vemos que si bien ambas matrices MTH resultantes son casi idénticas, no coinciden ciertos signos. Esto es debido a que en el cálculo manual de la matriz, no se tuvo en cuenta la rotación del marco base de 180° alrededor de Z, lo cual se arregla fácilmente premultiplicando la expresión por la MTH del eslabón 0 a base o mundo que fue obviada con el fin de mostrar que se debe tener cuidado a la hora de trabajar con distintos marcos de referencia, pues esto puede llevar a resultados completamente diferentes que pueden parecer iguales al no mirar detenidamente.
## Sección 4: Conexión con Matlab

### Materiales
- Robot PhantomX Pincher
    - 6 motores Dynamixel AX12
    - Fuente 12V
    - FTDI
    - HUB
- Computador
    - Ubuntu 20.04
    - Matlab R2020b 
    - Dynamixel
### Metodología y Resultados
En esta sección tratamos la conexión de Matlab con el robot PhantomX mediante el uso de tópicos, suscriptores y publicadores, nuevamente incluído en el script `PXrobot.m`.

Iniciamos conectando el nodo maestro de ROS en Matlab para poder comunicarnos con el robot. Tras ellos sencillamente definimos un suscriptor al tópico `/dynamixel_workbench/joint_states` el cual es el encargado de leer el estado de cada junta en el PhantomX y obtenemos esa información mediante el comando `receive()`.
El siguiente paso es definir un publicador a este mismo tópico para poder enviar la información del estado de las juntas que luego el PhantomX puede leer como es indicado en el gráfico de nodos RQT, teniendo en cuenta el formato del mensaje requerido 

![Topic](https://user-images.githubusercontent.com/55710287/168401123-c5e9252d-43a7-426e-886a-75ff1af21ddf.png)

![topicResults](https://user-images.githubusercontent.com/55710287/168401130-109f8c66-bb24-4ab4-b375-c8d54d1df254.png)

### Análisis:

Este ejercicio es muy interesante ya que nos permitió recordar el manejo de Tópicos y la existencia de distintos tipos de mensajes, pues el formato que requería el robot era bastante diferentesa quellos que necesitaba el Turtlebot por ejemplo. La mayor dificultad fue el manejo de Timestamps para asegurarnos que el robot recibiera los mensaajes de manera correcta al ignorar aquellos que eran muy "antiguos"

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
