# Proyecto Final Electronica-Digital-1.

## Prototipo de seguridad hogar inteligente

Para la elaboracion del proyecto se escogio en mutuo acuerdo con mi compañero y yo la segunda opcion de las cuatros predispuestas por el profesor (Prototipo de seguridad de casa inteligente) los cuales los requerimientos y los objetivos del proyecto los pueden encontrar en:
*https://github.com/jharamirezma/Electronica-digital-1-2024-1/blob/main/Laboratorios/Proyecto/Proyecto.md#2-prototipo-de-control-y-seguridad-hogar-inteligente*.

Se utilizaron los siguientes componentes electronicos:

- Modulo bluethooth.
- Sensor de movimiento SR602.
- Leds.
- Circuito integrado L293D.
- Miniprotoboard.
- Moto vibrador miniatura.
  
El proceso de fabricacion se comenzo haciendo con una lluvia de ideas la cual se obtuvo como resultado la estructura general del proyecto, y los modulos los cuales se iban a utilizar, por consiguiente dividimos el trabajo por modulo ya que se iba a obtener mayor eficiencia del trabajo, pero por el contrario no se obtuvo un buen rendimiento individual por complicaciones en la delegacion del proyecto.

Al diseñar el circuito del motor se encontro un error en la alimentacion ya que la tarjeta brinda la tension necesaria para el motor escogido al principio del proyecto(necesita 8 V para un correcto funcionamiento) por lo cual se decidio escoger un circuito subsecuente el cual iba contener dos relés uno para cada direccion este iba a tener una alimentacion aparte brindada por una pila de 9 V. Antes de probar su funcionamiento verificamos si teoricamente se iba hacer una buena interconeccion entre la FPGA y los reles haciendo esta prueba se encontro que los relés debian ser del mismo valor de la alimentacion que nos brinda la salida de la FPGA en este caso 3V se intento conseguir de ese valor pero desafortunadamente no era un valor comercial, La solucion para ello fue cambiar de motor a un moto vibrador miniatura el cual funciona a la perfeccion con los 3 V de la tarjeta FPGA.


### Diagrama de procesos
![Diagrama de flujo proceso codigo implementado](Imagenes/DiagramaFlujo.png)

En la anterior imagen se detalla el funcionamiento del proyecto en un esquema de bloques en el cual explicare con mas brevedad.

- Modulo Controlador (House.v.): Es el encargado de recibir las tareas y redistribuirlas en los diferentes modulos.
- Modulo Bluethooth Recepcion (BTr.v.): Es el encargado de recibir los datos desde la aplicacion a la FPGA y transmitirlo al modulo controlador.
- Modulo Bluethooth Transmicion (BTt.v.): Es la que transmite la informacion de la tarjeta FPGA a la aplicacion para saber los estados de los leds y de que ha llegado a un tope de los dos extremos.
- Modulo Motor (Motor.v.): Recibe la Señal del modulo controlador el cual le ordenara girar a la izquierda o a la derecha depende de los datos recibidos.
- Modulo leds (Leds.v.): Recibe ordenes de encendidos o apagados con diferentes secuencias para asi prender con un orden especifico los leds.
- Modulo Movimiento (Move.v.): Detecta movimiento el cual activara una señal que se enviara a la tarjeta FPGA para asi activar un buzzer (actua como intermediario).

### Diagrama de estados 
![Diagrama de estados](Imagenes/Diagrama.png)


### Aplicacion

Para verificar la ejecucion del codigo se elaboro una aplicacion android con los plugins necesarios para emular el funcionamiento del proyecto por ejemplo en la interfaz del motor hay dos botones los cuales se utilizaran para subir y bajar persianas, en la interfaz de los leds hay tres botones correspondiendo cada uno a un led para asi poder encenderlo. La logica que se utilizo para la aplicacion se demuestra en la siguiente imagen.

![Logica De Aplicacion](Imagenes/LogicaDeAplicacion.jpeg)

Despues de verificar la logica de la aplicacion se desarrollo una interfaz basica la cual servira solo para implementar el proyecto y esto se visualizaria asi:

![Interfaz de la aplicacion](Imagenes/Programa2.jpeg)

### Simulaciones

#### Modulo Motor:
![Simulacion de Motor](Imagenes/TestBenchMotor.jpeg)

En la simulacion estan actuando 6 señales principales las cuales la primera de ellas es el reloj para activar motor UP y DOWN se hace con los flancos de subida de la señal cmd [1:0] la cual viene desde la aplicacion, las señales de TopeA y TopeB cuando se activan apagan las señales de motor UP y DOWN.

#### Modulo Leds:
![Simulacion de leds](Imagenes/TestBenchLeds.jpeg)

En la imagen se evidencia tres señales principales, el reloj, cmd [2:0] que es la señal que viene desde la aplicacion pasando por el modulo de control y esta activa una señal que prende los leds llamada leds[2:0]

#### Modulo Move:
![Simulacion De Movimiento](Imagenes/TestBenchMovimiento.jpeg)

En el modulo de movimiento  actuan tres señales, el clk que es el reloj, motion_detected que se activa cuando el sensor detecta movimiento y esta el buzzer que es la señal que activara en este caso el parlante que nos indicara que hay un movimiento cerca del sensor para evitar el ruido esta señal se activara despues de 50 ns de constante movimiento.

#### Modulo De Bluethooth transmision:
![Simulacion De Bluethooth](Imagenes/TestBenchMBTt.jpeg)

La simulacion actuan 5 señales sin contar el reloj en ellas,la señal llamada bussy es la encargada de mostrar cuando esta recibiendo una señak para poderla enviar asi que no va recibir mas señales durante ese lapso de tiempo que este activa y ya el data_in [7:0] es la encargada de transmitir a la aplicacion el estador de los leds y la activacion de los topes.

#### Modulo De Bluethooth recepcion:
![Simulacion De Bluethooth](Imagenes/TestBenchMBTr.jpeg)

La simulacion actuan 4 señales sin contar el reloj en ellas se encuentra data_out[7:0] esta se encarga de recibir las ordenes desde la aplicacion como tal no se recibe ninguna orden como se muestra en la simulacion la señal RX es la que se envia al modulo controlador para asi el poderla retransmitir.

