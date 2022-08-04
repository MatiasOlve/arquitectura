            .data
            vector: .byte 33,5,3,13,75,1,3,45,21
            cantidad: .byte 9
            cad0: .asciiz "-"
            .text
            .globl main
        
        minimo:
        	lb t0,0(a0)				#Debemos pasar en a0 y a1 las direcciones a usar para comparar.
            lb t1,0(a1)				#En a0 pasaremos una dirección i-1 y en a1 la dirección i
            blt t0,t1,fin_minimo
			sb t0,0(a1)
            sb t1,0(a0)
        fin_minimo:
            jr ra   
        
        ordenar:					#Usaremos el método de intercambio, el cuál compara del último al primer elemento
        	addi sp,sp,-16			#Guardamos el valor de ra en el stack para poder volver al main
            sw ra,0(sp)
            sw s1,4(sp)
            sw s2,8(sp)	
        	mv s1,a0				#s1 tiene la dirección al inicio del vector
            mv s2,a1				#s2 guarda la cantidad de elementos
            addi s2,s2,-1
            mv a2,zero				#Índice del primer for i=1...n-1
            addi a3,zero,1			#Indice del segundo for j=2...n
            add a4,a3,zero		
        
        lazo1:
        	beq a2,s2,fin_ordenar	#Se sale cuando ya se recorrieron todos los valores
            mv a3,a4
        lazo2:
        	add a0,s1,a2
            add a1,s1,a3
            jal minimo
            addi a3,a3,1
            ble a3,s2,lazo2
            addi a2,a2,1
            addi a4,a4,1
            j lazo1
            
        mostrar:			#Se pasa en a1 la dirección del elemento a mostrar
            
        	lb t0,0(a1)
			li a0,1 # Selección del servicio: mostrar un entero por pantalla
			mv a1,t0 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla
            
            li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad0 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
            jr ra
                
        fin_ordenar:
            lw ra, 0(sp)
            lw s1, 4(sp)
            lw s2, 8(sp)
            addi sp,sp,16
        	jr ra
            
        main: 
            la a0,vector
            la a1, cantidad
            lb a1,0(a1)
            jal ordenar
        	la s1,vector
            la s2,cantidad
            lb s2,0(s2)
            mv s3,zero
        lazo:					#lazo para mostrar el vector
			beq s3,s2,fin
            add a1,s1,s3
            jal mostrar
            addi s3,s3,1
            j lazo
 
		fin:    
            
            li a0,10 # Selección del servicio terminar el programa sin error
            ecall # Termina el programa y retorna al sistema operativo