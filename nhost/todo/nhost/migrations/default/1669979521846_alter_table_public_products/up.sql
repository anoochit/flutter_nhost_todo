ALTER TABLE public.products ADD product_category uuid NOT NULL;
ALTER TABLE public.products ADD CONSTRAINT products_product_category_fkey FOREIGN KEY (product_category) REFERENCES public.categories (id) ON UPDATE RESTRICT ON DELETE RESTRICT;
