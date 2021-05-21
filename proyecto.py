def main():

    #configurar
    hora_arrullo1 = input("Arr")
    hora_arrullo2 = input("Arr")
    hora_diversion1 = input("diver")
    hora_diversion2 = input("diver")
    hora_dormir1 = input("dormir")
    hora_dormir2 = input("dormir")

    #Entrada
    HORA = 0 # hora del dia
    entradaLlanto = 0 # 0 no llora, 1 llora suave, 2 llora duro
    entradaDiversion = 0 # Es una variable de 3 bits, cada bit representa una actividad que se debe prender

    #salida
    ledsIniciales = 0 
    ledsFinales = 0 # Para saber si estoy en dormir, arrullo o actividades 
    sseg = 0 # 0 = vacio, 1 = bbdp, 2 = FALA, 3 = PLAY, 4 = SOLD

    # Ejecucion programa
    while(1):

            # música si el sensor de llanto está activado en llanto leve, 
            # en caso contrario no la activa. En el modo arrullo también se maneja una salida 
            # para activar un difusor de olores, esta salida se activa mientras
            # esté el sistema en el modo arrullo. Si se activa la música pone en el siete 
            # segmentos el mensaje (SOLd) y para el difusor prende 4 leds.

        if(HORA <= hora_arrullo2 ):
            if( HORA >= hora_arrullo1):
                entradaLlanto = input()
                if(entradaLlanto == 1):
                    sseg = 4    
                leds = 15
                ledsFinales = 1

        # tiene como entrada un sensor de llanto que genera dos alarmas, si el llanto es 
        # leve enviará una alarma que prenderá un led, en caso de que el llanto sea fuerte 
        # se activará la alarma que pondrá un mensaje en los siete segmentos (bbdp) para que 
        # los padres se levanten.
        if(HORA <= hora_dormir2):
            if( HORA >= hora_dormir1):
                entradaLlanto = input()
                if(entradaLlanto == 2):
                    sseg = 1
                led = entradaLlanto[0] # Haciendo alusion a que solo se tomara en cuenta el primer bit para prender el led de llanto leve
                ledsFinales = 2


        # una salida para activar música, otra para activar un móvil de muñecos, 
        # y otra activa un juego de leds de la tarjeta. Estas salidas se pueden 
        # seleccionar desde la tarjeta por medio de los switches, el sistema puede
        #  soportar que estén las tres salidas activadas al tiempo. Cuando se selecciona 
        #  la salida de música se debe prender un mensaje en el display 7 segmentos (FALA), 
        #  y para el móvil de muñecos el mensaje es (PLAy). Para el juego de leds de la tarjeta 
        #  ponga alguna secuencia que considere usted puede ser apropiada para distraer al bebe.

        if(HORA <= hora_diversion2 ):
            if( HORA >= hora_diversion1):
                entradaDiversion = input()
                if(entradaDiversion == 1): # 1 = musica, 2 = movil, 4 = juego
                    sseg = 2
                if(entradaDiversion == 2):
                    sseg = 3
                #La entradaDiversion representara los leds que debo prender dependiendo de que actividades este haciendo
                leds = entradaDiversion
                ledsFinales = 4

        #Simbolizan las salidas del programa
        print(sseg)
        print(leds)
        print(ledsFinales)

        hora = (hora + 1) % 25

