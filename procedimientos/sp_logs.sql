DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ObtenerLogs$$
CREATE PROCEDURE sp_ObtenerLogs()
BEGIN
    SELECT
        Log_ID,
        Nombre_Rutina,
        CASE
            WHEN Nombre_Rutina LIKE 'sp_%' THEN 'Procedimiento'
            WHEN Nombre_Rutina LIKE 'fn_%' THEN 'Función'
            ELSE 'Desconocido'
        END AS Tipo_Rutina,
        Nombre_Tabla,
        Codigo_Error,
        Mensaje_Error,
        Fecha_Hora
    FROM LOGS_ERRORES
    ORDER BY Fecha_Hora DESC;
END$$
DELIMITER ;

-- ============================================================
-- VERIFICAR TODOS LOS SPs Y FUNCIONES CREADOS
-- ============================================================

SHOW PROCEDURE STATUS WHERE Db = 'hospital_db';
SHOW FUNCTION  STATUS WHERE Db = 'hospital_db';

-- ============================================================
-- PRUEBAS DE ELIMINACION 
-- ============================================================

-- ELIMINAR UN MEDICAMENTO DE UNA CITA
CALL sp_EliminarCitaMedicamento('C-001', 'Ibuprofeno');
CALL sp_ObtenerMedicamentosPorCita('C-001');

-- ELIMINAR UNA CITA COMPLETA (borra sus medicamentos automaticamente)
CALL sp_EliminarCita('C-004');
CALL sp_ObtenerCitas();

-- ELIMINAR UN MEDICO
CALL sp_EliminarMedico('M-30');
CALL sp_ObtenerMedicos();

-- ELIMINAR UN PACIENTE
CALL sp_EliminarPaciente('P-503');
CALL sp_ObtenerPacientes();

-- ELIMINAR UNA SEDE
CALL sp_EliminarSede('Clínica Norte');
CALL sp_ObtenerSedes();

-- ELIMINAR UNA FACULTAD
CALL sp_EliminarFacultad('Ciencias');
CALL sp_ObtenerFacultades();

-- ============================================================
-- PRUEBA DE LOGS (errores registrados automaticamente)
-- ============================================================

-- Provocar un error a proposito (ID duplicado)
CALL sp_InsertarFacultad('Medicina', 'Dr. Wilson');

-- Ver que el error quedo registrado en LOGS
CALL sp_ObtenerLogs();