PRACTICAS COMPLETAS + AppHub Portafolio + Kit Offline

El repositorio contiene la serie de prácticas realizadas a lo largo del 1er parcial junto con el proyecto final. La aplicación centraliza todas las prácticas y contiene el Kit Offline con 4 módulos: -Notas rápidas -Calculadora IMC
-Galería local -Juego Par o Impar

Todo el estado se maneja en memoria, sin APIs ni persistencia externa. La app incluye navegación centralizada, el tema claro/oscuro y el feedback visual con SnackBars y Dialogs. Funcionalidades principales Hub Principal (Dashboard)

Tarjetas hacia:

-Índice de Prácticas -Kit Offline (índice de los 4 módulos) -Ajustes (tema / acerca de)

El Drawer es accesible en todas las pantallas

Kit Offline -Notas rápidas: lista en memoria, FAB para agregar, botón borrar todo, SnackBar al agregar/borrar -Calculadora IMC: form con validación, calcular IMC y categoría, limpiar campos -Galería local: GridView de assets/images/, AlertDialog con vista ampliada -Juego Par o Impar: usuario vs CPU, marcador, SnackBar con resultado, botón reiniciar -Tema

Cambio de tema de Claro - oscuro en memoria con SwitchListTile

Aplicado a toda la interfaz (cajas, fondos, textos, cards)

Estructura del proyecto /Practicas /practica /assets /images OnePiece1.png OnePiece2.png OnePiece3.png /lib main.dart ajustes.dart app_data.dart kit_index.dart practicas_index.dart /practicas practica1.dart practica2.dart practica4.dart practica5.dart practices_index.dart /kitoffline gallery.dart imc.dart notas.dart par_impar.dart README.md

Cómo ejecutar el proyecto

Clona el repositorio:

git clone Navega al directorio del proyecto:

cd flutter_application_4_copia

Abre el archivo lib/main.dart en tu editor de código preferido.

Asegúrate de tener Flutter instalado y el emulador/dispositivo listo.

Para su ejecución es necesario escribir el comando flutter run en una terminal de VS/CODE

Tecnologías utilizadas

Flutter: framework para desarrollo de apps multiplataforma

Dart: lenguaje de programación principal Autor Zárate Galván Owen Jesús
