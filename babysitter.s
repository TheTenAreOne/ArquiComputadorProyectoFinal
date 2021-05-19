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
mensajeRepetir: .asciiz "¿Desea repetir? [1]=Si" 

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
	add $t0, $0, $v0 #Guardamos hora de inicio de arrullo en t0

	li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeArrulloFinal #la = laod address
	syscall
	li $v0, 5
	syscall
	add $t1, $0, $v0 #Guardamos hora de final de arullo en t1
    #----------------------------------------------Pedir datos dormizion
	li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeMimirInicio #la = laod address
	syscall
	li $v0, 5
	syscall
	add $t2, $0, $v0 #Guardamos hora de inicio de dormir en t2

    li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeMimirFinal #la = laod address
	syscall
	li $v0, 5
	syscall
	add $t3, $0, $v0 #Guardamos hora de final de dormir en t3
    #----------------------------------------------Pedir datos diversion
	li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeDiversionInicio #la = laod address
	syscall
	li $v0, 5
	syscall
	add $t4, $0, $v0 #Guardamos hora de inicio de diversion en t4

	li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeDiversionFinal #la = laod address
	syscall
	li $v0, 5
	syscall
	add $t5, $0, $v0 #Guardamos hora de final de diversion en t5

    #Imprimir informacion ingresa
    #li $a0, 0
    #add $a0, $a0, $t0
    #li $v0, 1
    #syscall

    li $s0, 1

repetir:
    #Logica para repetir y pedir hora
    li $v0, 4 #Para imprimir en pantalla
    la $a0, mensajePedirHora
    syscall
    li $v0, 5
    syscall
    add $t6, $0, $v0 #Guardamos la hora en t6

    #Hora arrullo
    ble $t0, $t6, salirArrullo
    bge $t1, $t6, salirArrullo
    #Aqui se hace la logica de arrullo
salirArrullo: 
    
    #Hora de mimir
    ble $t2, $t6, salirMimir
    bge $t3, $t6, salirMimir
    #Aqui se hace la logica de mimir
salirMimir:

    #Hora de diversion
    ble $t4, $t6, salirDiversion
    bge $t5, $t6, salirDiversion
    #Aqui se hace la logica de diversion
salirDiversion:

    #Preguntamos si desean repetir
    li $v0, 4 #Para imprimir en pantalla
	la $a0, mensajeRepetir #la = laod address
	syscall
	li $v0, 5
	syscall
	add $a1, $0, $v0 #Guardamos en a1 el valor de repetir

    beq $a1, $s0, repetir



exit:
	li $v0, 10 #system call code for exit
	syscall
	.end