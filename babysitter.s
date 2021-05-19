#Proyecto Final Arquitectura del computador
#Integrantes: Daniel Caicedo y Nicole Molineros
#Semestre: 2021-1

#Con fines practicos estaremos trabajando con la hora militar
#La hora militar funciona desde las 0 hasta las 23 horas


    .data
#Mensajes para pedir datos
mensajeArrulloInicio: .asciiz "Ingrese la hora de inicio del arrullo: "
mensajeArrulloFinal: .asciiz "Ingrese la hora final del arrullo: "

mensajeMimirInicio: .asciiz "Ingrese la hora de inicio de la mimicion: "
mensajeMimirFinal: .asciiz "Ingrese la hora final de la dormicion: "

mensajeDiversionInicio: .asciiz "Ingrese la hora de inicio de la diversion: "
mensajeDiversionFinal: .asciiz "Ingrese la hora final de la diversion: "

mensajePedirHora: .asciiz "Hora: "


#Mensajes -requerimientos
mensajeLlantoFuerte: .asciiz "bbdp"
mensajeAcomodarbb: .asciiz "FAdo"
mensajeMusica: .asciiz "FALA"
mensajeMuneco: .asciiz "PLAy"
mensajeMusicaArrullo: .asciiz "SOLd"


#Las horas quedan guardadas de t0 a t5


    .text
main:
    #----------------------------------------------Pedir datos arrullo
	li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeArrulloInicio #la = laod address
	syscall
	li $v0, 5
	syscall
	add $t0, $0, $v0

	li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeArrulloFinal #la = laod address
	syscall
	li $v0, 5
	syscall
	add $t1, $0, $v0
    #----------------------------------------------Pedir datos dormizion
	li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeMimirInicio #la = laod address
	syscall
	li $v0, 5
	syscall
	add $t2, $0, $v0

    li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeMimirFinal #la = laod address
	syscall
	li $v0, 5
	syscall
	add $t3, $0, $v0
    #----------------------------------------------Pedir datos diversion
	li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeDiversionInicio #la = laod address
	syscall
	li $v0, 5
	syscall
	add $t4, $0, $v0

	li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeDiversionFinal #la = laod address
	syscall
	li $v0, 5
	syscall
	add $t5, $0, $v0

    #Imprimir informacion ingresa
    #li $a0, 0
    #add $a0, $a0, $t0
    #li $v0, 1
    #syscall


    #Logica para repetir y pedir hora
    addi $a1, 0 #En a1 tenemos la hora ingresada
    #beq $a1, 1, saleFor 
    li $v0, 4 #Para imprimir en pantalla
    la $a0, mensajePedirHora
    syscall
    li $v0, 5
    syscall
    add $t6, $0, $v0 #Guardamos la hora en t6

    #Hora arrullo
    ble $t0, $t6, 

exit:
	li $v0, 10 #system call code for exit
	syscall
	.end