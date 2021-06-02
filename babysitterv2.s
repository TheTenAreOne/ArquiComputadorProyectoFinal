
# HORA -> $s0
# hora_arrullo1 -> $s1
# hora_arrullo2 -> $s2
# hora_diversion1 -> $s3
# hora_diversion2 -> $s4
# hora_dormir1 -> $s5
# hora_dormir2 -> $s6


# Salidas
# sseg -> $t7
# leds -> $t8
# ledsFinales -> $t9
conf:
    add $s0, $0, $0 # Inicializamos la hora en 0
    add $t0, $0, $0 # Inicializamos la direccion de la memoria en 0
    lw $s1, 0($t0) # En la pos 0 de la memoria está la entrada de hora_arrullo1
    lw $s2, 1($t0) # En la pos 1 de la memoria está la entrada de hora_arrullo2
    lw $s3, 2($t0) #...
    lw $s4, 3($t0)
    lw $s5, 4($t0)
    lw $s6, 5($t0)

ifarrullo:
    #if(HORA <= hora_arrullo2 && HORA >= hora_arrullo1 ):
    slt $t1, $s0, $s2
    slt $t2, $s1, $s0 
    and $t3, $t1, $t2
    beq $t3, $0, ifdormir
    ###

truearrullo1: # Si la hora está en el intervalo
    # EntradaLlanto -> $s7
    lw $s7, 6($t0) # En la pos 1 de la memoria está la entrada del nivel del llanto

    addi $t1, $0, 1
    beq $t1, $s7, truearrullo2 # if(entradaLlanto == 1):
    j truearrullo3

truearrullo2:
    addi $t7, $0, 4 #  sseg = 4   
truearrullo3:
    addi $t8, $0, 15 #  leds = 15             
    addi $t9, $0, 1 #  ledsFinales = 1       
                
            
ifdormir:
    #if(HORA <= hora_dormir2 && HORA >= hora_dormir1):
    slt $t1, $s0, $s6
    slt $t2, $s5, $s0 
    and $t3, $t1, $t2
    beq $t3, $0, ifdiver
    ##

truedormir1:
    # EntradaLlanto -> $s7
    lw $s7, 6($t0) # En la pos 6 de la memoria está la entrada del nivel del llanto

    addi $t1, $0, 2
    beq $t1, $s7, truedormir2 # if(entradaLlanto == 2):
    j truedormir3

truedormir2:
    addi $t7, $0, 1 #  sseg = 1
truedormir3:
    addi $t1, $0, 1
    and $t2, $t1, $t7 # Tomamos el primer bit de llanto, para prender el led
    
    add $t8, $0, $t2 #  led = entradaLlanto[0]            
    addi $t9, $0, 2 #  ledsFinales = 2  

ifdiver:
    #(HORA <= hora_diversion2 && HORA >= hora_diversion1):
    slt $t1, $s0, $s4
    slt $t2, $s3, $s0 
    and $t3, $t1, $t2
    beq $t3, $0, salida
    ##    

truediver1:
    # entradaDiversion -> $s7
    lw $s7, 7($t0) # En la pos 7 de la memoria está la entrada de la seleccion de la diversion
    
    addi $t1, $0, 1
    beq $t1, $s7, truediver2 # if(entradaDiversion == 1): # 1 = musica, 2 = movil, 4 = juego
    j truediver3

truediver2:
    addi $t7, $0, 2 #  sseg = 2   
truediver3:
    addi $t1, $0, 2
    beq $t1, $s7, truediver4 # if(entradaDiversion == 2): # 1 = musica, 2 = movil, 4 = juego
    j truediver5
truediver4:
    addi $t7, $0, 3 #  sseg = 3  
truediver5:

    add $t8, $0, $s7 #  leds = entradaDiversion La entradaDiversion representara los leds que debo prender dependiendo de que actividades este haciendo         
    addi $t9, $0, 4 #  ledsFinales = 4

salida:

    # Salidas para los leds
    sw $t7, 8($t0) # print(sseg)
    sw $t8, 9($t0) # print(leds)
    sw $t9, 10($t0)# print(ledsFinales)
        
    addi $s0, $s0, 1    

    addi $t1, $0, 25
    beq $t1, $s0, reset
    j ifarrullo

reset:
    add $s0, $0, $0 # hora = (hora + 1) % 25   

restart:
    j ifarrullo
