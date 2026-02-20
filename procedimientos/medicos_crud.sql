DELIMITER $$
DROP PROCEDURE IF EXISTS sp_InsertarMedico$$
CREATE PROCEDURE sp_InsertarMedico(
    IN p_Medico_ID       VARCHAR(10),
    IN p_Nombre_Medico   VARCHAR(100),
    IN p_Especialidad    VARCHAR(100),
    IN p_Facultad_Origen VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_InsertarMedico', 'MEDICOS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    INSERT INTO MEDICOS (Medico_ID, Nombre_Medico, Especialidad, Facultad_Origen)
    VALUES (p_Medico_ID, p_Nombre_Medico, p_Especialidad, p_Facultad_Origen);
    SELECT 'Médico insertado correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerMedicos$$
CREATE PROCEDURE sp_ObtenerMedicos()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerMedicos', 'MEDICOS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT m.Medico_ID, m.Nombre_Medico, m.Especialidad,
           m.Facultad_Origen, f.Decano_Facultad
    FROM MEDICOS m
    INNER JOIN FACULTADES f ON m.Facultad_Origen = f.Facultad_Origen;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerMedicoPorID$$
CREATE PROCEDURE sp_ObtenerMedicoPorID(
    IN p_Medico_ID VARCHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerMedicoPorID', 'MEDICOS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT m.Medico_ID, m.Nombre_Medico, m.Especialidad,
           m.Facultad_Origen, f.Decano_Facultad
    FROM MEDICOS m
    INNER JOIN FACULTADES f ON m.Facultad_Origen = f.Facultad_Origen
    WHERE m.Medico_ID = p_Medico_ID;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ActualizarMedico$$
CREATE PROCEDURE sp_ActualizarMedico(
    IN p_Medico_ID       VARCHAR(10),
    IN p_Nombre_Medico   VARCHAR(100),
    IN p_Especialidad    VARCHAR(100),
    IN p_Facultad_Origen VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ActualizarMedico', 'MEDICOS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    UPDATE MEDICOS
    SET Nombre_Medico   = p_Nombre_Medico,
        Especialidad    = p_Especialidad,
        Facultad_Origen = p_Facultad_Origen
    WHERE Medico_ID = p_Medico_ID;
    SELECT 'Médico actualizado correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_EliminarMedico$$
CREATE PROCEDURE sp_EliminarMedico(
    IN p_Medico_ID VARCHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_EliminarMedico', 'MEDICOS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    DELETE FROM MEDICOS WHERE Medico_ID = p_Medico_ID;
    SELECT 'Médico eliminado correctamente' AS Resultado;
END$$
DELIMITER ;

-- ============================================================
-- VERIFICAR QUE TODOS LOS SPs SE CREARON
-- ============================================================
SHOW PROCEDURE STATUS WHERE Db = 'hospital_db';

-- ============================================================
-- PRUEBAS MEDICOS
-- ============================================================

-- INSERT
CALL sp_InsertarMedico('M-10', 'Dr. House',   'Infectología', 'Medicina');
CALL sp_InsertarMedico('M-22', 'Dra. Grey',   'Cardiología',  'Medicina');
CALL sp_InsertarMedico('M-30', 'Dr. Strange', 'Neurocirugía', 'Ciencias');

-- VER TODOS (con JOIN a FACULTADES)
CALL sp_ObtenerMedicos();

-- VER UNO POR ID
CALL sp_ObtenerMedicoPorID('M-10');

-- ACTUALIZAR
CALL sp_ActualizarMedico('M-10', 'Dr. House', 'Neurología', 'Ciencias');

-- VER EL CAMBIO
CALL sp_ObtenerMedicoPorID('M-10');