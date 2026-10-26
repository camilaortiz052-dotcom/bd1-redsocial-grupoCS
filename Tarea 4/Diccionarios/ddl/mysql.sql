CREATE TABLE estudiante (
id_estudiante INT AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
correo VARCHAR(150) NOT NULL,
password_hash VARCHAR(255) NOT NULL,
fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_estudiante
PRIMARY KEY (id_estudiante),
CONSTRAINT uq_estudiante_correo
UNIQUE (correo)
);
-- ==========================================
-- 2. TABLA PERFIL
-- ==========================================
CREATE TABLE perfil (
id_perfil INT AUTO_INCREMENT,
id_estudiante INT NOT NULL,
biografia TEXT,
auditoria_navegacion JSON, -- Tipo JSON estándar en MySQL
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
id_evento INT AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
geolocalizacion JSON, -- Tipo JSON estándar en MySQL
CONSTRAINT pk_evento
PRIMARY KEY (id_evento)
);
-- ==========================================
-- 4. TABLA PUBLICACION
-- ==========================================
CREATE TABLE publicacion (
id_publicacion INT AUTO_INCREMENT,
id_estudiante INT NOT NULL,
id_evento INT NULL, -- Puede ser NULL si una publicación no pertenece a un evento
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
REFERENCES evento(id_evento)
ON UPDATE CASCADE
ON DELETE SET NULL
);
-- ==========================================
-- 5. TABLA GRUPO
-- ==========================================
CREATE TABLE grupo (
id_grupo INT AUTO_INCREMENT,
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
fecha_union DATE DEFAULT (CURRENT_DATE), -- Sintaxis compatible con MySQL moderno
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
