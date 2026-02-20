DELIMITER $$
DROP PROCEDURE IF EXISTS sp_InsertarSede$$
CREATE PROCEDURE sp_InsertarSede(
    IN p_Hospital_Sede VARCHAR(100),
    IN p_Dir_Sede      VARCHAR(150)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_InsertarSede', 'SEDES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    INSERT INTO SEDES (Hospital_Sede, Dir_Sede)
    VALUES (p_Hospital_Sede, p_Dir_Sede);
    SELECT 'Sede insertada correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerSedes$$
CREATE PROCEDURE sp_ObtenerSedes()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerSedes', 'SEDES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT * FROM SEDES;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerSedePorID$$
CREATE PROCEDURE sp_ObtenerSedePorID(
    IN p_Hospital_Sede VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerSedePorID', 'SEDES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT * FROM SEDES WHERE Hospital_Sede = p_Hospital_Sede;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ActualizarSede$$
CREATE PROCEDURE sp_ActualizarSede(
    IN p_Hospital_Sede VARCHAR(100),
    IN p_Dir_Sede      VARCHAR(150)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ActualizarSede', 'SEDES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    UPDATE SEDES SET Dir_Sede = p_Dir_Sede
    WHERE Hospital_Sede = p_Hospital_Sede;
    SELECT 'Sede actualizada correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_EliminarSede$$
CREATE PROCEDURE sp_EliminarSede(
    IN p_Hospital_Sede VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_EliminarSede', 'SEDES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    DELETE FROM SEDES WHERE Hospital_Sede = p_Hospital_Sede;
    SELECT 'Sede eliminada correctamente' AS Resultado;
END$$
DELIMITER ;
-- ============================================================
-- VERIFICAR QUE TODOS LOS SPs SE CREARON
-- ============================================================
SHOW PROCEDURE STATUS WHERE Db = 'hospital_db';

-- ============================================================
-- PRUEBAS SEDES
-- ============================================================

-- INSERT
CALL sp_InsertarSede('Centro Médico', 'Calle 5 #10');
CALL sp_InsertarSede('Clínica Norte', 'Av. Libertador');

-- VER TODOS
CALL sp_ObtenerSedes();

-- VER UNO POR ID
CALL sp_ObtenerSedePorID('Centro Médico');

-- ACTUALIZAR
CALL sp_ActualizarSede('Centro Médico', 'Calle 10 #20');

-- VER EL CAMBIO
CALL sp_ObtenerSedes();