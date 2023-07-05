"""Скрипт для заполнения данными таблиц в БД Postgres."""
import csv
import os

import psycopg2 as psycopg2

with open('north_data/employees_data.csv') as file:
    employees = list(csv.reader(file))

with open('north_data/customers_data.csv') as file:
    customers = list(csv.reader(file))

with open('north_data/orders_data.csv') as file:
    orders = list(csv.reader(file))

psw= os.getenv('PAS_POSTGSQL')
psw='xStatus34'
print(psw)

with psycopg2.connect(
host = 'localhost',
port = '5432',
dbname = 'north',
user = 'postgres',
password = psw
) as connect_north:
    with connect_north.cursor() as curs:
        for employee in employees[1:]:
            s=f'''
            INSERT INTO employee(employee_id, first_name, last_name, title,  birth_date, notes)
	        VALUES ({employee[0]},'{employee[1]}','{employee[2]}', '{employee[3]}', '{employee[4]}', '{employee[5]}')
	        '''
            # print(s)
            curs.execute(s)

        with connect_north.cursor() as curs:
            for customer in customers[1:]:
                # s = f"""
                # INSERT INTO public.customer(
    	        #         customer_id, company_name, contact_name)
    	        # VALUES ('{customer[0]}','{customer[1]}','{customer[2]}');
    	        # """
                # print(s)
                curs.execute('INSERT INTO public.customer(customer_id, company_name, contact_name) VALUES (%s,%s,%s)',
                             (customer[0],customer[1],customer[2] ) )



        with connect_north.cursor() as curs:
            for order in orders[1:]:


                s = f"""
                INSERT INTO public.customer(
    	                order_id, customer_id, employee_id, order_date, ship_city)
    	        VALUES ({order[0]},'{order[1]}',{order[2]},'{order[3]}','{order[4]}')
    	        """
                print(s)
                curs.execute(s)