-- SQL-команды для создания таблиц

CREATE TABLE IF NOT EXISTS public.customer
(
    customer_id character varying(5) COLLATE pg_catalog."default" NOT NULL,
    company_name character varying(250) COLLATE pg_catalog."default",
    contact_name character varying(250) COLLATE pg_catalog."default",
    CONSTRAINT customer_pkey PRIMARY KEY (customer_id)
)

;
CREATE TABLE IF NOT EXISTS public.employee
(
    employee_id integer NOT NULL,
    first_name character varying(250) COLLATE pg_catalog."default",
    last_name character varying(250) COLLATE pg_catalog."default",
    title character varying(250) COLLATE pg_catalog."default",
    birth_date date,
    notes text COLLATE pg_catalog."default",
    CONSTRAINT employee_pkey PRIMARY KEY (employee_id)
)

;