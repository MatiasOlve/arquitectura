            .data
            pesos: .byte 27
            cad0: .asciiz "Monedas de $1:"
            cad1: .asciiz "\nMonedas de $5: "
            cad2: .asciiz "\nMonedas de $10: "
            .text
            .globl main
        
        monedas:
        	mv a1,zero
            mv a2,zero
            mv a3,zero
            mv t0,zero
        
        lazo:
        	beq t0,a0,fin_monedas
            addi t0,t0,10
            addi a3,a3,1
            ble t0,a0,lazo
            
            addi a3,a3,-1
            addi t0,t0,-10
            addi t0,t0,5
            addi a2,a2,1
            ble t0,a0,lazo
            
            addi a2,a2,-1
            addi t0,t0,-5
            addi t0,t0,1
            addi a1,a1,1
            ble t0,a0,lazo
        fin_monedas:
        	jr ra
            
        main: 
            la a0,pesos	#Cargamos en a0 la dirección del vector
            lb a0,0(a0)
            jal monedas
            mv s1,a1
            mv s2,a2
            mv s3,a3
            
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
            
            li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad2 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
			li a0,1 # Selección del servicio: mostrar un entero por pantalla
			mv a1,s3 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla
            
            li a0,10 # Selección del servicio terminar el programa sin error
            ecall # Termina el programa y retorna al sistema operativo