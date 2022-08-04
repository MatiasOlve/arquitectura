            .data
            cad0: .asciiz "Cadena Antes: "
            cad1: .asciiz "mATIAS Olveira"
            cad2: .asciiz "\nCadena Despues: "
            .text
            .globl main
            
        cambiar:		#La función cambiar recibirá en a0 un valor que determinará si se cambia el caracter a mayúscula 
        				#o minúscula. Un 0 si es de MAY a min. Un 1 si es de min a MAY. En a2 recibe la dirección.
                        #En a3 y a4 recibirá los límites (inferior y superior respectivamente).
                #mv t0,a2
			   	lb t0,0(a2)					#Cargo el caracter
                blt t0,a3,sin_modificar		#Si es menor al límite inferior, salgo
                bgt t0,a4,sin_modificar		#Si es mayor al límite superior, salgo
               	beq a0,zero,minus         	#Si en a0 hay un 0, entonces tengo que cambiar el caracter a minúscula
      	mayus:
       		   	addi a0,t0,-32				#Valor hexadecimal del caracter en mayúscula
                j fin_cambiar
       	minus:
       			addi a0,t0,32				#Valor hexadecimal del caracter en minúscula
                j fin_cambiar
        sin_modificar:
        		mv a0,t0
       	fin_cambiar:
        		ret
                
        apellido:							#Recibimos en a2 la dirección de memoria
        		addi sp,sp,-4				#Guardo el valor de ra en el stack
                sw ra, 0(sp)
                lazo:
                	addi a3,zero,'a'		#Paso los valores límites para la función
            		addi a4,zero,'z'
                	addi a0,zero,1
                    lb t0,0(a2)
                    addi t1,zero,' '
                    beq t0,t1,fin_lazo		#Comparo si se llegó al final de la cadena o 
                    beq t0,zero,fin_lazo	#si se encontró un espacio
                    jal cambiar				#Llamo a la subrutina cambiar
                    sb a0,0(a2)				#Guardo el caracter modificado
                    addi a2,a2,1			#Actualizo el puntero
                    j lazo
                
                fin_lazo:					#Recupero registros y vuelvo al main
                	lw ra,0(sp)
                    addi sp,sp,4
                    ret  
                    
          nombre:
          		addi sp,sp,-4				#Guardo el valor de ra en el stack
                sw ra, 0(sp)
                addi a3,zero,'a'			#Paso los valores límites para la función
            	addi a4,zero,'z'
                addi a0,zero,1
                jal cambiar					#El primer caracter del nombre se convierte en MAY
                sb a0,0(a2)				#Guardo el caracter modificado
                addi a2,a2,1
                
                lazo_nom:
                	addi a3,zero,'A'		#Paso los valores límites para la función
            		addi a4,zero,'Z'
                	mv a0,zero
                    lb t0,0(a2)
                    addi t1,zero,' '
                    beq t0,t1,fin_lazo_nom		#Comparo si se llegó al final de la cadena o 
                    beq t0,zero,fin_lazo_nom	#si se encontró un espacio
                    jal cambiar				#Llamo a la subrutina cambiar
                    sb a0,0(a2)				#Guardo el caracter modificado
                    addi a2,a2,1			#Actualizo el puntero
                    j lazo_nom
                
                fin_lazo_nom:					#Recupero registros y vuelvo al main
                	lw ra,0(sp)
                    addi sp,sp,4
                    ret
                    
           mostrar:		#Pasamos en a2 la dirección de la cadena
           		li a0,4 # Selección del servicio: mostrar una cadena por pantalla
				mv a1,a2 # Apuntamos al inicio de la cadena a imprimir
				ecall # Pedimos el servicio, la cadena se muestra en la pantalla
                ret
                    
            
        main: 
            la a2,cad0
            jal mostrar
            la a2,cad1 
            jal mostrar
            
            jal nombre
            addi a2,a2,1
            jal apellido
            
            la a2,cad2
            jal mostrar
            la a2,cad1
            jal mostrar

           
            
		fin:    
            
            li a0,10 # Selección del servicio terminar el programa sin error
            ecall # Termina el programa y retorna al sistema operativo