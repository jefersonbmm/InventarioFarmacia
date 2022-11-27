--Crear BD
create database FarmaUZIEL

-- Crear copia
backup database FarmaUZIEL to disk = 'R:\USER TOLEDO\Documents\RESPALDO USB RICARDO\Documentos\UNI\II AÑO - II SEMESTRE\Base de Datos I\Trabajo Base de Datos\Backups\FarmaUZIEL.bak'

-- Restaurar copia
restore database FarmaUZIEL from disk = 'E:\Trabajo Base de Datos\Backups\FarmaUZIEL.bak' with replace