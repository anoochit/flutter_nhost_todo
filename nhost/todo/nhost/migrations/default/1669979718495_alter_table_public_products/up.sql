ALTER TABLE public.products DROP COLUMN IF EXISTS category_id;
ALTER TABLE public.products ADD category uuid NOT NULL;
ALTER TABLE public.products DROP CONSTRAINT IF EXISTS products_product_category_fkey;
ALTER TABLE public.products ADD CONSTRAINT products_id_fkey FOREIGN KEY (id) REFERENCES public.categories (id) ON UPDATE RESTRICT ON DELETE RESTRICT;
