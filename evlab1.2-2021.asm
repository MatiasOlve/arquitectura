            .data

            cad0: .asciiz "Cadena original: "
            cad1: .asciiz "\nCadena modificada: "
            cad2: .asciiz "nombre apellido0"
            vocales: .asciiz "aeiou0"

            .text
            .globl main
        
        vocal:
        	li t3,'0'
        	li t0,'1'			#En principio suponemos que la vocal es a
            la t1,vocales		#Apunto al inicio de la cadena de vocales
        lazo:
        	lb t2,0(t1)			#Cargo el caracter de la cadena de vocales
        	beq a0,t2,final		#Si el caracter está entre las vocales termino
            addi t0,t0,1		#Incremento en uno el posible índice de la vocal
            addi t1,t1,1		#Muevo el puntero de la cadena de vocales
            bne t2,t3,lazo			#Si no es el final de la cadena repito
            li t0,0				#Si llegue al final de la cadena no es una vocal
        final:
        	mv a0,t0			#Cargo el resultado en el registro de argumentos
            ret
			
        convertir_caracter:
        	#mandamos en a0 el caracter
            addi sp,sp,-4
            sw ra,0(sp)
            li a1,' '
            bne a0,a1,caracter
         	addi a0,zero,'#'
            j fin_subrutina
        
        caracter:
            jal vocal

         fin_subrutina:
            lw ra,0(sp)
            addi sp,sp,4
            jr ra
     
        main: 
        
        	li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad0 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
			li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad2 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
        
        	la s1,cad2
            addi s2,zero,'0'
        
        lazo_main:
        
        	lb a0,0(s1)
        	beq a0,s2,fin
           	jal convertir_caracter
            beqz a0,siguiente
            sb a0,0(s1)
        siguiente:
            addi s1,s1,1
            j lazo_main
            
            
        fin: 
 
            li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad1 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
            li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad2 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
            
            li a0,10 # Selección del servicio terminar el programa sin error
            ecall # Termina el programa y retorna al sistema operativo