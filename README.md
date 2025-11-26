# Cifrado César - Assembly x86 (emu8086)

Implementación de un cifrador/descifrador César en lenguaje ensamblador x86, desarrollado como proyecto académico para la materia **Organización de Computadores** (CCPG1049) de ESPOL.

## 📋 Descripción

Programa interactivo que permite al usuario:
- **Cifrar** mensajes de hasta 35 caracteres usando cifrado César
- **Descifrar** mensajes previamente cifrados
- Elegir el desplazamiento (shift) entre 1 y 5 posiciones
- Mantener los espacios en el texto original

## 🚀 Características

- Menú interactivo con validación de entradas
- Soporte para letras mayúsculas, minúsculas y espacios
- Conversión automática de caracteres ASCII
- Manejo de errores en entrada de datos
- Código modular con procedimientos comentados

## 🛠️ Requisitos

- **emu8086** - Emulador de microprocesador 8086
- Sistema operativo: Windows (recomendado para emu8086)

## 📦 Instalación

1. Clonar el repositorio:
```bash
git clone https://github.com/tu-usuario/caesar-cipher-emu8086.git
```

2. Abrir el archivo `.asm` en emu8086

3. Compilar y ejecutar (botón "Emulate" en emu8086)

## 💻 Uso

1. Ejecutar el programa en emu8086
2. Seleccionar opción del menú:
   - `1` - Cifrar texto
   - `2` - Descifrar texto
   - `3` - Salir
3. Ingresar el texto (máximo 35 caracteres)
4. Si cifra: elegir desplazamiento (1-5)
5. Ver resultado en pantalla

## 📝 Ejemplo

**Entrada:** `HOLA MUNDO`  
**Desplazamiento:** `3`  
**Salida cifrada:** `KROD PXQGR`

## 🏗️ Estructura del Código

- **Menú principal**: Gestión de opciones del usuario
- **Procedimiento de cifrado**: Implementación del algoritmo César
- **Procedimiento de descifrado**: Reversión del cifrado
- **Validaciones**: Control de entrada de datos
- **Utilidades**: Conversión ASCII y manipulación de cadenas

## 📚 Algoritmo César

El cifrado César desplaza cada letra del alfabeto un número fijo de posiciones. Por ejemplo, con desplazamiento 3:
- A → D
- B → E
- Z → C (circular)

## 👥 Autores

- [Tu Nombre] - Matrícula
- [Nombre del Compañero] - Matrícula (si aplica)

**Institución:** Escuela Superior Politécnica del Litoral (ESPOL)  
**Materia:** Organización de Computadores (CCPG1049)  
**Periodo:** 2025-2

## 📄 Licencia

Este proyecto es de carácter académico. Desarrollado para fines educativos.

## 🔗 Referencias

- [Caesar Cipher Visualizer](https://caesar-cipher.com/)
- [emu8086 Documentation](http://www.emu8086.com/)
- Documentación del curso CCPG1049 - ESPOL

## 📸 Capturas de Pantalla

[Aquí incluirás las capturas cuando tengas el programa funcionando]

---

**Nota:** Este proyecto fue desarrollado como parte de la primera evaluación del curso de Organización de Computadores, cumpliendo con los requisitos especificados en el documento del proyecto.
```

---

## 🎯 Tips adicionales:

1. **`.gitignore`** - Crea uno para excluir archivos temporales de emu8086:
```
*.exe
*.obj
*.lst
*.bin
~*
