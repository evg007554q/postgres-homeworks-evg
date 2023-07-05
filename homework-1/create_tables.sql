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

CREATE TABLE IF NOT EXISTS public.orders
(
    order_id integer NOT NULL,
    customer_id character varying(5) COLLATE pg_catalog."default" NOT NULL,
    employee_id integer NOT NULL,
    order_date date,
    ship_city character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT orders_pkey PRIMARY KEY (order_id),
    CONSTRAINT customer FOREIGN KEY (customer_id)
        REFERENCES public.customer (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT employee FOREIGN KEY (employee_id)
        REFERENCES public.employee (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
