            .data
            vector: .byte 8,9
            cad0: .asciiz "El valor minimo es: "
            cad1: .asciiz "\nEl valor maximo es: "
            .text
            .globl main
        
        minimo:
        	lb t0,0(a0)
            lb t1,0(a1)
            blt t0,t1,fin_minimo
			sb t0,0(a1)
            sb t1,0(a0)
        fin_minimo:
            jr ra
            
        main: 
            la s1, vector		#Cargamos la dirección del vector donde se almacenan los valores
            mv a0,s1
            addi a1,s1,1
            jal minimo
            
		fin:    
        	li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad0 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
            lb t0,0(s1)
			li a0,1 # Selección del servicio: mostrar un entero por pantalla
			mv a1,t0 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla
            
            li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad1 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
            lb t0,1(s1)
			li a0,1 # Selección del servicio: mostrar un entero por pantalla
			mv a1,t0 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla
            
            li a0,10 # Selección del servicio terminar el programa sin error
            ecall # Termina el programa y retorna al sistema operativo