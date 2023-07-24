-- 1. Создать таблицу student с полями student_id serial, first_name varchar, last_name varchar, birthday date, phone varchar
CREATE TABLE public.student
(
    student_id serial NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    birthday_date date,
    phone character varying(100),
    PRIMARY KEY (student_id)
);

ALTER TABLE IF EXISTS public.student
    OWNER to postgres;

-- 2. Добавить в таблицу student колонку middle_name varchar
ALTER TABLE IF EXISTS public.student
    ADD COLUMN middle_name character varying(100);

-- 3. Удалить колонку middle_name
ALTER TABLE IF EXISTS public.student DROP COLUMN IF EXISTS middle_name;

-- 4. Переименовать колонку birthday в birth_date
ALTER TABLE IF EXISTS public.student
    RENAME birthday_date TO birth_date;

-- 5. Изменить тип данных колонки phone на varchar(32)
ALTER TABLE public.student
    ALTER COLUMN phone TYPE character varying(32) COLLATE pg_catalog."default";

-- 6. Вставить три любых записи с автогенерацией идентификатора
INSERT INTO public.student(
	 first_name, last_name, birth_date, phone)
	VALUES ('first_name1', 'last_name1', '1980-01-01', '11111');

INSERT INTO public.student(
	 first_name, last_name, birth_date, phone)
	VALUES ('first_name2', 'last_name2', '1980-01-01', '2 222 222 22 22');

INSERT INTO public.student(
	 first_name, last_name, birth_date, phone)
	VALUES ('first_name3', 'last_name3', '1980-01-01', '3 333 333 33 33');

-- 7. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
TRUNCATE TABLE student RESTART IDENTITY;