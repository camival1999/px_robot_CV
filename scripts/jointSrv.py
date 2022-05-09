"""
Permite usar el servicio dynamixel_command. 
Esto emplea dicho servicio para enviar parámetros vistos en el Dynamixel Wizard al robot, como el torque_Limit, Goal_Position, etc.
"""
import rospy
import time
from dynamixel_workbench_msgs.srv import DynamixelCommand

__author__ = "F Gonzalez, S Realpe, JM Fajardo, Camilo Valencia"
__credits__ = ["Felipe Gonzalez", "Sebastian Realpe", "Jose Manuel Fajardo", "Robotis", "Editado por Camilo Valencia"]
__email__ = "fegonzalezro@unal.edu.co"
__status__ = "Final"

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

if __name__ == '__main__':
    try:
        # Goal_Position (0,1023)
        # Torque_Limit (0,1023)
        # Comando para mover junta. Parámetros: 'nada','ID''address que queremos editar','valor','delay
        #Ajusta torques, más que nada en el PX antiguo.
        jointCommand('', 1, 'Torque_Limit', 600, 0) #0-1024
        jointCommand('', 2, 'Torque_Limit', 500, 0)
        jointCommand('', 3, 'Torque_Limit', 400, 0)
        jointCommand('', 4, 'Torque_Limit', 400, 0)
        #Lleva a una posición incial todos los ángulos en 0°, estirado
        jointCommand('', 4, 'Goal_Position', 512, 0.5) #0-1024, de -150° a 150°
        jointCommand('', 3, 'Goal_Position', 512, 0.5)
        time.sleep(0.5)
        jointCommand('', 2, 'Goal_Position', 512, 0.5)
        time.sleep(0.5)
        jointCommand('', 1, 'Goal_Position', 512, 0.5)
        #Lleva a posición home, la típica
        jointCommand('', 4, 'Goal_Position', 750, 1)
        time.sleep(0.2)
        jointCommand('', 2, 'Goal_Position', 512, 1)
        time.sleep(0.5)
        jointCommand('', 3, 'Goal_Position', 240, 0.5)
        jointCommand('', 1, 'Goal_Position', 512, 0.5)
        
    except rospy.ROSInterruptException:
        pass