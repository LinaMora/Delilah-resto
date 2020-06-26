Hola.  
La idea de esta Api es lograr administrar los pedidos de un restaurante.


Si vas a descargar el proyecto desde git estos son los comandos que debes ingresar en la consola: 
git cd desktop
git clone https://github.com/LinaMora/Delilah-resto.git


Dentro de la carpeta "Resources" encontraras los siguientes archivos:
    -CreateRestoDB. 
    contiene los queries para la creación de la base de datos. (puedes arrastrar el archivo a mySQL)

    -defaultDataResto. 
    Agrega algunos productos y un usuario con rol de administrador a la base de datos antes creada

    -swagger. 
    Es el archivo swagger en donde podrás encontrar la documentación de la Api.

    Por  último este es el link al repositorio del proyecto en GitHub. (También se encuentra en la documentación). 
    https://github.com/LinaMora/Delilah-resto.git


Como ultima configuracion solo debes de editar ruta de coneccion a la base de datos. 
la ruta la encontrarás en el archivo ‘Network/queries.js’ en la línea cuatro. Encontrarás un ejemplo en la línea anterior.

user: Usuario de conexión 
password: Contraseña asignada 
host: Dominio o IP donde corre MySQL 
port: Puerto donde escucha MySQL 
database: Nombre de base de datos

Después de la configuración de la ruta iniciamos el servidor con los siguientes comandos en la terminal de visual studio code.

npm install
importa todas las dependencias necesarias (que están en el archivo  package.json).

node index.js
hacer correr el archivo. ya podrás acceder al servidor
