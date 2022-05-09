import termios, sys, os
import rospy
from geometry_msgs.msg import Twist

from turtlesim.srv import TeleportAbsolute, TeleportRelative
from numpy import pi

import sys #para uar la linea de comandos
TERMIOS = termios
import time
from dynamixel_workbench_msgs.srv import DynamixelCommand


#rospy.init_node('miNodoSeLlamaAsi', anonymous=True)#creo el nodo para este programa de python
#ahora las funciones del nodo un publisher y un servicio proxy
#servi=rospy.ServiceProxy('/turtle1/teleport_absolute',TeleportAbsolute)#creo el proxy para el servicio el tipo es TeleportAbsolute lo consegui con:rosservice type /turtle1/teleport_relative 
#pub=rospy.Publisher('/turtle1/cmd_vel', Twist, queue_size=10)#publicador con nombre /turtle1/cmd_vel con mensaje tipo twist y una rata de 10
#servi2=rospy.ServiceProxy('/turtle1/teleport_relative', TeleportRelative)

#Crea el servicio dentro del nodo que creo en el controller.launch
def jointCommand(command, id_num, addr_name, value, time):
    #rospy.init_node('joint_node', anonymous=False)
    rospy.wait_for_service('dynamixel_workbench/dynamixel_command')
    try:        
        dynamixel_command = rospy.ServiceProxy(
            '/dynamixel_workbench/dynamixel_command', DynamixelCommand)
        result = dynamixel_command(command,id_num,addr_name,value)
        rospy.sleep(time)
        return result.comm_result
    except rospy.ServiceException as exc:
        print(str(exc))

MPos = [["waist", "shoulder", "elbow", "wrist"], 
            [2048, 2048, 3073, 2048],
            [3073, 2477, 1925, 835]]

#Funcion para detectar la tecla regresa la tecla presionada 
def getkey():
    fd = sys.stdin.fileno()
    old = termios.tcgetattr(fd)
    new = termios.tcgetattr(fd)
    new[3] = new[3] & ~TERMIOS.ICANON & ~TERMIOS.ECHO
    new[6][TERMIOS.VMIN] = 1
    new[6][TERMIOS.VTIME] = 0
    termios.tcsetattr(fd, TERMIOS.TCSANOW, new)
    c = None
    try:
        c = os.read(fd, 1)
    finally:
        termios.tcsetattr(fd, TERMIOS.TCSAFLUSH, old)
    return c

def movArt(numArt, pos):
    jointCommand('', numArt, 'Goal_Position', pos, 0.5)

def selectPos(numArt,tecla2):
    if tecla2 == b'A' or tecla2 == b'a':
        pos=MPos[1][numArt-1]
        
    else:
        pos=MPos[2][numArt-1]
    print("la posición es: ", pos)
    movArt(numArt,pos)



if __name__ == '__main__':
    try:
        artSelec=1
        
        print('Se encuentra en la waist presione una W o S para adelantar o regresar y A o D para cambiar entre posiciones')
        
        while True:
            print("presione letra: ")
            letra=getkey()        
            print('\n')
            print('la tecla presioada fue: ')
            print(letra)
            prueba=b'y'
            if letra == prueba:
                print('esto es una y')

            #tecla=letra
            #Revisamos que letra fue seleccionada

            if letra == b'w' or letra == b'W':
                print("seleccionaste w")
                if artSelec < 4:
                    artSelec=artSelec+1
                else:
                    artSelec=1
                print("Estás en: ", MPos[0][artSelec-1])
                
            elif letra == b's' or letra == b'S':
                print("seleccionaste s")
                if artSelec > 1:
                    artSelec=artSelec-1
                else:
                    artSelec=4
                print("Estás en: ", MPos[0][artSelec-1])
            elif letra == b'A' or letra == b'D' or letra == b'a' or letra == b'd':
                print("seleccionaste A o D")
                selectPos(artSelec,letra)

            # Goal_Position (0,1023)
            # Torque_Limit (0,1023)
            # Comando para mover junta. Parámetros: 'nada','ID''address que queremos editar','valor','delay
            #Ajusta torques (Nosotros no porque el robot es nuevo), más que nada en el PX antiguo.
            #jointCommand('', 1, 'Torque_Limit', 600, 0) #0-1024
            #jointCommand('', 2, 'Torque_Limit', 500, 0)
            #jointCommand('', 3, 'Torque_Limit', 400, 0)
            #jointCommand('', 4, 'Torque_Limit', 400, 0)
            #Lleva a una posición incial todos los ángulos en 0°, estirado
            #jointCommand('', 1, 'Goal_Position', 2048, 1.0) #0-1024, de -150° a 150°
            #jointCommand('', 2, 'Goal_Position', 2048, 1.0)
            #time.sleep(0.5)
            #jointCommand('', 3, 'Goal_Position', 3073, 1.0)
            #time.sleep(0.5)
            #jointCommand('', 4, 'Goal_Position', 2048, 1.0)
            #jointCommand('', 5, 'Goal_Position', 3110, 1.0)
            #time.sleep(1.5)
            #Lleva a posición destino
            #jointCommand('', 1, 'Goal_Position', 3073, 1.0) #0-1024, de -150° a 150°
            #jointCommand('', 2, 'Goal_Position', 2477, 1.0)
            #time.sleep(0.5)
            #jointCommand('', 3, 'Goal_Position', 1925, 01.0)
            #time.sleep(0.5)
            #jointCommand('', 4, 'Goal_Position', 935, 1.0)
            #jointCommand('', 5, 'Goal_Position', 2180, 1.0)
            
    except rospy.ROSInterruptException:
        pass