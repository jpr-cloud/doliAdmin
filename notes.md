# Instalación

Para una primera instalación, debe realizar la configuración inicial del complemento. Si acaba de agregar un nuevo servidor de implementación, simplemente edite la configuración del módulo para declarar el nuevo servidor.

En el **Maestro**, solo en la primera instalación:

Conéctese a la interfaz de usuario del servidor maestro de Dolibarr [https://admin.j-cloud.com.mx](https://admin.j-cloud.com.mx):

- Activar el módulo SellYourSaas y Proveedor.
- Cree una cuenta de usuario genérica de Dolibarr con inicio de sesión _**anonymous**_ llamada "Cuenta anónima de SellYourSaas". Esta cuenta se utilizará para acceder a los datos y funciones de Dolibarr cuando un cliente utilice la interfaz pública. Otorgue a este usuario los siguientes permisos y solo los siguientes:

## usuario anonymous

### Módulo de Agenda

- Leer acciones (eventos o tareas) vinculadas a su cuenta de usuario (si es el propietario del evento o lo tiene asignado)
- Crear/modificar acciones (eventos o tareas) vinculadas a su cuenta de usuario (si es propietario del evento)
- Leer acciones (eventos o tareas) de otros
- Crear/modificar acciones (eventos o tareas) de otros

### Módulo Bancos y Caja

- Consultar cuentas financieras (cuentas bancarias, cajas)
- Crear/modificar cantidad/eliminar registros bancarios

### Módulo Etiquetas/Categorías

- Consultar categorías

### Módulo Contratos/Suscripciones

- Consultar contratos/suscripciones
- Crear/modificar contratos/suscripciones
- Activar un servicio/suscripción de un contrato
- Desactivar un servicio/suscripcion de un contrato

### Módulo de Facturas y Notas de Crédito

- Leer facturas de clientes (y pagos)

### Módulo de Vendedores

- Consultar proveedores

### Módulo SellYourSaas

- Read SellYourSaaS data

### Módulo de Servicios

- Consultar servicios

### Módulo de Terceros

- Consultar empresas

### Módulo de Ver Usuarios y Grupos

- Consultar otros usuarios
- Crear/modificar otros usuarios, grupos y permisos
- Crear/modificar su propia info de usuario

## Usuario anonymousbatch

Crear una cuenta de usuario genérica de Dolibarr con inicio de sesión anónimo (anonymousbatch) llamada "Cuenta de SellYourSaas batch" que se utilizará para acciones por lotes. Otorgue a este usuario los siguientes permisos y solo los siguientes:

### Módulo Eventos/Agenda

- Leer acciones (eventos o tareas) vinculadas a su cuenta de usuario (si es el propietario del evento o lo tiene asignado)
- Crear/modificar acciones (eventos o tareas) vinculadas a su cuenta de usuario (si es propietario del evento)
- Leer acciones (eventos o tareas) de otros
- Crear/modificar acciones (eventos o tareas) de otros

### Módulo Bancos y Caja (anonymousbatch)

- Consultar cuentas financieras (cuentas bancarias, cajas)
- Crear/modificar cantidad/eliminar registros bancarios

### Módulo Etiquetas/Categorías (anonymousbatch)

- Consultar categorías

### Módulo Contratos/Suscripciones (anonymousbatch)

- Consultar contratos/suscripciones
- Crear/modificar contratos/suscripciones
- Activar un servicio/suscripción de un contrato
- Desactivar un servicio/suscripcion de un contrato

### Módulo de Facturas

- Leer facturas de clientes (y pagos)
- Crear/Modificar facturas
- Emitir pagos de facturas

### Módulo de Vendedores

- Consultar proveedores

### Módulo SellYourSaas

- Read SellYourSaaS data

### Módulo Servicios

- Consultar servicios

### Módulo de Terceros

- Consultar empresas
- Ampliar el acceso a todos los terceros Y a sus objetos (no sólo a los terceros a los que el usuario está vinculado como representante de ventas).

## Otros

- Crear una etiqueta de producto llamada "Productos SaaS"
- Crear una etiqueta de tercero llamada "Clientes SaaS" y "Revendedores SaaS"
- Acceda a la configuración del módulo SellYoursSaas y configure al menos los siguientes campos obligatorios:

- Nombre de su servicio Saas: J-Cloud SaaS
- Nombre del dominio principal: j-cloud.com.mx
- Correo electrónico principal: info@jpyrsa.mx
- E-mail de supervisión (para anomalias): soporte@jpyrsa.mx
- E-mail No reply: noreply@jpyrsa.mx
- Url de cuentas de clientes: https://myaccount.j-cloud.com.mx
- Página de inicio de los precios de las aplicaciones: https://myaccount.j-cloud.com.mx/prices.html
- Usuario anónimo: *Cuenta anónima de SellYourSaas*

## Cree un paquete para configurar las aplicaciones que se implementarán (archivos, configuración, volcado de base de datos, etc.).

Consulte el capítulo "Configuración de paquetes" más adelante.

## Cree un servicio de tipo Aplicación para definir el precio de una suscripción y seleccione el paquete de la aplicación.

Consulte "Configuración de servicios" para obtener una descripción de los campos.

## Cree servicios de tipo Métrica si lo desea.

Consulte "Configuración de servicios" para obtener una descripción de los campos.

## Cree servicios de tipo Opciones si lo desea.

Consulte "Configuración de servicios" para obtener una descripción de los campos.

Nota: Los servicios de tipo Opciones y Métricas deben estar vinculados a un servicio de tipo Aplicación en la pestaña Productos virtuales.

Nota: La URL para implementar paquetes de tipo Aplicación se puede ver en el menú URL de Implementación de SellYourSaas.

Vaya a la configuración del módulo Trabajos programados y busque la instrucción para agregarla al cron del usuario admin. Compruebe que se haya agregado al cron para que los lotes de SellYourSaas puedan ejecutarse. El valor de <securitykeydefinedinscheduledjobsetup> debe coincidir con la configuración del módulo y la línea de comandos del cron.

En el servidor maestro, si instala un nuevo servidor de implementación:

Vaya al menú superior de SellYourSaas, seleccione la pestaña Servidor de implementación e introduzca la lista de su servidor de implementación (subdominio e IP).