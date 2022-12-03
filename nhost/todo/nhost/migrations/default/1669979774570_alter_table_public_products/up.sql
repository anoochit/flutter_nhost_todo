ALTER TABLE public.products DROP COLUMN IF EXISTS category;
ALTER TABLE public.products DROP CONSTRAINT IF EXISTS products_id_fkey;
