-- public.todos definition

-- Drop table

-- DROP TABLE public.todos;

CREATE TABLE public.todos (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	"name" text NOT NULL,
	is_completed bool NOT NULL DEFAULT false,
	created timestamp NOT NULL DEFAULT now(),
	updated timestamp NOT NULL DEFAULT now(),
	user_id uuid NOT NULL,
	CONSTRAINT todos_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE public.todos OWNER TO nhost_hasura;
GRANT ALL ON TABLE public.todos TO nhost_hasura;


-- public.todos foreign keys

ALTER TABLE public.todos ADD CONSTRAINT todos_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE RESTRICT ON UPDATE RESTRICT;
