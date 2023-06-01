SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `add_id` int NOT NULL,
  `delivery_address1` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_address2` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_zipcode` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`add_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `cust_id` int NOT NULL,
  `cust_firstname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cust_lastname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- ----------------------------
-- Table structure for ingredient
-- ----------------------------
DROP TABLE IF EXISTS `ingredient`;
CREATE TABLE `ingredient` (
  `ing_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ing_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ing_weight` int NOT NULL,
  `ing_meas` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ing_price` decimal(5,2) NOT NULL,
  PRIMARY KEY (`ing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- ----------------------------
-- Table structure for inventory
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `inv_id` int NOT NULL,
  `item_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`inv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `item_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_cat` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_size` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `row_id` int NOT NULL,
  `order_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `item_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `cust_id` int NOT NULL,
  `delivery` tinyint(1) NOT NULL,
  `add_id` int NOT NULL,
  PRIMARY KEY (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- ----------------------------
-- Table structure for recipe
-- ----------------------------
DROP TABLE IF EXISTS `recipe`;
CREATE TABLE `recipe` (
  `row_id` int NOT NULL,
  `recipe_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ing_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ----------------------------
-- Table structure for rota
-- ----------------------------
DROP TABLE IF EXISTS `rota`;
CREATE TABLE `rota` (
  `row_id` int NOT NULL,
  `rota_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `shift_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- ----------------------------
-- Table structure for shift
-- ----------------------------
DROP TABLE IF EXISTS `shift`;
CREATE TABLE `shift` (
  `shift_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `day_of_week` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`shift_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `staff_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hourly_rate` decimal(5,2) NOT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- ----------------------------
-- View structure for stock1
-- ----------------------------
DROP VIEW IF EXISTS `stock1`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `stock1` AS select `s1`.`item_name` AS `item_name`,`s1`.`ing_name` AS `ing_name`,`s1`.`ing_id` AS `ing_id`,`s1`.`ing_weight` AS `ing_weight`,`s1`.`ing_price` AS `ing_price`,`s1`.`order_quantity` AS `order_quantity`,`s1`.`recipe_quantity` AS `recipe_quantity`,(`s1`.`order_quantity` * `s1`.`recipe_quantity`) AS `ordered_weight`,(`s1`.`ing_price` / `s1`.`ing_weight`) AS `unit_cost`,((`s1`.`order_quantity` * `s1`.`recipe_quantity`) * (`s1`.`ing_price` / `s1`.`ing_weight`)) AS `ingredient_cost` from (select `o`.`item_id` AS `item_id`,`i`.`sku` AS `sku`,`i`.`item_name` AS `item_name`,`r`.`ing_id` AS `ing_id`,`ing`.`ing_name` AS `ing_name`,`ing`.`ing_weight` AS `ing_weight`,`ing`.`ing_price` AS `ing_price`,sum(`o`.`quantity`) AS `order_quantity`,`r`.`quantity` AS `recipe_quantity` from (((`orders` `o` left join `item` `i` on((`o`.`item_id` = `i`.`item_id`))) left join `recipe` `r` on((`i`.`sku` = `r`.`recipe_id`))) left join `ingredient` `ing` on((`ing`.`ing_id` = `r`.`ing_id`))) group by `o`.`item_id`,`i`.`sku`,`i`.`item_name`,`r`.`ing_id`,`r`.`quantity`,`ing`.`ing_weight`,`ing`.`ing_price`) `s1`;

-- ----------------------------
-- View structure for stock2
-- ----------------------------
DROP VIEW IF EXISTS `stock2`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `stock2` AS select `s1`.`sku` AS `sku`,`s1`.`item_name` AS `item_name`,`s1`.`order_quantity` AS `order_quantity`,`i`.`ing_id` AS `ing_id`,`i`.`ing_name` AS `ing_name`,`r`.`quantity` AS `quantity`,`i`.`ing_weight` AS `ing_weight`,`i`.`ing_meas` AS `ing_meas`,`i`.`ing_price` AS `ing_price`,(`s1`.`order_quantity` * `r`.`quantity`) AS `total_quantity`,(((`i`.`ing_price` / `i`.`ing_weight`) * `r`.`quantity`) * `s1`.`order_quantity`) AS `ing_cost` from ((`stock_step_1` `s1` left join `recipe` `r` on((`s1`.`sku` = `r`.`recipe_id`))) left join `ingredient` `i` on((`r`.`ing_id` = `i`.`ing_id`)));

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Orders query
-- ----------------------------

SELECT
	o.order_id,
	i.item_price,
	o.quantity,
	i.item_cat,
	i.item_name,
	o.created_at,
	a.delivery_address1,
	a.delivery_address2,
	a.delivery_city,
	a.delivery_zipcode,
	o.delivery 
FROM
	orders o
	LEFT JOIN item i ON o.item_id = i.item_id
	LEFT JOIN address a ON o.add_id = a.add_id

-- ----------------------------
-- Stock1 query
-- ----------------------------
SELECT
	s1.item_name AS item_name,
	s1.ing_name AS ing_name,
	s1.ing_id AS ing_id,
	s1.ing_weight AS ing_weight,
	s1.ing_price AS ing_price,
	s1.order_quantity AS order_quantity,
	s1.recipe_quantity AS recipe_quantity,(
		s1.order_quantity * s1.recipe_quantity 
		) AS ordered_weight,(
		s1.ing_price / s1.ing_weight 
		) AS unit_cost,((
			s1.order_quantity * s1.recipe_quantity 
		) * ( s1.ing_price / s1.ing_weight )) AS ingredient_cost 
FROM
	(
	SELECT
		o.item_id AS item_id,
		i.sku AS sku,
		i.item_name AS item_name,
		r.ing_id AS ing_id,
		ing.ing_name AS ing_name,
		ing.ing_weight AS ing_weight,
		ing.ing_price AS ing_price,
		sum( o.quantity ) AS order_quantity,
		r.quantity AS recipe_quantity 
	FROM
		(((
					orders o
					LEFT JOIN item i ON ((
							o.item_id = i.item_id 
						)))
				LEFT JOIN recipe r ON ((
						i.sku = r.recipe_id 
					)))
			LEFT JOIN ingredient ing ON ((
					ing.ing_id = r.ing_id 
				))) 
	GROUP BY
		o.item_id,
		i.sku,
		i.item_name,
		r.ing_id,
		r.quantity,
		ing.ing_weight,
	ing.ing_price 
	) s1

-- ----------------------------
-- Stock2 query
-- ----------------------------  
select
s2.ing_name,
s2.ordered_weight,
ing.ing_weight,
inv.quantity,
ing.ing_weight * inv.quantity AS total_inv_weight 
FROM
	( SELECT ing_id, ing_name, sum( ordered_weight ) AS ordered_weight FROM stock1 GROUP BY ing_name, ing_id ) s2
	LEFT JOIN inventory inv ON inv.item_id = s2.ing_id
	LEFT JOIN ingredient ing ON ing.ing_id = s2.ing_id
      
-- ----------------------------
-- Staff query
-- ----------------------------

SELECT
	r.date,
	s.first_name,
	s.last_name,
	s.hourly_rate,
	sh.start_time,
	sh.end_time,
	((
			HOUR (
			timediff( sh.end_time, sh.start_time ))* 60 
			)+(
			MINUTE (
			timediff( sh.end_time, sh.start_time ))))/ 60 AS hours_in_shift,
	((
			HOUR (
			timediff( sh.end_time, sh.start_time ))* 60 
			)+(
			MINUTE (
			timediff( sh.end_time, sh.start_time ))))/ 60 * s.hourly_rate AS staff_cost 
FROM
	rota r
	LEFT JOIN staff s ON r.staff_id = s.staff_id
	LEFT JOIN shift sh ON r.shift_id = sh.shift_id
