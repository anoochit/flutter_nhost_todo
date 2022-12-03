ALTER TABLE public.products DROP COLUMN IF EXISTS category_id;
ALTER TABLE public.products ADD category_id uuid NOT NULL;
ALTER TABLE public.products DROP CONSTRAINT IF EXISTS products_product_category_fkey;
