DELIMITER $$
DROP PROCEDURE IF EXISTS sp_InsertarPaciente$$
CREATE PROCEDURE sp_InsertarPaciente(
    IN p_Paciente_ID       VARCHAR(10),
    IN p_Nombre_Paciente   VARCHAR(100),
    IN p_Apellido_Paciente VARCHAR(100),
    IN p_Telefono_Paciente VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_InsertarPaciente', 'PACIENTES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    INSERT INTO PACIENTES (Paciente_ID, Nombre_Paciente, Apellido_Paciente, Telefono_Paciente)
    VALUES (p_Paciente_ID, p_Nombre_Paciente, p_Apellido_Paciente, p_Telefono_Paciente);
    SELECT 'Paciente insertado correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerPacientes$$
CREATE PROCEDURE sp_ObtenerPacientes()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerPacientes', 'PACIENTES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT * FROM PACIENTES;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerPacientePorID$$
CREATE PROCEDURE sp_ObtenerPacientePorID(
    IN p_Paciente_ID VARCHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerPacientePorID', 'PACIENTES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT * FROM PACIENTES WHERE Paciente_ID = p_Paciente_ID;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ActualizarPaciente$$
CREATE PROCEDURE sp_ActualizarPaciente(
    IN p_Paciente_ID       VARCHAR(10),
    IN p_Nombre_Paciente   VARCHAR(100),
    IN p_Apellido_Paciente VARCHAR(100),
    IN p_Telefono_Paciente VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ActualizarPaciente', 'PACIENTES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    UPDATE PACIENTES
    SET Nombre_Paciente   = p_Nombre_Paciente,
        Apellido_Paciente = p_Apellido_Paciente,
        Telefono_Paciente = p_Telefono_Paciente
    WHERE Paciente_ID = p_Paciente_ID;
    SELECT 'Paciente actualizado correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_EliminarPaciente$$
CREATE PROCEDURE sp_EliminarPaciente(
    IN p_Paciente_ID VARCHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_EliminarPaciente', 'PACIENTES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    DELETE FROM PACIENTES WHERE Paciente_ID = p_Paciente_ID;
    SELECT 'Paciente eliminado correctamente' AS Resultado;
END$$
DELIMITER ;
-- ============================================================
-- VERIFICAR QUE TODOS LOS SPs SE CREARON
-- ============================================================
SHOW PROCEDURE STATUS WHERE Db = 'hospital_db';

-- ============================================================
-- PRUEBAS PACIENTES
-- ============================================================

-- INSERT
CALL sp_InsertarPaciente('P-501', 'Juan', 'Rivas', '600-111');
CALL sp_InsertarPaciente('P-502', 'Ana',  'Soto',  '600-222');
CALL sp_InsertarPaciente('P-503', 'Luis', 'Paz',   '600-333');

-- VER TODOS
CALL sp_ObtenerPacientes();

-- VER UNO POR ID
CALL sp_ObtenerPacientePorID('P-501');

-- ACTUALIZAR
CALL sp_ActualizarPaciente('P-501', 'Juan Carlos', 'Rivas', '600-999');

-- VER EL CAMBIO
CALL sp_ObtenerPacientePorID('P-501');