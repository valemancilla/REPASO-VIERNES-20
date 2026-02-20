

CREATE DATABASE IF NOT EXISTS Hospital_DB
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE Hospital_DB;

-- ============================================================
-- TABLAS
-- ============================================================

CREATE TABLE IF NOT EXISTS FACULTADES (
    Facultad_Origen  VARCHAR(50)  NOT NULL,
    Decano_Facultad  VARCHAR(100) NOT NULL,
    CONSTRAINT PK_FACULTADES PRIMARY KEY (Facultad_Origen)
);

CREATE TABLE IF NOT EXISTS SEDES (
    Hospital_Sede  VARCHAR(100) NOT NULL,
    Dir_Sede       VARCHAR(150) NOT NULL,
    CONSTRAINT PK_SEDES PRIMARY KEY (Hospital_Sede)
);

CREATE TABLE IF NOT EXISTS PACIENTES (
    Paciente_ID        VARCHAR(10)  NOT NULL,
    Nombre_Paciente    VARCHAR(100) NOT NULL,
    Apellido_Paciente  VARCHAR(100) NOT NULL,
    Telefono_Paciente  VARCHAR(20),
    CONSTRAINT PK_PACIENTES PRIMARY KEY (Paciente_ID)
);

CREATE TABLE IF NOT EXISTS MEDICOS (
    Medico_ID       VARCHAR(10)  NOT NULL,
    Nombre_Medico   VARCHAR(100) NOT NULL,
    Especialidad    VARCHAR(100) NOT NULL,
    Facultad_Origen VARCHAR(50)  NOT NULL,
    CONSTRAINT PK_MEDICOS PRIMARY KEY (Medico_ID),
    CONSTRAINT FK_MEDICOS_FACULTADES
        FOREIGN KEY (Facultad_Origen) REFERENCES FACULTADES(Facultad_Origen)
);

CREATE TABLE IF NOT EXISTS CITAS (
    Cod_Cita      VARCHAR(10)  NOT NULL,
    Fecha_Cita    DATE         NOT NULL,
    Paciente_ID   VARCHAR(10)  NOT NULL,
    Medico_ID     VARCHAR(10)  NOT NULL,
    Diagnostico   VARCHAR(200),
    Hospital_Sede VARCHAR(100) NOT NULL,
    CONSTRAINT PK_CITAS PRIMARY KEY (Cod_Cita),
    CONSTRAINT FK_CITAS_PACIENTES
        FOREIGN KEY (Paciente_ID)   REFERENCES PACIENTES(Paciente_ID),
    CONSTRAINT FK_CITAS_MEDICOS
        FOREIGN KEY (Medico_ID)     REFERENCES MEDICOS(Medico_ID),
    CONSTRAINT FK_CITAS_SEDES
        FOREIGN KEY (Hospital_Sede) REFERENCES SEDES(Hospital_Sede)
);

CREATE TABLE IF NOT EXISTS CITA_MEDICAMENTOS (
    Cod_Cita    VARCHAR(10)  NOT NULL,
    Medicamento VARCHAR(100) NOT NULL,
    Dosis       VARCHAR(20)  NOT NULL,
    CONSTRAINT PK_CITA_MEDICAMENTOS PRIMARY KEY (Cod_Cita, Medicamento),
    CONSTRAINT FK_CITAMED_CITAS
        FOREIGN KEY (Cod_Cita) REFERENCES CITAS(Cod_Cita)
);


CREATE TABLE IF NOT EXISTS LOGS_ERRORES (
    Log_ID        INT          NOT NULL AUTO_INCREMENT,
    Nombre_Rutina VARCHAR(100) NOT NULL,
    Nombre_Tabla  VARCHAR(100) NOT NULL,
    Codigo_Error  VARCHAR(10)  NOT NULL,
    Mensaje_Error VARCHAR(500) NOT NULL,
    Fecha_Hora    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_LOGS PRIMARY KEY (Log_ID)
);

INSERT IGNORE INTO FACULTADES (Facultad_Origen, Decano_Facultad) VALUES
    ('Medicina', 'Dr. Wilson'),
    ('Ciencias', 'Dr. Palmer');

INSERT IGNORE INTO SEDES (Hospital_Sede, Dir_Sede) VALUES
    ('Centro Médico', 'Calle 5 #10'),
    ('Clínica Norte', 'Av. Libertador');

INSERT IGNORE INTO PACIENTES (Paciente_ID, Nombre_Paciente, Apellido_Paciente, Telefono_Paciente) VALUES
    ('P-501', 'Juan', 'Rivas', '600-111'),
    ('P-502', 'Ana',  'Soto',  '600-222'),
    ('P-503', 'Luis', 'Paz',   '600-333');

INSERT IGNORE INTO MEDICOS (Medico_ID, Nombre_Medico, Especialidad, Facultad_Origen) VALUES
    ('M-10', 'Dr. House',   'Infectología', 'Medicina'),
    ('M-22', 'Dra. Grey',   'Cardiología',  'Medicina'),
    ('M-30', 'Dr. Strange', 'Neurocirugía', 'Ciencias');

INSERT IGNORE INTO CITAS (Cod_Cita, Fecha_Cita, Paciente_ID, Medico_ID, Diagnostico, Hospital_Sede) VALUES
    ('C-001', '2024-05-01', 'P-501', 'M-10', 'Gripe Fuerte', 'Centro Médico'),
    ('C-002', '2024-05-02', 'P-502', 'M-10', 'Infección',    'Centro Médico'),
    ('C-003', '2024-05-03', 'P-501', 'M-22', 'Arritmia',     'Clínica Norte'),
    ('C-004', '2024-05-06', 'P-503', 'M-30', 'Migraña',      'Clínica Norte');

INSERT IGNORE INTO CITA_MEDICAMENTOS (Cod_Cita, Medicamento, Dosis) VALUES
    ('C-001', 'Paracetamol', '500mg'),
    ('C-001', 'Ibuprofeno',  '400mg'),
    ('C-002', 'Amoxicilina', '875mg'),
    ('C-003', 'Aspirina',    '100mg'),
    ('C-004', 'Ergotamina',  '1mg');