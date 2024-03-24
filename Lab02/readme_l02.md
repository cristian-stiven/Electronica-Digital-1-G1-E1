# Laboratorio 2

## Regla udev para el USB-blaster de la FPGA

Seguimos los pasos muy cuidadosamente e incluso con la ayuda del profesor. Una vez seguido estos pasos, la regla udev debería permitir el acceso al USB-Blaster . Ahora se pudo intentar reconectar el USB-Blaster y verificar su funcionamiento correctamente.

## Implementación del sumador de 1 bit para instanciar uno de 4 bits

Definimos un sumador de 1 bit y luego utilizamos cuatro instancias de este sumador de 1 bit para construir un sumador de 4 bits.

Pasos:

1. Definimos el sumador de 1 bit (sum1b) con las entradas a, b y ci, y las salidas s y co.
2. Luego, instanciaste cuatro copias de este sumador de 1 bit (sum1b) en tu sumador de 4 bits (sum4b). Cada instancia toma las entradas correspondientes de los bits de A y B, así como la salida ci de la instancia anterior y proporciona la salida s correspondiente para el bit correspondiente de la suma, y una salida co que se propaga al siguiente sumador.

## Anexos de entregables del laboratorio 2

### Videos de funcionamiento

- [Video del sumador de 1 bit](enlace1)
- [Video del sumador de 4 bits](enlace2)

### Imágenes

1. Sumador de 1 bit,
- ![Sumador de 1 bit](Imagenes/sum1bit.png)

2. sumador de 4 bit.
- ![Sumador de 4 bits](Imagenes/sum4bit.png)

### Capturas de pantalla de la simulación

1. Simulacion de la suma de 4 bit
- ![Simulación](Imagenes/simulacion.png)
