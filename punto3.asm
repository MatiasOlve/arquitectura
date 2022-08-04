            .data
            res_suma: .word 0
            res_promedio: .word 0
            vector: .byte 7,7,7,7,7,7,7,0
            cad0: .asciiz "La suma de los elementos es:"
            cad1: .asciiz "\nEl promedio de los elementos es: "
            .text
            .globl main
            
        suma:	#En a1 pasamos el índice y sumamos todos los elementos hasta encontrar el valor 0
        	add t0, a1,a0
            lbu t0,0(t0)	#cargamos el elemento con índice ai
            beq t0,zero,fin_suma
            la t1,res_suma
            lw t2, 0(t1)
            add t0,t0,t2
            sw t0,0(t1)
            jr ra			#retornamos al main
       	fin_suma:			#se encontró el elemento 0
        	mv a0,a1		#muevo a a0 la cantidad de elementos del vector
        	mv a1,zero
            jr ra     	
        
        promedio:
            la t0,res_suma
            la t1,res_promedio
            lw t0,0(t0)
            div t0,t0,a0
            sw t0,0(t1)
            jr ra
            
        main: 
            la a0,vector	#Cargamos en a0 la dirección del vector
            lbu a2,0(a0)	#Cargo el primer byte del vector
            la t0,res_suma
            sw a2,0(t0)		#"Sumamos" a res_suma el primer elemento del vector            
            li a1,1	#Ponemos el índice en 1 (segundo elemento del vector)
        lazo:
        	jal suma
            beq a1,zero,fin
            addi a1,a1,1
            j lazo
        fin: 
        	jal promedio
            li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad0 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
            lw s0,res_suma # Cargamos el primer operando
			li a0,1 # Selección del servicio: mostrar un entero por pantalla
			mv a1,s0 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla
            
            li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad1 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
            lw s0,res_promedio # Cargamos el primer operando
			li a0,1 # Selección del servicio: mostrar un entero por pantalla
			mv a1,s0 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla            
            
            li a0,10 # Selección del servicio terminar el programa sin error
            ecall # Termina el programa y retorna al sistema operativo