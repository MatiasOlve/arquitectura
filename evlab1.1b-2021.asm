            .data
            numero: .byte 100
            #divisor: .word 4
            cad0: .asciiz "Numero: "
            cad1: .asciiz "\nCantidad de divisores: "
            cad2: .asciiz "\nDivisores:"
            cad3: .asciiz " "
            .text
            .globl main
            
        es_divisor:
        	#Esta subrutina recibirá en a1 el número a dividir y en a2 el divisor, devolviendo en a0 un valor de 1 si es divisor que se 
            #sumará en otro registro para indicar que se encontró otro divisor
            
            lazo:		#Determinamos si es divisor con restas sucesivas
        		blt a1,a2,fin_loop
                sub a1,a1,a2
                j lazo
        fin_loop:
        	seqz a0,a1
            beq a0,zero,fin_es_divisor	#Si es uno, es divisor. Si es cero, no lo es

        fin_es_divisor:
        	jr ra
     
        main: 
        	mv s2,zero			#Registro que contará la cantidad de divisores
            addi a2, zero,1		#El divisor arranca en 1
            la s3,numero
            lb s3,0(s3)
            
            li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad0 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
			li a0,1 # Selección del servicio: mostrar un entero por pantalla
            mv a1,s3 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla
            
            li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad2 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
        lazo_main:
        	mv a1,s3 
            bgt a2,a1,fin
            jal es_divisor
            add s2,s2,a0
            beq a0,zero,siguiente
            
            li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad3 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
            li a0,1 # Selección del servicio: mostrar un entero por pantalla
            mv a1,a2 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla
        siguiente:
            addi a2,a2,1
            j lazo_main            
            
        fin: 

        	li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad1 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
			li a0,1 # Selección del servicio: mostrar un entero por pantalla
            mv a1,s2 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla
            
            
            li a0,10 # Selección del servicio terminar el programa sin error
            ecall # Termina el programa y retorna al sistema operativo