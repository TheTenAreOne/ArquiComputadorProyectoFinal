#Proyecto Final Arquitectura del computador
#Integrantes: Daniel Caicedo y Nicole Molineros
#Semestre: 2021-1

#Con fines practicos estaremos trabajando con la hora militar
#La hora militar funciona desde las 0 hasta las 23 horas


    .data 0x00000000
				#  0  1  2   3   4   5   6   7
horasConfig: .word 1, 8, 9, 11, 12, 16, 19, 23
				# 8   9   A
horasCheck: .word 20, 9, 11
llantoFuerte: .word 1 #B
llantoLeve: .word 1 #C
diversionMusica: .word 1 #D
diversionMovil: .word 1 #E
diversionJuegoLeds: .word 1 #F
#Mensajes -requerimientos
mensajeLlantoFuerte: .asciiz "bbdp"
mensajeAcomodarbb: .asciiz "FAdo"
mensajeMusica: .asciiz "FALA"
mensajeMuneco: .asciiz "PLAy"
mensajeMusicaArrullo: .asciiz "SOLd"

    .text
main:
    #----------------------------------------------Se cargan datos (horas)
	lui t0, 0x0000 #00111100000010000000000000000000
    ori t0, zero, 0x0000 #00110100000010000000000000000000 

	#mimir
	lw s0, 0x0000(t0) #10001101000100000000000000000000
	lw s1, 0x0001(t0)#10001101000100010000000000000001

	#diversion
	lw s2, 0x0002(t0) #10001101000100100000000000000010
	lw s3, 0x0003(t0) #10001101000100110000000000000011

	lw s4, 0x0004(t0) #10001101000101000000000000000100
	lw s5, 0x0005(t0) #10001101000101010000000000000101

	#arrullo
	lw s6, 0x0006(t0) #10001101000101100000000000000110
	lw s7, 0x0007(t0) #10001101000101110000000000000111

#-------------------
	addi t1, zero, 0x0003 # 00100000000010010000000000000011
	addi t2, zero, 0x0000 # 00100000000010100000000000000000

	#la t0, horasCheck
    lui t0, 0x0000 #00111100000010000000000000000000
    ori t0, t0, 0x0008 #00110101000010000000000000001000

repetir:

	lw t3, 0x0000(t0) #10001101000010110000000000000000
	

	#mimir
	#ble t3, s0, salirMimir
    slt a0, s0, t3 #00000010000010110010000000101010
    beq a0, 0, salirMimir

	#bge t3, s1, salirMimir
    slt a0, t3, s1 #00000001011100010010000000101010
    beq a0, 0, salirMimir


	#Aqui va la logica para mimir
	
	#--------------------------------
	#la t4, llantoFuerte
    lui t4, 0x0000 #00111100000011000000000000000000
    ori t4, t4, 0x000B #00110101100011000000000000001011
	#--------------------------------

	lw t8, 0x0000(t4) #10001101100110000000000000000000
	beq t8, 0, salirLlantoFuerte

	#Salida a LED o 7Seg -------------------- bbdp <mensaje de llanto fuerte>
	addi a1, zero, 0x0001 #00100000000001010000000000000001
	lui t7, 0x0000 #00111100000011110000000000000000
	ori t7, t7, 0x0200 #00110101111011110000001000000000
	sw a1, 0x0000(t7) #10101101111001010000000000000000

salirLlantoFuerte:

	#--------------------------------
	#la t4, llantoLeve
    lui t4, 0x0000 #00111100000011000000000000000000
    ori t4, t4, 0x000C #00110101100011000000000000001100
	#---------------------------------

	lw t8, 0x0000(t4) #10001101100110000000000000000000
	beq t8, 0, salirMimir

	#Salida a LED o 7Seg -------------------- Prender LED <accion de llanto leve>
	addi a1, zero, 0x0002 #00100000000001010000000000000010
	lui t7, 0x0000 #00111100000011110000000000000000
	ori t7, t7, 0x0200 #00110101111011110000001000000000
	sw a1, 0x0000(t7) #10101101111001010000000000000000

	#Aqui se acaba la logica para mimir
salirMimir:

	#diversion
	#ble t3, s2, salirDiversion
    slt a0, s2, t3 #00000010010010110010000000101010
    beq a0, 0, segundoRangoDiversion

	#bge t3, s3, salirDiversion
    slt a0, t3, s3 #00000001011100110010000000101010
    bne a0, 0, logicaDiversion
	
segundoRangoDiversion:
	#ble t3, s4, salirDiversion
    slt a0, s4, t3 #00000010100010110010000000101010
    beq a0, 0, salirDiversion

	#bge t3, s5, salirDiversion
    slt a0, t3, s5 #00000001011101010010000000101010
    beq a0, 0, salirDiversion

logicaDiversion:
	#Logica para diversion

	#--------------------------------
	#la t4, diversionMusica
    lui t4, 0x0000 #00111100000011000000000000000000
    ori t4, t4, 0x000D #00110101100011000000000000001101
	#---------------------------------

	lw t8, 0x0000(t4) #10001101100110000000000000000000
	beq t8, 0, salirMusica
	#Logica para musica


	#Salida a LED o 7Seg
	#Para diviersion se usa los siguientes tres espacios de memoria
	# 0x1204, 0x1208 y 0x120C
	addi a1, zero, 0x0001 #00100000000001010000000000000001
	lui t7, 0x0000 #00111100000011110000000000000000
	ori t7, t7, 0x0201 #00110101111011110000001000000001
	sw a1, 0x0000(t7) #10101101111001010000000000000000


salirMusica:
	#--------------------------------
	#la t4, diversionMovil
    lui t4, 0x0000 #00111100000011000000000000000000
    ori t4, t4, 0x000E #00110101100011000000000000001110
	#---------------------------------

	lw t8, 0x0000(t4) #10001101100110000000000000000000
	beq t8, 0, salirMovil
	#Logica para movil

	#Salida a LED o 7Seg
	#Para diviersion se usa los siguientes tres espacios de memoria
	# 0x1204, 0x1208 y 0x120C
	addi a1, zero, 0x0001 #00100000000001010000000000000001
	lui t7, 0x0000 #00111100000011110000000000000000
	ori t7, t7, 0x0202 #00110101111011110000001000000010
	sw a1, 0x0000(t7) #10101101111001010000000000000000


salirMovil:
	#--------------------------------
	#la t4, diversionJuegoLeds
    lui t4, 0x0000 #00111100000011000000000000000000
    ori t4, t4, 0x000F #00110101100011000000000000001111
	#---------------------------------

	lw t8, 0x0000(t4) #10001101100110000000000000000000
	beq t8, 0, salirDiversion
	#Logica para juego leds

	#Salida a LED o 7Seg
	#Para diviersion se usa los siguientes tres espacios de memoria
	# 0x1204, 0x1208 y 0x120C
	addi a1, zero, 0x0001 #00100000000001010000000000000001
	lui t7, 0x0000 #00111100000011110000000000000000
	ori t7, t7, 0x0203 #00110101111011110000001000000011
	sw a1, 0x0000(t7) #10101101111001010000000000000000
	
salirDiversion:

	#Arrullo
	#ble t3, s6, salirArrullo
    slt a0, s6, t3 #00000010110010110010000000101010
    beq a0, 0, salirArrullo

	#bge t3, s7, salirArrullo
    slt a0, t3, s7 #00000001011101110010000000101010
    beq a0, 0, salirArrullo

	#Logica para arrullo

	#--------------------------------
	#la t4, llantoLeve
    lui t4, 0x0000 #00111100000011000000000000000000
    ori t4, t4, 0x000C #00110101100011000000000000001100
	#---------------------------------

	lw t8, 0x0000(t4) #10001101100110000000000000000000
	beq t8, 0, salirArrullo

	#Salida a LED o 7Seg -------------------- Prender musica <accion de llanto leve durante arrullo>
	addi a1, zero, 0x0002 #00100000000001010000000000000010
	lui t7, 0x0000 #00111100000011110000000000000000
	ori t7, t7, 0x0201 #00110101111011110000001000000001
	sw a1, 0x0000(t7) #10101101111001010000000000000000

salirArrullo:
	

	#addi t4, t4, 4 #Aumenta en 4 la direccion de llantoFuerte
	#addi t5, t5, 4 #Aumenta en 4 la direccion de llantoLeve

	addi t0, t0, 0x0004 #00100001000010000000000000000100
	addi t2, t2, 0x0001 #00100001010010100000000000000001
	bne t2, t1, repetir
exit:
	li v0, 10 #system call code for exit
	syscall
	.end