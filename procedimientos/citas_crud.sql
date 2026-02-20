DELIMITER $$
DROP PROCEDURE IF EXISTS sp_InsertarCita$$
CREATE PROCEDURE sp_InsertarCita(
    IN p_Cod_Cita      VARCHAR(10),
    IN p_Fecha_Cita    DATE,
    IN p_Paciente_ID   VARCHAR(10),
    IN p_Medico_ID     VARCHAR(10),
    IN p_Diagnostico   VARCHAR(200),
    IN p_Hospital_Sede VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_InsertarCita', 'CITAS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    INSERT INTO CITAS (Cod_Cita, Fecha_Cita, Paciente_ID, Medico_ID, Diagnostico, Hospital_Sede)
    VALUES (p_Cod_Cita, p_Fecha_Cita, p_Paciente_ID, p_Medico_ID, p_Diagnostico, p_Hospital_Sede);
    SELECT 'Cita insertada correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerCitas$$
CREATE PROCEDURE sp_ObtenerCitas()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerCitas', 'CITAS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT
        c.Cod_Cita,
        c.Fecha_Cita,
        c.Paciente_ID,
        CONCAT(p.Nombre_Paciente,' ',p.Apellido_Paciente) AS Nombre_Completo_Paciente,
        c.Medico_ID,
        m.Nombre_Medico,
        m.Especialidad,
        c.Diagnostico,
        c.Hospital_Sede,
        s.Dir_Sede
    FROM CITAS c
    INNER JOIN PACIENTES p ON c.Paciente_ID   = p.Paciente_ID
    INNER JOIN MEDICOS   m ON c.Medico_ID     = m.Medico_ID
    INNER JOIN SEDES     s ON c.Hospital_Sede = s.Hospital_Sede;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerCitaPorID$$
CREATE PROCEDURE sp_ObtenerCitaPorID(
    IN p_Cod_Cita VARCHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerCitaPorID', 'CITAS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT
        c.Cod_Cita,
        c.Fecha_Cita,
        c.Paciente_ID,
        CONCAT(p.Nombre_Paciente,' ',p.Apellido_Paciente) AS Nombre_Completo_Paciente,
        c.Medico_ID,
        m.Nombre_Medico,
        m.Especialidad,
        c.Diagnostico,
        c.Hospital_Sede,
        s.Dir_Sede
    FROM CITAS c
    INNER JOIN PACIENTES p ON c.Paciente_ID   = p.Paciente_ID
    INNER JOIN MEDICOS   m ON c.Medico_ID     = m.Medico_ID
    INNER JOIN SEDES     s ON c.Hospital_Sede = s.Hospital_Sede
    WHERE c.Cod_Cita = p_Cod_Cita;
END$$

DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ActualizarCita$$
CREATE PROCEDURE sp_ActualizarCita(
    IN p_Cod_Cita      VARCHAR(10),
    IN p_Fecha_Cita    DATE,
    IN p_Paciente_ID   VARCHAR(10),
    IN p_Medico_ID     VARCHAR(10),
    IN p_Diagnostico   VARCHAR(200),
    IN p_Hospital_Sede VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ActualizarCita', 'CITAS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    UPDATE CITAS
    SET Fecha_Cita    = p_Fecha_Cita,
        Paciente_ID   = p_Paciente_ID,
        Medico_ID     = p_Medico_ID,
        Diagnostico   = p_Diagnostico,
        Hospital_Sede = p_Hospital_Sede
    WHERE Cod_Cita = p_Cod_Cita;
    SELECT 'Cita actualizada correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_EliminarCita$$
CREATE PROCEDURE sp_EliminarCita(
    IN p_Cod_Cita VARCHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_EliminarCita', 'CITAS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    DELETE FROM CITA_MEDICAMENTOS WHERE Cod_Cita = p_Cod_Cita;
    DELETE FROM CITAS WHERE Cod_Cita = p_Cod_Cita;
    SELECT 'Cita y medicamentos eliminados correctamente' AS Resultado;
END$$
DELIMITER ;

-- ============================================================
-- VERIFICAR QUE TODOS LOS SPs SE CREARON
-- ============================================================
SHOW PROCEDURE STATUS WHERE Db = 'hospital_db';

-- ============================================================
-- PRUEBAS CITAS
-- ============================================================

-- INSERT
CALL sp_InsertarCita('C-001', '2024-05-01', 'P-501', 'M-10', 'Gripe Fuerte', 'Centro Médico');
CALL sp_InsertarCita('C-002', '2024-05-02', 'P-502', 'M-10', 'Infección',    'Centro Médico');
CALL sp_InsertarCita('C-003', '2024-05-03', 'P-501', 'M-22', 'Arritmia',     'Clínica Norte');
CALL sp_InsertarCita('C-004', '2024-05-06', 'P-503', 'M-30', 'Migraña',      'Clínica Norte');

-- VER TODOS (con JOIN a PACIENTES, MEDICOS, SEDES)
CALL sp_ObtenerCitas();

-- VER UNO POR ID
CALL sp_ObtenerCitaPorID('C-001');

-- ACTUALIZAR
CALL sp_ActualizarCita('C-001', '2024-05-01', 'P-501', 'M-10', 'Gripe Severa', 'Centro Médico');

-- VER EL CAMBIO
CALL sp_ObtenerCitaPorID('C-001');