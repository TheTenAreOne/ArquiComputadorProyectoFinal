#Proyecto Final Arquitectura del computador
#Integrantes: Daniel Caicedo y Nicole Molineros
#Semestre: 2021-1

#Con fines practicos estaremos trabajando con la hora militar
#La hora militar funciona desde las 0 hasta las 23 horas


    .data 0x10001000
horasConfig: .word 1, 8, 9, 11, 12, 16, 19, 23
horasCheck: .word 2, 2, 3
llantoFuerte: .word 1, 1, 1
llantoLeve: .word 1, 1, 1
#Mensajes -requerimientos
mensajeLlantoFuerte: .asciiz "bbdp"
mensajeAcomodarbb: .asciiz "FAdo"
mensajeMusica: .asciiz "FALA"
mensajeMuneco: .asciiz "PLAy"
mensajeMusicaArrullo: .asciiz "SOLd"

    .text
main:
    #----------------------------------------------Se cargan datos (horas)
	lui $t0, 0x1000
    ori $t0, $t0, 0x1000 

	#mimir
	lw $s0, 0($t0)
	lw $s1, 4($t0)

	#diversion
	lw $s2, 8($t0)
	lw $s3, 12($t0)

	lw $s4, 16($t0)
	lw $s5, 20($t0)

	#arrullo
	lw $s6, 24($t0)
	lw $s7, 28($t0)

#-------------------
	addi $t1, $0, 3 # <----- Cantidad de veces que se va a repetir
	addi $t2, $0, 0 # Contador

	#la $t0, horasCheck
    lui $t0, 0x1000
    ori $t0, $t0, 0x1020

	#la $t4, llantoFuerte
    lui $t4, 0x1000
    ori $t4, $t4, 0x102C

	#la $t5, llantoLeve
    lui $t5, 0x1000
    ori $t5, $t5, 0x1038
repetir:

	lw $t3, ($t0) # Que hora es
	

	#mimir
	#ble $t3, $s0, salirMimir
    slt $a0, $s0, $t3
    beq $a0, $0, salirMimir

	#bge $t3, $s1, salirMimir
    slt $a0, $t3, $s1
    beq $a0, $0, salirMimir

	lw $t8, ($t4) #Se carga el arreglo de llanto fuerte
	beq $t8, $0, salirLlantoFuerte
	addi $t7, $0, 777 #Para saber si llora fuerte (Se cambiaria por el mensaje)
salirLlantoFuerte:
	lw $t8, ($t5) #Se carga el arreglo de llanto leve
	beq $t8, $0, salirMimir
	add $t7, $0, 777 #Para saber si llora leve (Se cambiaria por el led)
salirMimir:

	#diversion
	#ble $t3, $s2, salirDiversion
    slt $a0, $s2, $t3
    beq $a0, $0, salirDiversion

	#bge $t3, $s3, salirDiversion
    slt $a0, $t3, $s3
    beq $a0, $0, salirDiversion

salirDiversion:

	#arrullo
	#ble $t3, $s4, salirArrullo
    slt $a0, $s4, $t3
    beq $a0, $0, salirArrullo

	#bge $t3, $s5, salirArrullo
    slt $a0, $t3, $s5
    beq $a0, $0, salirArrullo

	#ble $t3, $s6, salirArrullo
    slt $a0, $s6, $t3
    beq $a0, $0, salirArrullo

	#bge $t3, $s7, salirArrullo
    slt $a0, $t3, $s7
    beq $a0, $0, salirArrullo


salirArrullo:
	

	addi $t4, $t4, 4 #Aumenta en 4 la direccion de llantoFuerte
	addi $t5, $t5, 4 #Aumenta en 4 la direccion de llantoLeve

	addi $t0, $t0, 4 #Aumenta en 4 la direccion de horasCheck
	addi $t2, $t2, 1 # Aumento el contador
	bne $t2, $t1, repetir
exit:
	li $v0, 10 #system call code for exit
	syscall
	.end