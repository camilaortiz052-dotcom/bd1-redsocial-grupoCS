CREATE TABLE estudiante (
id_estudiante SERIAL,
nombre VARCHAR(100) NOT NULL,
correo VARCHAR(150) NOT NULL UNIQUE,
password_hash VARCHAR(255) NOT NULL,
fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_estudiante
PRIMARY KEY (id_estudiante)
);
-- ==========================================
-- 2. TABLA PERFIL
-- ==========================================
CREATE TABLE perfil (
id_perfil SERIAL,
id_estudiante INT NOT NULL,
biografia TEXT,
auditoria_navegacion JSONB,
CONSTRAINT pk_perfil
PRIMARY KEY (id_perfil),
CONSTRAINT fk_perfil_estudiante
FOREIGN KEY (id_estudiante)
REFERENCES estudiante(id_estudiante)
ON UPDATE CASCADE
ON DELETE CASCADE
);
-- ==========================================
-- 3. TABLA EVENTO
-- ==========================================
CREATE TABLE evento (
id_evento SERIAL,
nombre VARCHAR(100) NOT NULL,
geolocalizacion JSONB,
CONSTRAINT pk_evento
PRIMARY KEY (id_evento)
);
-- ==========================================
-- 4. TABLA PUBLICACION
-- ==========================================
CREATE TABLE publicacion (
id_publicacion SERIAL,
id_estudiante INT NOT NULL,
id_evento INT, -- Se añade la columna para conectar con evento (puede ser NULL si una publicación no es de un evento)
contenido TEXT NOT NULL,
fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_publicacion
PRIMARY KEY (id_publicacion),
CONSTRAINT fk_publicacion_estudiante
FOREIGN KEY (id_estudiante)
REFERENCES estudiante(id_estudiante)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT fk_publicacion_evento
FOREIGN KEY (id_evento)
REFERENCES evento(id_evento) -- Crea la llave foránea física hacia la tabla evento
ON UPDATE CASCADE
ON DELETE SET NULL
);
-- ==========================================
-- 5. TABLA GRUPO
-- ==========================================
CREATE TABLE grupo (
id_grupo SERIAL,
nombre VARCHAR(100) NOT NULL,
descripcion TEXT,
id_creador INT NOT NULL,
CONSTRAINT pk_grupo
PRIMARY KEY (id_grupo),
CONSTRAINT fk_grupo_estudiante
FOREIGN KEY (id_creador)
REFERENCES estudiante(id_estudiante)
ON UPDATE CASCADE
ON DELETE RESTRICT
);
-- ==========================================
-- 6. TABLA MIEMBRO_GRUPO
-- ==========================================
CREATE TABLE miembro_grupo (
id_estudiante INT NOT NULL,
id_grupo INT NOT NULL,
fecha_union DATE DEFAULT CURRENT_DATE,
CONSTRAINT pk_miembro_grupo
PRIMARY KEY (id_estudiante, id_grupo),
CONSTRAINT fk_miembro_grupo_estudiante
FOREIGN KEY (id_estudiante)
REFERENCES estudiante(id_estudiante)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT fk_miembro_grupo_grupo
FOREIGN KEY (id_grupo)
REFERENCES grupo(id_grupo)
ON UPDATE CASCADE
ON DELETE CASCADE
);
