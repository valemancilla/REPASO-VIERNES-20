DELIMITER $$
DROP PROCEDURE IF EXISTS sp_InsertarFacultad$$
CREATE PROCEDURE sp_InsertarFacultad(
    IN p_Facultad_Origen VARCHAR(50),
    IN p_Decano_Facultad VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_InsertarFacultad', 'FACULTADES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    INSERT INTO FACULTADES (Facultad_Origen, Decano_Facultad)
    VALUES (p_Facultad_Origen, p_Decano_Facultad);
    SELECT 'Facultad insertada correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerFacultades$$
CREATE PROCEDURE sp_ObtenerFacultades()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerFacultades', 'FACULTADES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT * FROM FACULTADES;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerFacultadPorID$$
CREATE PROCEDURE sp_ObtenerFacultadPorID(
    IN p_Facultad_Origen VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerFacultadPorID', 'FACULTADES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT * FROM FACULTADES WHERE Facultad_Origen = p_Facultad_Origen;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ActualizarFacultad$$
CREATE PROCEDURE sp_ActualizarFacultad(
    IN p_Facultad_Origen VARCHAR(50),
    IN p_Decano_Facultad VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ActualizarFacultad', 'FACULTADES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    UPDATE FACULTADES
    SET Decano_Facultad = p_Decano_Facultad
    WHERE Facultad_Origen = p_Facultad_Origen;
    SELECT 'Facultad actualizada correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_EliminarFacultad$$
CREATE PROCEDURE sp_EliminarFacultad(
    IN p_Facultad_Origen VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_EliminarFacultad', 'FACULTADES', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    DELETE FROM FACULTADES WHERE Facultad_Origen = p_Facultad_Origen;
    SELECT 'Facultad eliminada correctamente' AS Resultado;
END$$
DELIMITER ;

-- ============================================================
-- VERIFICAR QUE TODOS LOS SPs SE CREARON
-- ============================================================
SHOW PROCEDURE STATUS WHERE Db = 'hospital_db';

-- ============================================================
-- PRUEBAS FACULTADES
-- ============================================================

-- INSERT
CALL sp_InsertarFacultad('Medicina', 'Dr. Wilson');
CALL sp_InsertarFacultad('Ciencias', 'Dr. Palmer');

-- VER TODOS
CALL sp_ObtenerFacultades();

-- VER UNO POR ID
CALL sp_ObtenerFacultadPorID('Medicina');

-- ACTUALIZAR
CALL sp_ActualizarFacultad('Medicina', 'Dr. House');

-- VER EL CAMBIO
CALL sp_ObtenerFacultades();