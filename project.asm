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
    
    msg_salida DB 13, 10, 13, 10, 'Gracias por usar el sistema!', 13, 10
               DB 'Hasta pronto...', 13, 10, '$'
    
    presione_tecla DB 13, 10, 'Presione cualquier tecla para continuar...$'

    msg_desplazamiento DB 13, 10, 'Ingrese desplazamiento (1-5): $'
    
    msg_texto DB 'Ingrese texto (max 35 caracteres): $'
    
    msg_resultado DB 13, 10, 13, 10, 'Texto encriptado: $'
    
    texto_entrada DB 36 DUP('$') ;buffer para 35 caracteres + terminador
    
    desplazamiento DB 0
    
    desplazamiento_inv DB 0

.CODE

INICIO:
    .STARTUP    
    lea dx, titulo
    mov ah, 09h ;imprimir titulo
    int 21h
    
    jmp MOSTRAR_MENU

MOSTRAR_MENU:
    lea dx, menu
    mov ah, 09h ;imprimir el menu
    int 21h
    
    mov ah, 01h ;leer caracter
    int 21h
    
    cmp al, '1' ;validar rango 1-3
    jl OPCION_INVALIDA
    cmp al, '3'
    jg OPCION_INVALIDA
    
    cmp al, '1'
    je ENCRIPTAR
    cmp al, '2'
    je DESENCRIPTAR
    cmp al, '3'
    je SALIR
    
    jmp OPCION_INVALIDA

OPCION_INVALIDA:
    lea dx, error_opcion
    mov ah, 09h ;imprimir cadena
    int 21h
    
    lea dx, presione_tecla
    mov ah, 09h
    int 21h
    
    mov ah, 01h ;esperar tecla
    int 21h
    
    jmp MOSTRAR_MENU

;============ ENCRIPTACION =============================================

ENCRIPTAR:
    lea dx, msg_desplazamiento
    mov ah, 09h ;imprimir cadena
    int 21h
    
    mov ah, 01h ;leer caracter
    int 21h
    sub al, '0' ;convertir ASCII a numero
    mov desplazamiento, al
    
    cmp al, 1 ;validar rango 1-5
    jl MOSTRAR_MENU
    cmp al, 5
    jg MOSTRAR_MENU
    
    lea dx, msg_texto
    mov ah, 09h ;imprimir cadena
    int 21h
    
    lea si, texto_entrada ;SI apunta al buffer
    mov cx, 0 ;contador de caracteres
    
LEER_TEXTO:
    mov ah, 01h ;leer caracter
    int 21h
    
    cmp al, 13 ;verificar ENTER
    je FIN_LECTURA
    
    mov [si], al ;guardar en buffer
    inc si
    inc cx
    cmp cx, 35 ;limite de 35 caracteres
    jl LEER_TEXTO
    
FIN_LECTURA:
    mov byte ptr [si], '$' ;terminar cadena
    
    lea dx, msg_resultado
    mov ah, 09h ;imprimir cadena
    int 21h
    
    lea si, texto_entrada
    mov bl, desplazamiento
    
PROCESAR_CARACTER:
    mov al, [si] ;cargar caracter actual
    cmp al, '$' ;fin de cadena
    je FIN_ENCRIPTADO
    
    cmp al, 'A' ;verificar si es mayuscula A-Z
    jl NO_ES_LETRA
    cmp al, 'Z'
    jle ES_MAYUSCULA
    
    cmp al, 'a' ;verificar si es minuscula a-z
    jl NO_ES_LETRA
    cmp al, 'z'
    jle ES_MINUSCULA
    
NO_ES_LETRA:
    mov dl, al
    mov ah, 02h ;imprimir caracter sin cambios
    int 21h
    jmp SIGUIENTE_CARACTER
    
ES_MAYUSCULA:
    sub al, 'A' ;normalizar a 0-25
    add al, bl ;sumar desplazamiento
    mov ah, 0
    mov cl, 26
    div cl ;dividir entre 26
    mov al, ah ;tomar residuo (modulo 26)
    add al, 'A' ;volver a ASCII
    mov dl, al
    mov ah, 02h ;imprimir caracter
    int 21h
    jmp SIGUIENTE_CARACTER
    
ES_MINUSCULA:
    sub al, 'a' ;normalizar a 0-25
    add al, bl ;sumar desplazamiento
    mov ah, 0
    mov cl, 26
    div cl ;dividir entre 26
    mov al, ah ;tomar residuo (modulo 26)
    add al, 'a' ;volver a ASCII
    mov dl, al
    mov ah, 02h ;imprimir caracter
    int 21h
    
SIGUIENTE_CARACTER:
    inc si ;siguiente caracter
    jmp PROCESAR_CARACTER
    
FIN_ENCRIPTADO:
    lea dx, presione_tecla
    mov ah, 09h
    int 21h
    mov ah, 01h ;esperar tecla
    int 21h
    jmp MOSTRAR_MENU
    
;=======================================================================  

;========================= DESENCRIPTAR ================================

DESENCRIPTAR:
    lea dx, msg_desplazamiento
    mov ah, 09h ;imprimir cadena
    int 21h
    
    mov ah, 01h ;leer caracter
    int 21h
    sub al, '0' ;convertir ASCII a numero
    mov desplazamiento, al
    
    cmp al, 1 ;validar rango 1-5
    jl MOSTRAR_MENU
    cmp al, 5
    jg MOSTRAR_MENU
    
    lea dx, msg_texto
    mov ah, 09h ;imprimir cadena
    int 21h
    
    lea si, texto_entrada ;SI apunta al buffer
    mov cx, 0 ;contador de caracteres
    
LEER_TEXTO_DES:
    mov ah, 01h ;leer caracter
    int 21h
    cmp al, 13 ;verificar ENTER
    je FIN_LECTURA_DES
    mov [si], al ;guardar en buffer
    inc si
    inc cx
    cmp cx, 35 ;limite de 35 caracteres
    jl LEER_TEXTO_DES
    
FIN_LECTURA_DES:
    mov byte ptr [si], '$' ;terminar cadena
    
    lea dx, msg_resultado
    mov ah, 09h ;imprimir cadena
    int 21h
    
    lea si, texto_entrada
    mov bl, desplazamiento
    
PROCESAR_DES:
    mov al, [si] ;cargar caracter actual
    cmp al, '$' ;fin de cadena
    je FIN_DESENCRIPTADO
    
    cmp al, 'A' ;verificar si es mayuscula A-Z
    jl NO_ES_LETRA_DES
    cmp al, 'Z'
    jle ES_MAYUSCULA_DES
    
    cmp al, 'a' ;verificar si es minuscula a-z
    jl NO_ES_LETRA_DES
    cmp al, 'z'
    jle ES_MINUSCULA_DES
    
NO_ES_LETRA_DES:
    mov dl, al
    mov ah, 02h ;imprimir caracter sin cambios
    int 21h
    jmp SIGUIENTE_DES
    
ES_MAYUSCULA_DES:
    sub al, 'A' ;normalizar a 0-25
    sub al, bl ;restar desplazamiento
    
    cmp al, 0 ;verificar si es negativo
    jge POSITIVO_MAY
    add al, 26 ;ajustar si es negativo
    
POSITIVO_MAY:
    add al, 'A' ;volver a ASCII
    mov dl, al
    mov ah, 02h ;imprimir caracter
    int 21h
    jmp SIGUIENTE_DES
    
ES_MINUSCULA_DES:
    sub al, 'a' ;normalizar a 0-25
    sub al, bl ;restar desplazamiento
    
    cmp al, 0 ;verificar si es negativo
    jge POSITIVO_MIN
    add al, 26 ;ajustar si es negativo
    
POSITIVO_MIN:
    add al, 'a' ;volver a ASCII
    mov dl, al
    mov ah, 02h ;imprimir caracter
    int 21h
    
SIGUIENTE_DES:
    inc si ;siguiente caracter
    jmp PROCESAR_DES
    
FIN_DESENCRIPTADO:
    lea dx, presione_tecla
    mov ah, 09h
    int 21h
    mov ah, 01h ;esperar tecla
    int 21h
    jmp MOSTRAR_MENU

;===============================================================

SALIR:
    lea dx, msg_salida
    mov ah, 09h ;imprimir cadena
    int 21h
    
    mov ah, 4Ch ;terminar programa
    int 21h

END INICIO
