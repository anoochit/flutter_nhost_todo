ALTER TABLE public.products DROP CONSTRAINT IF EXISTS products_id_fkey;
ALTER TABLE public.products ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories (id) ON UPDATE RESTRICT ON DELETE RESTRICT;
