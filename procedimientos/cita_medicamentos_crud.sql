DELIMITER $$
DROP PROCEDURE IF EXISTS sp_InsertarCitaMedicamento$$
CREATE PROCEDURE sp_InsertarCitaMedicamento(
    IN p_Cod_Cita    VARCHAR(10),
    IN p_Medicamento VARCHAR(100),
    IN p_Dosis       VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_InsertarCitaMedicamento', 'CITA_MEDICAMENTOS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    INSERT INTO CITA_MEDICAMENTOS (Cod_Cita, Medicamento, Dosis)
    VALUES (p_Cod_Cita, p_Medicamento, p_Dosis);
    SELECT 'Medicamento insertado correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerCitaMedicamentos$$
CREATE PROCEDURE sp_ObtenerCitaMedicamentos()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerCitaMedicamentos', 'CITA_MEDICAMENTOS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT cm.Cod_Cita, cm.Medicamento, cm.Dosis,
           c.Fecha_Cita, c.Diagnostico
    FROM CITA_MEDICAMENTOS cm
    INNER JOIN CITAS c ON cm.Cod_Cita = c.Cod_Cita;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerMedicamentosPorCita$$
CREATE PROCEDURE sp_ObtenerMedicamentosPorCita(
    IN p_Cod_Cita VARCHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ObtenerMedicamentosPorCita', 'CITA_MEDICAMENTOS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    SELECT * FROM CITA_MEDICAMENTOS WHERE Cod_Cita = p_Cod_Cita;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ActualizarCitaMedicamento$$
CREATE PROCEDURE sp_ActualizarCitaMedicamento(
    IN p_Cod_Cita    VARCHAR(10),
    IN p_Medicamento VARCHAR(100),
    IN p_Dosis       VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_ActualizarCitaMedicamento', 'CITA_MEDICAMENTOS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    UPDATE CITA_MEDICAMENTOS
    SET Dosis = p_Dosis
    WHERE Cod_Cita = p_Cod_Cita AND Medicamento = p_Medicamento;
    SELECT 'Medicamento actualizado correctamente' AS Resultado;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_EliminarCitaMedicamento$$
CREATE PROCEDURE sp_EliminarCitaMedicamento(
    IN p_Cod_Cita    VARCHAR(10),
    IN p_Medicamento VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT;
        INSERT INTO LOGS_ERRORES (Nombre_Rutina, Nombre_Tabla, Codigo_Error, Mensaje_Error)
        VALUES ('sp_EliminarCitaMedicamento', 'CITA_MEDICAMENTOS', @cod, @msg);
        SELECT CONCAT('ERROR: ', @msg) AS Resultado;
    END;
    DELETE FROM CITA_MEDICAMENTOS
    WHERE Cod_Cita = p_Cod_Cita AND Medicamento = p_Medicamento;
    SELECT 'Medicamento eliminado correctamente' AS Resultado;
END$$
DELIMITER ;

-- ============================================================
-- VERIFICAR QUE TODOS LOS SPs SE CREARON
-- ============================================================
SHOW PROCEDURE STATUS WHERE Db = 'hospital_db';

-- ============================================================
-- PRUEBAS CITA_MEDICAMENTOS
-- ============================================================

-- INSERT
CALL sp_InsertarCitaMedicamento('C-001', 'Paracetamol', '500mg');
CALL sp_InsertarCitaMedicamento('C-001', 'Ibuprofeno',  '400mg');
CALL sp_InsertarCitaMedicamento('C-002', 'Amoxicilina', '875mg');
CALL sp_InsertarCitaMedicamento('C-003', 'Aspirina',    '100mg');
CALL sp_InsertarCitaMedicamento('C-004', 'Ergotamina',  '1mg');

-- VER TODOS (con JOIN a CITAS)
CALL sp_ObtenerCitaMedicamentos();

-- VER MEDICAMENTOS DE UNA CITA ESPECIFICA
CALL sp_ObtenerMedicamentosPorCita('C-001');

-- ACTUALIZAR DOSIS
CALL sp_ActualizarCitaMedicamento('C-001', 'Paracetamol', '1000mg');

-- VER EL CAMBIO
CALL sp_ObtenerMedicamentosPorCita('C-001');