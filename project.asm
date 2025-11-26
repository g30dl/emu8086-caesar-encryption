.MODEL SMALL
.STACK 100h
.DATA
 
    titulo DB 13, 10, '====================================', 13, 10
           DB '    SISTEMA DE CIFRADO CESAR', 13, 10
           DB '====================================', 13, 10, '$'
    
    menu DB 13, 10, 'Seleccione una opcion:', 13, 10
         DB '1. Encriptar', 13, 10
         DB '2. Desencriptar', 13, 10
         DB '3. Salir', 13, 10
         DB 13, 10, 'Opcion: $'
    
    error_opcion DB 13, 10, 'Error: Opcion invalida!', 13, 10
                 DB 'Por favor ingrese un numero entre 1 y 3.', 13, 10, '$'
    
    msg_encriptando DB 13, 10, 13, 10, '>>> ENCRIPTANDO...', 13, 10
                    DB 'Procesando texto...', 13, 10
                    DB 'Cifrado completado!', 13, 10, '$'
    
    msg_desencriptando DB 13, 10, 13, 10, '>>> DESENCRIPTANDO...', 13, 10
                       DB 'Procesando texto cifrado...', 13, 10
                       DB 'Descifrado completado!', 13, 10, '$'
    
    msg_salida DB 13, 10, 13, 10, 'Gracias por usar el sistema!', 13, 10
               DB 'Hasta pronto...', 13, 10, '$'
    
    presione_tecla DB 13, 10, 'Presione cualquier tecla para continuar...$'

.CODE

INICIO:

    .STARTUP    
    lea dx, titulo ;mostrar titulo
    mov ah, 09h
    int 21h
    
    jmp MOSTRAR_MENU

MOSTRAR_MENU:
    lea dx, menu ;mostrar menu
    mov ah, 09h
    int 21h
    
    mov ah, 01h ;leer opcion
    int 21h
    
    cmp al, '1' ;validar que sea mayor o igual a '1'
    jl OPCION_INVALIDA
    
    cmp al, '3' ;validar que sea menor o igual a '3'
    jg OPCION_INVALIDA
    
    cmp al, '1' ;comparar si es opcion 1
    je ENCRIPTAR
    
    cmp al, '2' ;comparar si es opcion 2
    je DESENCRIPTAR
    
    cmp al, '3' ;comparar si es opcion 3
    je SALIR
    
    jmp OPCION_INVALIDA ;si llega aqui, es invalida

OPCION_INVALIDA:
    lea dx, error_opcion ;mostrar mensaje de error
    mov ah, 09h
    int 21h
    
    lea dx, presione_tecla ;pausar antes de volver al menu
    mov ah, 09h
    int 21h
    
    mov ah, 01h ;esperar tecla
    int 21h
    
    jmp MOSTRAR_MENU ;volver al menu

ENCRIPTAR:
    lea dx, msg_encriptando ;mostrar mensaje de encriptacion
    mov ah, 09h
    int 21h
    
    lea dx, presione_tecla ;pausar antes de volver al menu
    mov ah, 09h
    int 21h
    
    mov ah, 01h ;esperar tecla
    int 21h
    
    jmp MOSTRAR_MENU ;volver al menu

DESENCRIPTAR:
    lea dx, msg_desencriptando ;mostrar mensaje de desencriptacion
    mov ah, 09h
    int 21h
    
    lea dx, presione_tecla ;pausar antes de volver al menu
    mov ah, 09h
    int 21h
    
    mov ah, 01h ;esperar tecla
    int 21h
    
    jmp MOSTRAR_MENU ;volver al menu

SALIR:
    lea dx, msg_salida ;mostrar mensaje de despedida
    mov ah, 09h
    int 21h
    
    mov ah, 4Ch ;terminar programa
    int 21h

END INICIO
