CREATE TABLE estudiante (
id_estudiante INT IDENTITY(1,1),
nombre VARCHAR(100) NOT NULL,
correo VARCHAR(150) NOT NULL,
password_hash VARCHAR(255) NOT NULL,
fecha_registro DATETIME DEFAULT GETDATE(),
CONSTRAINT pk_estudiante
PRIMARY KEY (id_estudiante),
CONSTRAINT uq_estudiante_correo
UNIQUE (correo)
);
-- ==========================================
-- 2. TABLA PERFIL
-- ==========================================
CREATE TABLE perfil (
id_perfil INT IDENTITY(1,1),
id_estudiante INT NOT NULL,
biografia TEXT,
auditoria_navegacion NVARCHAR(MAX), -- Tipo recomendado para guardar JSON en SQL Server
CONSTRAINT pk_perfil
PRIMARY KEY (id_perfil),
CONSTRAINT fk_perfil_estudiante
FOREIGN KEY (id_estudiante)
REFERENCES estudiante(id_estudiante)
ON UPDATE CASCADE
ON DELETE CASCADE,
-- Restricción para asegurar que solo se guarde JSON válido
CONSTRAINT chk_perfil_auditoria
CHECK (ISJSON(auditoria_navegacion) > 0)
);
-- ==========================================
-- 3. TABLA EVENTO
-- ==========================================
CREATE TABLE evento (
id_evento INT IDENTITY(1,1),
nombre VARCHAR(100) NOT NULL,
geolocalizacion NVARCHAR(MAX), -- Tipo recomendado para guardar JSON en SQL Server
CONSTRAINT pk_evento
PRIMARY KEY (id_evento),
-- Restricción para asegurar que solo se guarde JSON válido
CONSTRAINT chk_evento_geolocalizacion
CHECK (ISJSON(geolocalizacion) > 0)
);
-- ==========================================
-- 4. TABLA PUBLICACION
-- ==========================================
CREATE TABLE publicacion (
id_publicacion INT IDENTITY(1,1),
id_estudiante INT NOT NULL,
id_evento INT NULL, -- Puede ser NULL si una publicación no pertenece a un evento
contenido TEXT NOT NULL,
fecha_publicacion DATETIME DEFAULT GETDATE(),
CONSTRAINT pk_publicacion
PRIMARY KEY (id_publicacion),
CONSTRAINT fk_publicacion_estudiante
FOREIGN KEY (id_estudiante)
REFERENCES estudiante(id_estudiante)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT fk_publicacion_evento
FOREIGN KEY (id_evento)
REFERENCES evento(id_evento)
ON UPDATE NO ACTION -- SQL Server requiere NO ACTION para evitar múltiples rutas en cascada
ON DELETE SET NULL
);
-- ==========================================
-- 5. TABLA GRUPO
-- ==========================================
CREATE TABLE grupo (
id_grupo INT IDENTITY(1,1),
nombre VARCHAR(100) NOT NULL,
descripcion TEXT,
id_creador INT NOT NULL,
CONSTRAINT pk_grupo
PRIMARY KEY (id_grupo),
CONSTRAINT fk_grupo_estudiante
FOREIGN KEY (id_creador)
REFERENCES estudiante(id_estudiante)
ON UPDATE NO ACTION
ON DELETE NO ACTION
);
-- ==========================================
-- 6. TABLA MIEMBRO_GRUPO
-- ==========================================
CREATE TABLE miembro_grupo (
id_estudiante INT NOT NULL,
id_grupo INT NOT NULL,
fecha_union DATE DEFAULT CAST(GETDATE() AS DATE),
CONSTRAINT pk_miembro_grupo
PRIMARY KEY (id_estudiante, id_grupo),
CONSTRAINT fk_miembro_grupo_estudiante
FOREIGN KEY (id_estudiante)
REFERENCES estudiante(id_estudiante)
ON UPDATE NO ACTION
ON DELETE NO ACTION,
CONSTRAINT fk_miembro_grupo_grupo
FOREIGN KEY (id_grupo)
REFERENCES grupo(id_grupo)
ON UPDATE NO ACTION
ON DELETE NO ACTION
