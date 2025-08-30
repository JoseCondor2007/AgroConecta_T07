# Dockerfile para SQL Server 2022 Developer Edition
# Usa la imagen oficial de Microsoft SQL Server desde Docker Hub.
FROM mcr.microsoft.com/mssql/server:2022-latest

# Configura las variables de entorno para la instalación.
# 'ACCEPT_EULA' es obligatorio para usar la imagen.
ENV ACCEPT_EULA=Y
# 'MSSQL_PID' especifica la edición. 'Developer' es gratuita.
ENV MSSQL_PID=Developer
# 'SA_PASSWORD' define la contraseña de la cuenta 'sa'.
# ¡ADVERTENCIA! Cambia esta contraseña a una que cumpla los requisitos de seguridad.
ENV SA_PASSWORD="Team07"

# Exponer el puerto por defecto de SQL Server para conexiones externas.
EXPOSE 1433

# Comando para iniciar el servidor de SQL Server al arrancar el contenedor.
CMD ["/opt/mssql/bin/sqlservr"]
