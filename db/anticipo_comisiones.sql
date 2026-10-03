-- Aplicar antes de publicar los HTML corregidos.
-- NULL indica que el sistema anterior no guardó el descuento.
ALTER TABLE public.comisiones_participantes
  ADD COLUMN IF NOT EXISTS anticipo_descontado numeric;
ALTER TABLE public.comisiones_participantes
  ADD CONSTRAINT comisiones_anticipo_valido
  CHECK (anticipo_descontado IS NULL OR
    (anticipo_descontado >= 0 AND anticipo_descontado::text NOT IN ('NaN', 'Infinity', '-Infinity')));
COMMENT ON COLUMN public.comisiones_participantes.anticipo_descontado
  IS 'Descuento aplicado a este empleado en este calculo. NULL: registro anterior sin descuento conservado.';