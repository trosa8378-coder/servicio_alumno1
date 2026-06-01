# 1. Usar la imagen oficial de .NET para compilar el código
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar los archivos del proyecto y restaurar las dependencias
COPY *.csproj ./
RUN dotnet restore

# Copiar el resto del código y compilar en modo producción
COPY . ./
RUN dotnet publish -c Release -o out

# 2. Crear la imagen final de producción, más ligera
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Exponer el puerto en el que escuchará el servicio en la nube
EXPOSE 80

ENTRYPOINT ["dotnet", "servicio_alumno1"]