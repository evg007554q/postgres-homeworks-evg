-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE IF EXISTS public.products
    ADD CONSTRAINT unit_price CHECK (unit_price>0)
    NOT VALID;

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE IF EXISTS public.products
    ADD CONSTRAINT discontinued CHECK (discontinued in (0,1))
    NOT VALID;

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)

CREATE TABLE IF NOT EXISTS public.discontinued_products
(
    product_id smallint NOT NULL,
    product_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    supplier_id smallint,
    category_id smallint,
    quantity_per_unit character varying(20) COLLATE pg_catalog."default",
    unit_price real,
    units_in_stock smallint,
    units_on_order smallint,
    reorder_level smallint,
    discontinued integer NOT NULL,
    CONSTRAINT pk_discontinued_products PRIMARY KEY (product_id),
    CONSTRAINT fk_discontinued_products_categories FOREIGN KEY (category_id)
        REFERENCES public.categories (category_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_discontinued_products_suppliers FOREIGN KEY (supplier_id)
        REFERENCES public.suppliers (supplier_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT unit_price CHECK (unit_price > 0::double precision) NOT VALID,
    CONSTRAINT discontinued CHECK (discontinued = ANY (ARRAY[0, 1])) NOT VALID
);
INSERT INTO discontinued_products
SELECT * FROM products WHERE discontinued = 1;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
DELETE FROM public.order_details
	WHERE product_id in (select  product_id FROM products WHERE discontinued = 1);
;
DELETE
--select *
FROM orders
	WHERE order_id not in (select  order_id FROM order_details );
;
DELETE FROM products WHERE discontinued = 1;