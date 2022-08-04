            .data
            res_suma: .word 0
            res_promedio: .word 0
            vector: .byte 1,1,1,1,5,6,7,8,0
            cad0: .asciiz "Cantidad de numeros pares:"
            cad1: .asciiz "\nCantidad de numeros impares: "
            .text
            .globl main
            
        elementos:
        	mv a1,zero
            mv a2,zero
            lazo:
            	lb t0,0(a0)
                addi a0,a0,1
                beq t0,zero, fin_lazo
                andi t0,t0,1
                beq t0,zero,par
            
            impar:
            	addi a2,a2,1
                j lazo
            par:
            	addi a1,a1,1
                j lazo
                
            fin_lazo:
            	jr ra

            
        main: 
            la a0,vector	#Cargamos en a0 la dirección del vector
            jal elementos
            mv s1,a1
            mv s2,a2
            
        fin: 
        	li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad0 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
			li a0,1 # Selección del servicio: mostrar un entero por pantalla
            mv a1,s1 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla
            
            li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad1 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
			li a0,1 # Selección del servicio: mostrar un entero por pantalla
			mv a1,s2 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla
            
            li a0,10 # Selección del servicio terminar el programa sin error
            ecall # Termina el programa y retorna al sistema operativo