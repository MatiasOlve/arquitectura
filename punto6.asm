            .data
            tabla: .byte 0x3F, 0x06, 0x5A, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
            cad0: .asciiz "Valor convertido: "
            .text
            .globl main
            
        main: 
        	li a0,4
            la a1, tabla
            add a1,a1,a0
            lb a2,0(a1)
            
		fin:    
        	li a0,4 # Selección del servicio: mostrar una cadena por pantalla
			la a1,cad0 # Apuntamos al inicio de la cadena a imprimir
			ecall # Pedimos el servicio, la cadena se muestra en la pantalla
            
			li a0,1 # Selección del servicio: mostrar un entero por pantalla
			mv a1,a2 # Cargamos el valor que queremos mostrar
			ecall # Pedimos el servicio, el entero se muestra en la pantalla
            
            li a0,10 # Selección del servicio terminar el programa sin error
            ecall # Termina el programa y retorna al sistema operativo