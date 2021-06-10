#Proyecto Final Arquitectura del computador
#Integrantes: Daniel Caicedo y Nicole Molineros
#Semestre: 2021-1

#Con fines practicos estaremos trabajando con la hora militar
#La hora militar funciona desde las 0 hasta las 23 horas


    .data 0x10001000
				#  0  4  8  C   10  14  18  1C
horasConfig: .word 1, 8, 9, 11, 12, 16, 19, 23
				#20 24 28
horasCheck: .word 20, 9, 11
llantoFuerte: .word 1 #2C
llantoLeve: .word 1 #30
diversionMusica: .word 1 #34
diversionMovil: .word 1 #38
diversionJuegoLeds: .word 1 #3C
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

repetir:

	lw $t3, ($t0) # Que hora es
	

	#mimir
	#ble $t3, $s0, salirMimir
    slt $a0, $s0, $t3
    beq $a0, $0, salirMimir

	#bge $t3, $s1, salirMimir
    slt $a0, $t3, $s1
    beq $a0, $0, salirMimir


	#Aqui va la logica para mimir
	
	#--------------------------------
	#la $t4, llantoFuerte
    lui $t4, 0x1000
    ori $t4, $t4, 0x102C
	#--------------------------------

	lw $t8, ($t4) #Se carga el arreglo de llanto fuerte
	beq $t8, $0, salirLlantoFuerte

	#Salida a LED o 7Seg -------------------- bbdp <mensaje de llanto fuerte>
	addi $a1, $0, 1 # <1> es el codigo del mensaje
	lui $t7, 0x1000 #Se carga la direccion 0x10001200 a t7
	ori $t7, $t7, 0x1200
	sw $a1, 0($t7) #Se guarda a0 <1> en 0x10001200

salirLlantoFuerte:

	#--------------------------------
	#la $t4, llantoLeve
    lui $t4, 0x1000
    ori $t4, $t4, 0x1030
	#---------------------------------

	lw $t8, ($t4) #Se carga el arreglo de llanto leve
	beq $t8, $0, salirMimir

	#Salida a LED o 7Seg -------------------- Prender LED <accion de llanto leve>
	addi $a1, $0, 2 # <2> es el codigo del mensaje
	lui $t7, 0x1000 #Se carga la direccion 0x10001200 a t7
	ori $t7, $t7, 0x1200
	sw $a1, 0($t7) #Se guarda a0 <2> en 0x10001200

	#Aqui se acaba la logica para mimir
salirMimir:

	#diversion
	#ble $t3, $s2, salirDiversion
    slt $a0, $s2, $t3
    beq $a0, $0, segundoRangoDiversion

	#bge $t3, $s3, salirDiversion
    slt $a0, $t3, $s3
    bne $a0, $0, logicaDiversion
	
segundoRangoDiversion:
	#ble $t3, $s4, salirDiversion
    slt $a0, $s4, $t3
    beq $a0, $0, salirDiversion

	#bge $t3, $s5, salirDiversion
    slt $a0, $t3, $s5
    beq $a0, $0, salirDiversion

logicaDiversion:
	#Logica para diversion

	#--------------------------------
	#la $t4, diversionMusica
    lui $t4, 0x1000
    ori $t4, $t4, 0x1034
	#---------------------------------

	lw $t8, ($t4) #Se carga el arreglo de musica
	beq $t8, $0, salirMusica
	#Logica para musica


	#Salida a LED o 7Seg
	#Para diviersion se usa los siguientes tres espacios de memoria
	# 0x1204, 0x1208 y 0x120C
	addi $a1, $0, 1 # <1> es el codigo del mensaje
	lui $t7, 0x1000 #Se carga la direccion 0x10001204 a t7
	ori $t7, $t7, 0x1204
	sw $a1, 0($t7) #Se guarda a0 <1> en 0x10001204


salirMusica:
	#--------------------------------
	#la $t4, diversionMovil
    lui $t4, 0x1000
    ori $t4, $t4, 0x1038
	#---------------------------------

	lw $t8, ($t4) #Se carga el arreglo de movil
	beq $t8, $0, salirMovil
	#Logica para movil

	#Salida a LED o 7Seg
	#Para diviersion se usa los siguientes tres espacios de memoria
	# 0x1204, 0x1208 y 0x120C
	addi $a1, $0, 1 # <1> es el codigo del mensaje
	lui $t7, 0x1000 #Se carga la direccion 0x10001208 a t7
	ori $t7, $t7, 0x1208
	sw $a1, 0($t7) #Se guarda a0 <1> en 0x10001208


salirMovil:
	#--------------------------------
	#la $t4, diversionJuegoLeds
    lui $t4, 0x1000
    ori $t4, $t4, 0x103C
	#---------------------------------

	lw $t8, ($t4) #Se carga el arreglo de JuegoLeds
	beq $t8, $0, salirDiversion
	#Logica para juego leds

	#Salida a LED o 7Seg
	#Para diviersion se usa los siguientes tres espacios de memoria
	# 0x1204, 0x1208 y 0x120C
	addi $a1, $0, 1 # <1> es el codigo del mensaje
	lui $t7, 0x1000 #Se carga la direccion 0x1000120C a t7
	ori $t7, $t7, 0x120C
	sw $a1, 0($t7) #Se guarda a0 <1> en 0x1000120C
	
salirDiversion:

	#Arrullo
	#ble $t3, $s6, salirArrullo
    slt $a0, $s6, $t3
    beq $a0, $0, salirArrullo

	#bge $t3, $s7, salirArrullo
    slt $a0, $t3, $s7
    beq $a0, $0, salirArrullo

	#Logica para arrullo

	#--------------------------------
	#la $t4, llantoLeve
    lui $t4, 0x1000
    ori $t4, $t4, 0x1030
	#---------------------------------

	lw $t8, ($t4) #Se carga el arreglo de llanto leve
	beq $t8, $0, salirArrullo

	#Salida a LED o 7Seg -------------------- Prender musica <accion de llanto leve durante arrullo>
	addi $a1, $0, 2 # <2> es el codigo del mensaje
	lui $t7, 0x1000 #Se carga la direccion 0x10001204 a t7
	ori $t7, $t7, 0x1204
	sw $a1, 0($t7) #Se guarda a0 <2> en 0x10001204

salirArrullo:
	

	#addi $t4, $t4, 4 #Aumenta en 4 la direccion de llantoFuerte
	#addi $t5, $t5, 4 #Aumenta en 4 la direccion de llantoLeve

	addi $t0, $t0, 4 #Aumenta en 4 la direccion de horasCheck
	addi $t2, $t2, 1 # Aumento el contador
	bne $t2, $t1, repetir
exit:
	li $v0, 10 #system call code for exit
	syscall
	.end