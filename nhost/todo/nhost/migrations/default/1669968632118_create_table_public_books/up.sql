CREATE TABLE public.books (title text NOT NULL, description text NOT NULL, price float4 DEFAULT '0.0' NOT NULL, id int8 UNIQUE, PRIMARY KEY (id));
