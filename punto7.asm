            .data
            matriz_A: 	.byte   1,1,1,1
            			.byte	2,2,2,2
                        .byte   3,3,3,3
                        .byte	4,4,4,4
                        
            matriz_B: 	.byte	2,2,2,2
            			.byte	3,3,3,3
                        .byte	2,2,2,2
            			.byte	3,3,3,3
                        
            matriz_C: 	.byte	1,0,0,1
            			.byte	0,0,0,0
                        .byte	0,0,0,0
                        .byte	1,0,0,1
            .text
            .globl main
            
        gemm:
            mv t0,zero
            mv t1,zero
            mv t2,zero
            addi t4,t4,4
            
            #El índice i se multiplica por cuatro en cada producto, y se suma el j
            lazo1:
            	beq t0,t4,fin_gemm
                mv t1,zero
            lazo2:
            	mv t2,zero
            	blt t1,t4,lazo3
                addi t0,t0,1
                j lazo1
            	
            lazo3:
            	mul t5,t0,t4
                add t5,t5,t2	
                #addi t5,t5,-1	#Índice de A
                
                add t5,t5,a1
                lb t5,0(t5)		#Elemento de A
                
                mul t6,t2,t4
                add t6,t6,t1	
                #addi t6,t6,-1	#Índice de B
                
                add t6,t6,a2
                lb t6,0(t6)		#Elemento de B
                
                mul t6,t5,t6	#Producto
                
                mul t5,t0,t4
                add t5,t5,t1	
                #addi t5,t5,-1	#Índice de C
                
                add t5,t5,a0
                lb t5,0(t5)		#Elemento de C
                
                add t6,t6,t5	#Resultado a guardar en C
                
                mul t5,t0,t4
                add t5,t5,t1	
                #addi t5,t5,-1	#Índice de C
                
                add t5,t5,a0	#Dirección donde guardar el resultado
                sb t6,0(t5)
                
                addi t2,t2,1
                blt t2,t4,lazo3
                addi t1,t1,1
                j lazo2
                    
        fin_gemm:
        	jr ra
            
        main: 
			la a0,matriz_C
            la a1,matriz_A
            la a2,matriz_B
            jal gemm

 
		fin:    
            
            li a0,10 # Selección del servicio terminar el programa sin error
            ecall # Termina el programa y retorna al sistema operativo