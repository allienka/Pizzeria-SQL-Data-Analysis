# Pizzeria-SQL-Data-Analysis
aim of this project is to work with purchased data, build a derived table, and calculate KPIs<br>
based on the datasets provided


# Requrements<br>
Create and build an database, to capture and store all important data.<br>
Create a table to be able to know when its time to order new stock.<br>

Main areas of focus:<br>
-orders<br>
-stock control<br>
-Staff<br>

Stock control requirements<br>
client wants to be able to know when its time to order new stock <br>
To do this we need more information about:<br>
- what ingredients go into each pizza <br>
- their quantity based on the size of pizza<br>
- the existing stock level<br>
We will assume the lead time for delivery by suppliers is the same for all ingredients<br>

Order Data Required:<br>
•	Item name<br>
•	Item price<br>
•	Quantity<br>
•	Customer name<br>
•	Delivery address<br>

Inventory management:<br>
- total quantity by ingredient<br>
- total costs of ingredients<br>
- calculated cost if pizza<br>
- percentage stock remaining by ingredients<br>


# PREREQUISITES<br>
- Install MySQLWorkbench or Xampp<br>
- Any Editor (Preferably VS Code or Sublime Text)<br>


# Languages and Technologies used:<br>

- XAMPP or MySQL Workbench<br>
- MySQL<br>
- Tableau public<br>

# Fields in datasets <br>

ORDERS<br>
-
Row ID  int pk<br>
Order ID  varchar(10)<br>
Created at datetime<br>
Quantity int<br>
Delivery boolean<br>
Cust_id int fk<br>
Add_id int fk<br>
Item-id int fk<br>

CUSTOMERS<br>
-
Cust_id int pk<br>
Cust_ firstname varchar(50)<br>
Cust_lastname varchar(50)<br>


ADDRESS<br>
-
Add_id int pk<br>
Delivery address 1 varchar(200)<br>
Delivery address 2 varchar(200) NULL<br>
Delivery city varchar(50)<br>
Delivery zip code varchar(20)<br>

ITEM<br>
-
Item_id varchar(10) pk <br>
Item name varchar(50)<br>
Item category varchar(50)<br>
Item size varchar(20)<br>
Item price decimal(5,2)<br>

INGREDIENT<br>
-
Ing_id varchar(10) pk<br>
Ing_name varchar(20)<br>
Ing_weight int<br>
Ing_meas varchar(20)<br>
Ing_price decimal (5,2)<br>

RECIPE<br>
-
Row_id int pk<br>
Recipe_id varchar(20) fk<br>
Ing_id varchar(10) fk<br>
Quantity int<br>

INVENTORY<br>
-
Inv_id int pk<br>
Item_id varchar(10) fk   <br>
Quantity<br>

ROTA<br>
-
Row_id intpk<br>
Rota_id int <br>
Date date fk<br>
Shift_id int fk<br>
Staff_id int fk<br>

STAFF<br>
-
Staff_id varchar(20) pk<br>
First_name varchar(20) <br>
Last_name varchar(20)<br>
Position varchar(20)<br>
Hourly_rate decimal (5,2)<br>




SHIFT<br>
-
Shift_id pk<br>
Day_of_week varchar(10)<br>
Start_time time<br>
End_time time<br>




# DASHBOARDS<br>
![Screenshot 2023-06-08 104125](https://github.com/allienka/Pizzeria-SQL-Data-Analysis/assets/105230372/da52fc2b-2423-4330-9f4a-6eec78f07a92)

![Screenshot 2023-06-08 104137](https://github.com/allienka/Pizzeria-SQL-Data-Analysis/assets/105230372/a289f55f-9dc3-41aa-a4a4-2c7fb45b1b47)

![Screenshot 2023-06-09 104532](https://github.com/allienka/Pizzeria-SQL-Data-Analysis/assets/105230372/5e67b7a3-f2b6-4b10-8722-e742376b9c77)

![Screenshot 2023-06-09 104522](https://github.com/allienka/Pizzeria-SQL-Data-Analysis/assets/105230372/8425fc42-207c-4ca6-9366-7180646e2f5f)
