-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 10, 2023 at 07:29 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_construction`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CategoryProducts` (IN `id` INT)   BEGIN
	SELECT *FROM tblCategories WHERE tblCategories.id IN(SELECT category_id FROM tblProducts WHERE tblProducts.category_id = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RowStockReport` (IN `qty_stock` INT, IN `search` VARCHAR(100))   BEGIN
  IF qty_stock = 0 THEN
    SELECT COUNt(*) AS totalRows FROM tblProducts WHERE tblProducts.product_code LIKE CONCAT('%',search,'%') AND tblProducts.qty = qty_stock;
    ELSE
      SELECT COUNT(*) AS totalRows FROM tblProducts WHERE tblProducts.product_code LIKE CONCAT('%',search,'%') AND tblProducts.qty = tblProducts.reorder_number;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SaleInvoice_sp` (IN `id` INT)   SELECT tblProducts.product_name,concat(tblSaleDetails.qty_sales,' ',tblProductUnits.unit) AS qty,tblSaleDetails.qty_sales,tblProducts.price,
(tblSaleDetails.qty_sales*tblProducts.price) AS subtotal,tblUsers.username,tblSales.sale_date,tblInvoice.amount,tblInvoice.money_change,tblPayments.payment_type,
tblInvoice.invoice_number

FROM tblSaleDetails
INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
INNER JOIN tblSales ON tblSaleDetails.sale_id = tblSales.sale_id
INNER JOIN tblInvoice ON tblSales.invoice_id = tblInvoice.invoice_id
INNER JOIN tblProductUnits ON tblProducts.unit_id = tblProductUnits.id
INNER JOIN tblUsers ON tblSales.user_id = tblUsers.id
INNER JOIN tblPayments ON tblPayments.id = tblInvoice.payment_id
WHERE tblSales.sale_id = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Brand` (IN `limits` INT, IN `page` INT, IN `search` VARCHAR(100))   BEGIN

  DECLARE skip_page INT;
    SET skip_page = limits*(page-1);
    
    SELECT *FROM tblBrands
    WHERE tblBrands.brandName LIKE CONCAT('%',search,'%') OR tblBrands.id = search
    ORDER BY tblBrands.id 
    LIMIT limits OFFSET skip_page;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Category` (IN `limits` INT, IN `page` INT, IN `search` VARCHAR(100))   BEGIN

  DECLARE skip_page INT;
    SET skip_page = limits*(page-1);
    
    SELECT *FROM tblCategories
    WHERE tblCategories.categoryName LIKE CONCAT('%',search,'%') OR tblCategories.id = search
    ORDER BY tblCategories.id 
    LIMIT limits OFFSET skip_page;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DeleteSale` (IN `id` INT)   BEGIN

	DELETE FROM tblInvoice WHERE tblInvoice.invoice_id = id;
    DELETE FROM tblSales WHERE tblSales.sale_id =id;
    DELETE FROM tblSaleDetails WHERE tblSaleDetails.sale_id = id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_FetchSaleProduct` (IN `id` INT)   SELECT tblProducts.product_name,tblProducts.product_id,tblProducts.product_image,tblProducts.qty AS old_qty,tblSaleDetails.qty_sales AS qty,tblProducts.price,tblProducts.unit_price,tblCategories.id AS category_id,tblInvoice.payment_id
FROM tblSaleDetails
INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
INNER JOIN tblSales ON tblSaleDetails.sale_id = tblSales.sale_id
INNER JOIN tblInvoice ON tblSales.invoice_id = tblInvoice.invoice_id
LEFT JOIN tblUsers ON tblSales.user_id = tblUsers.id
INNER JOIN tblPayments ON tblPayments.id = tblInvoice.payment_id
LEFT JOIN tblCategories ON tblProducts.category_id = tblCategories.id
WHERE tblSales.sale_id = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetRowCustomers` (IN `search` VARCHAR(30))   BEGIN
  
    
    SELECT COUNT(*) AS totalRows FROM tblCustomers;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetRowsBrand` (IN `search` VARCHAR(100))   BEGIN
    SELECT COUNT(*) AS totalRows FROM tblBrands
    WHERE tblBrands.brandName LIKE CONCAT('%',search,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetRowsCategory` (IN `search` VARCHAR(100))   BEGIN
    SELECT COUNT(*) AS totalRows FROM tblCategories
    WHERE tblCategories.categoryName LIKE CONCAT('%',search,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetRowsProUnit` (IN `search` VARCHAR(100))   BEGIN
    SELECT COUNT(*) AS totalRows FROM tblProductUnits
    WHERE tblProductUnits.unit LIKE CONCAT('%',search,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetRowSupplier` (IN `search` VARCHAR(100))   BEGIN
  
  SELECT COUNT(*) AS totalRows FROM tblSupplies
    WHERE tblSupplies.supName LIKE concat('%',search,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ItemCounts` ()   BEGIN
    
    SELECT  COUNT(*) AS total_sales FROM tblSales;
    SELECT COUNT(*) AS total_products  FROM tblProducts;
    SELECT COUNT(*) AS total_customers FROM tblCustomers;
    SELECT COUNT(*) AS total_categories FROM tblCategories;
   
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ListSales` (IN `limits` INT, IN `page` INT, IN `user_id` INT(0), IN `role` BOOLEAN, IN `invoiceNumber` VARCHAR(100))   BEGIN 
  DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
   IF role THEN 
  SELECT tblSales.sale_date,tblInvoice.invoice_number,tblSales.sale_id,tblInvoice.invoice_id,tblCustomers.customerName,tblInvoice.amount,tblInvoice.money_change,SUM(tblProducts.price*tblSaleDetails.qty_sales) as totalPrice,tblInvoice.payment_id FROM tblSales
        INNER JOIN  tblInvoice ON tblInvoice.invoice_id = tblSales.invoice_id
        LEFT JOIN tblUsers ON tblSales.user_id = tblUsers.id
        INNER JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
        INNER JOIN tblSaleDetails ON tblSales.sale_id = tblSaleDetails.sale_id
        INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
        
        WHERE tblInvoice.invoice_number LIKE concat( '%',invoiceNumber,'%') AND role = 1
        GROUP BY (tblSaleDetails.sale_id)  
        ORDER BY tblInvoice.invoice_number DESC LIMIT limits OFFSET skip_page;
        ELSE
       SELECT tblSales.sale_date,tblInvoice.invoice_number,tblSales.sale_id,tblInvoice.invoice_id,tblCustomers.customerName,
         tblInvoice.amount,tblInvoice.money_change,SUM(tblProducts.price*tblSaleDetails.qty_sales) as totalPrice,tblInvoice.payment_id FROM tblSales
        INNER JOIN  tblInvoice ON tblInvoice.invoice_id = tblSales.invoice_id
        INNER JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
        INNER JOIN tblSaleDetails ON tblSales.sale_id = tblSaleDetails.sale_id
        INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
        INNER JOIN tblUsers ON tblSales.user_id = tblUsers.id
        WHERE tblInvoice.invoice_number LIKE concat( '%',invoiceNumber,'%') AND tblUsers.id = user_id
        GROUP BY (tblSaleDetails.sale_id)  
        ORDER BY tblInvoice.invoice_number DESC LIMIT limits OFFSET skip_page;
   END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_List_Customers` (IN `limits` INT, IN `page` INT, IN `search` VARCHAR(30))   BEGIN
  DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
    
    SELECT *FROM tblCustomers 
    WHERE tblCustomers.customerName LIKE CONCAT('%',search,'%') OR tblCustomers.id = search
    ORDER BY tblCustomers.id
    LIMIT limits OFFSET skip_page;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_List_Users` (IN `limits` INT, IN `page` INT, IN `search` VARCHAR(30))   BEGIN
  DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
   
    SELECT tblUsers.id,username,email,phone_number,tblRoles.role_name,tblStatus.status FROM tblUsers 
    INNER JOIN tblRoles ON tblUsers.role_id = tblRoles.role_id
    INNER JOIN tblStatus ON tblUsers.status_id = tblStatus.id
    WHERE tblUsers.username LIKE CONCAT('%',search,'%') OR tblUsers.id = search
    ORDER BY tblUsers.id DESC
    LIMIT limits OFFSET skip_page;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ProductCard` (IN `search` VARCHAR(100))   BEGIN

	SELECT product_id,product_name,price,product_image,qty,product_code,category_id FROM tblProducts 
    WHERE (status = 1 AND qty>0) AND product_name LIKE concat('%',search,'%') OR product_code=search;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ProductPagination` (IN `search_val` VARCHAR(100))   BEGIN
  SELECT COUNT(*) AS TotalRows  FROM tblProducts 
  WHERE tblProducts.product_name LIKE CONCAT('%',search_val,'%') OR tblProducts.product_code = search_val
  ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ProductReportCategory` (IN `page_limits` INT, IN `page` INT, IN `categoryId` INT, IN `search` VARCHAR(100))   BEGIN
	DECLARE skip_page INT;
	SET skip_page = (page-1)*page_limits;
	select `db_construction`.`tblProducts`.`product_id` AS `product_id`,tblCategories.categoryName,`db_construction`.`tblProducts`.`product_code` AS `product_code`,`db_construction`.`tblProducts`.`product_name` AS `product_name`,sum(`db_construction`.`tblSaleDetails`.`qty_sales`) AS `qty_sales`,`db_construction`.`tblProductUnits`.`unit` AS `unit`,sum(`db_construction`.`tblSaleDetails`.`qty_sales`) * `db_construction`.`tblProducts`.`unit_price` AS `cost`,sum(`db_construction`.`tblSaleDetails`.`qty_sales`) * `db_construction`.`tblProducts`.`price` AS `revenue`,sum(`db_construction`.`tblSaleDetails`.`qty_sales`) * `db_construction`.`tblProducts`.`price` - sum(`db_construction`.`tblSaleDetails`.`qty_sales`) * `db_construction`.`tblProducts`.`unit_price` AS `profit`,`db_construction`.`tblProducts`.`qty` AS `qty` from ((`db_construction`.`tblSaleDetails` left join `db_construction`.`tblProducts` on(`db_construction`.`tblSaleDetails`.`product_id` = `db_construction`.`tblProducts`.`product_id`)) join `db_construction`.`tblProductUnits` on(`db_construction`.`tblProducts`.`unit_id` = `db_construction`.`tblProductUnits`.`id`))
 INNER JOIN tblCategories ON tblProducts.category_id = tblCategories.id
 WHERE  tblProducts.product_name LIKE concat('%',search,'%') AND tblCategories.id =  categoryId
 group by `db_construction`.`tblSaleDetails`.`product_id`
 LIMIT page_limits OFFSET skip_page;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ProductReports` (IN `page_limits` INT, IN `page` INT, IN `search` VARCHAR(100))   BEGIN
	DECLARE skip_page INT;
	SET skip_page = (page-1)*page_limits;
	select `db_construction`.`tblProducts`.`product_id` AS `product_id`,tblCategories.categoryName,`db_construction`.`tblProducts`.`product_code` AS `product_code`,`db_construction`.`tblProducts`.`product_name` AS `product_name`,sum(`db_construction`.`tblSaleDetails`.`qty_sales`) AS `qty_sales`,`db_construction`.`tblProductUnits`.`unit` AS `unit`,sum(`db_construction`.`tblSaleDetails`.`qty_sales`) * `db_construction`.`tblProducts`.`unit_price` AS `cost`,sum(`db_construction`.`tblSaleDetails`.`qty_sales`) * `db_construction`.`tblProducts`.`price` AS `revenue`,sum(`db_construction`.`tblSaleDetails`.`qty_sales`) * `db_construction`.`tblProducts`.`price` - sum(`db_construction`.`tblSaleDetails`.`qty_sales`) * `db_construction`.`tblProducts`.`unit_price` AS `profit`,`db_construction`.`tblProducts`.`qty` AS `qty` from ((`db_construction`.`tblSaleDetails` left join `db_construction`.`tblProducts` on(`db_construction`.`tblSaleDetails`.`product_id` = `db_construction`.`tblProducts`.`product_id`)) join `db_construction`.`tblProductUnits` on(`db_construction`.`tblProducts`.`unit_id` = `db_construction`.`tblProductUnits`.`id`))
 INNER JOIN tblCategories ON tblProducts.category_id = tblCategories.id
 WHERE tblProducts.product_code = search OR tblProducts.product_name LIKE concat('%',search,'%') 
 group by `db_construction`.`tblSaleDetails`.`product_id`
 LIMIT page_limits OFFSET skip_page;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ProductUnit` (IN `limits` INT, IN `page` INT, IN `search` VARCHAR(100))   BEGIN

  DECLARE skip_page INT;
    SET skip_page = limits*(page-1);
    
    SELECT *FROM tblProductUnits
    WHERE tblProductUnits.unit LIKE CONCAT('%',search,'%') OR tblProductUnits.id = search
    ORDER BY tblProductUnits.id 
    LIMIT limits OFFSET skip_page;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RowsListSale` (IN `invoiceNumber` VARCHAR(100))   BEGIN 
	SELECT COUNT(*) AS totalRows FROM tblSales
	INNER JOIN  tblInvoice ON tblInvoice.invoice_id = tblSales.sale_id
    INNER JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
    WHERE tblInvoice.invoice_number LIKE concat( '%',invoiceNumber,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_RowsProReports` (IN `search` VARCHAR(100))   BEGIN
	SELECT COUNT(*) AS TotalRows FROM V_ProductReports
  WHERE V_ProductReports.product_name  LIKE concat('%',search,'%');

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Row_Users` (IN `search` VARCHAR(30))   BEGIN
  
  SELECT COUNT(*) AS totalRows FROM tblUsers
    WHERE username LIKE concat( '%',search,'%');
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SaleReports` (IN `limits` INT, IN `page` INT, IN `invoiceNumber` VARCHAR(100))   BEGIN 
	DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
	SELECT tblSales.sale_date,tblInvoice.invoice_number,tblSales.sale_id,tblInvoice.invoice_id,tblCustomers.customerName,tblInvoice.amount,
    tblInvoice.money_change,SUM(tblProducts.price*tblSaleDetails.qty_sales) as totalPrice,tblSales.sale_date,tblPayments.payment_type
    FROM tblSales
	INNER JOIN  tblInvoice ON tblInvoice.invoice_id = tblSales.invoice_id
    INNER JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
    INNER JOIN tblSaleDetails ON tblSales.sale_id = tblSaleDetails.sale_id
    INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
    INNER JOIN tblPayments ON tblInvoice.payment_id = tblPayments.id
    WHERE tblInvoice.invoice_number LIKE concat( '%',invoiceNumber,'%')
    GROUP BY (tblSaleDetails.sale_id) 
    ORDER BY tblInvoice.invoice_number DESC LIMIT limits OFFSET skip_page ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SaleReportsWidthDate` (IN `limits` INT, IN `page` INT, IN `invoiceNumber` VARCHAR(100), IN `start_date` DATE, IN `end_date` DATE)   BEGIN 
  DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
  SELECT tblSales.sale_date,tblInvoice.invoice_number,tblSales.sale_id,tblInvoice.invoice_id,tblCustomers.customerName,tblInvoice.amount,
    tblInvoice.money_change,SUM(tblProducts.price*tblSaleDetails.qty_sales) as totalPrice,tblSales.sale_date,tblPayments.payment_type
    FROM tblSales
  INNER JOIN  tblInvoice ON tblInvoice.invoice_id = tblSales.invoice_id
    INNER JOIN tblCustomers ON tblSales.customer_id = tblCustomers.id
    INNER JOIN tblSaleDetails ON tblSales.sale_id = tblSaleDetails.sale_id
    INNER JOIN tblProducts ON tblSaleDetails.product_id = tblProducts.product_id
    INNER JOIN tblPayments ON tblInvoice.payment_id = tblPayments.id
    WHERE tblInvoice.invoice_number LIKE CONCAT('%',invoiceNumber,'%') AND (tblSales.sale_date BETWEEN start_date AND end_date )
    GROUP BY (tblSaleDetails.sale_id) 
    ORDER BY tblInvoice.invoice_number DESC LIMIT limits OFFSET skip_page ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SearchProduct` (IN `search_val` VARCHAR(255), IN `limit_page` INT, IN `page` INT)   BEGIN
DECLARE page_offset INT;
SET page_offset = (page-1)*limit_page;
 SELECT `tblProducts`.`product_image` AS `product_image`, tblStatus.status,`tblProducts`.`product_id` AS `product_id`, `tblProducts`.`product_name` AS `product_name`, `tblProducts`.`product_code` AS `product_code`, `tblCategories`.`categoryName` AS `categoryName`, `tblBrands`.`brandName` AS `brandName`, `tblProductUnits`.`unit` AS `unit`, `tblProducts`.`unit_price` AS `unit_price`, `tblProducts`.`price` AS `price`, `tblProducts`.`qty` AS `qty`, `tblProducts`.`reorder_number` AS `reorder_number` FROM (((`tblProducts` left join `tblCategories` on(`tblProducts`.`category_id` = `tblCategories`.`id`)) left join `tblBrands` on(`tblProducts`.`brand_id` = `tblBrands`.`id`)) left join `tblProductUnits` on(`tblProducts`.`unit_id` = `tblProductUnits`.`id`)) INNER JOIN tblStatus ON tblProducts.status = tblStatus.id
 WHERE tblProducts.product_name LIKE concat('%',search_val,'%') OR tblProducts.product_code = `search_val`
ORDER BY tblProducts.product_id DESC LIMIT limit_page OFFSET page_offset;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Supplier` (IN `limits` INT, IN `page` INT, IN `search` VARCHAR(100))   BEGIN
  DECLARE skip_page INT;
    SET skip_page = (page-1)*limits;
  SELECT *FROM tblSupplies
    WHERE tblSupplies.supName LIKE concat('%',search,'%')
     ORDER BY tblSupplies.id DESC
    LIMIT limits OFFSET skip_page;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `StockReports` (IN `limits` INT, IN `qty_stock` INT, IN `search` VARCHAR(100), IN `page` INT)   BEGIN
  DECLARE skip INT;
    SET skip = (page-1)*limits;
    
  IF qty_stock = 0 THEN
  SELECT tblProducts.product_id,tblProducts.product_code,tblProducts.product_name,tblProducts.qty,tblBrands.brandName,tblCategories.categoryName
    ,tblSupplies.companyName,tblSupplies.supName,tblSupplies.phone,tblProducts.unit_price
    FROM tblProducts 
    INNER JOIN tblCategories ON tblProducts.category_id = tblCategories.id
    LEFT JOIN tblBrands ON tblProducts.brand_id = tblBrands.id
    LEFT JOIN tblSupplies ON tblProducts.sub_id = tblSupplies.id
    WHERE tblProducts.product_code LIKE CONCAT('%',search,'%') AND tblProducts.qty = qty_stock 
    LIMIT limits OFFSET skip;
    ELSE
    
            SELECT           tblProducts.product_id,tblProducts.product_code,tblProducts.product_name,tblProducts.qty,tblBrands.brandName,tblCategories.categoryName 
             ,tblSupplies.companyName,tblSupplies.supName,tblSupplies.phone,tblProducts.unit_price
            FROM tblProducts 
        INNER JOIN tblCategories ON tblProducts.category_id = tblCategories.id
        LEFT JOIN tblBrands ON tblProducts.brand_id = tblBrands.id
        LEFT JOIN tblSupplies ON tblProducts.sub_id = tblSupplies.id
        WHERE tblProducts.product_code LIKE CONCAT('%',search,'%') AND (tblProducts.qty <= tblProducts.reorder_number AND tblProducts.qty>0)
      LIMIT limits OFFSET skip;
    END IF;
 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UnitProducts` (IN `id` INT)   BEGIN
	SELECT *FROM tblProductUnits WHERE tblProductUnits.id IN(SELECT unit_id FROM tblProducts WHERE unit_id = id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCustomerData` (IN `p_customerName` VARCHAR(100), IN `p_email` VARCHAR(100), IN `p_phoneNumber` VARCHAR(20), IN `p_address` VARCHAR(200), IN `p_id` INT)   BEGIN
    UPDATE tblCustomers
    SET customerName = p_customerName,
      email = p_email,
        phoneNumber = p_phoneNumber,
        address = p_address
    WHERE  id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_product_by_id` (IN `p_id` INT)   BEGIN
  SELECT *FROM getAllProducts WHERE getAllProducts.product_id = p_id;
End$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `getallproducts`
-- (See below for the actual view)
--
CREATE TABLE `getallproducts` (
`product_id` int(11)
,`product_name` varchar(200)
,`product_code` varchar(100)
,`categoryName` varchar(250)
,`brandName` varchar(200)
,`unit` varchar(20)
,`unit_price` float
,`price` float
,`qty` int(11)
,`reorder_number` int(11)
,`product_image` varchar(250)
);

-- --------------------------------------------------------

--
-- Table structure for table `tblBrands`
--

CREATE TABLE `tblBrands` (
  `id` int(11) NOT NULL,
  `brandName` varchar(200) NOT NULL,
  `desc` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblBrands`
--

INSERT INTO `tblBrands` (`id`, `brandName`, `desc`) VALUES
(15, 'K Cement', ''),
(19, 'V Steel', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblCategories`
--

CREATE TABLE `tblCategories` (
  `id` int(11) NOT NULL,
  `categoryName` varchar(250) NOT NULL,
  `desc` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblCategories`
--

INSERT INTO `tblCategories` (`id`, `categoryName`, `desc`) VALUES
(1, ' ស៊ីម៉ងត៍', ''),
(2, 'ក្ដាបន្ទះពេជ្រ សរ', ''),
(7, 'វីស', ''),
(8, 'បំពងទីមជ័រ', ''),
(10, 'ដែកគោល', ''),
(12, 'ក្រដាស់', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblCurrency`
--

CREATE TABLE `tblCurrency` (
  `cur_id` int(11) NOT NULL,
  `cur_kh` float NOT NULL,
  `cur_dollar` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblCurrency`
--

INSERT INTO `tblCurrency` (`cur_id`, `cur_kh`, `cur_dollar`) VALUES
(1, 4150, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblCustomers`
--

CREATE TABLE `tblCustomers` (
  `id` int(11) NOT NULL,
  `customerName` varchar(100) NOT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblCustomers`
--

INSERT INTO `tblCustomers` (`id`, `customerName`, `phoneNumber`, `email`, `address`) VALUES
(1, 'General\r\n', '', '', ''),
(60, 'mony', '0976789500', '', ''),
(61, 'Tony', '0976789', '', ''),
(62, 'apple', '0976789501', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblInvoice`
--

CREATE TABLE `tblInvoice` (
  `invoice_id` int(11) NOT NULL,
  `invoice_number` varchar(250) DEFAULT NULL,
  `payment_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `money_change` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblInvoice`
--

INSERT INTO `tblInvoice` (`invoice_id`, `invoice_number`, `payment_id`, `amount`, `money_change`) VALUES
(1, 'PSS20235901', 2, 90, 0),
(2, 'PSS20235902', 2, 40, 0),
(3, 'PSS20235903', 2, 5, 0),
(4, 'PSS20235904', 2, 20, 0),
(5, 'PSS20235905', 2, 22, 0),
(6, 'PSS202351006', 2, 62, 0),
(7, 'PSS202351007', 2, 62, 0),
(8, 'PSS202351008', 2, 12, 0),
(9, 'PSS202351009', 2, 12, 0),
(10, 'PSS2023510010', 2, 20, 0),
(11, 'PSS2023510011', 2, 20, 0),
(12, 'PSS2023510012', 2, 10, 0),
(13, 'PSS2023510013', 1, 10, 0),
(14, 'PSS2023510014', 2, 20, 0),
(15, 'PSS2023510015', 2, 62, 0),
(16, 'PSS2023510016', 2, 20, 0),
(17, 'PSS2023510017', 2, 12, 0),
(18, 'PSS2023510018', 2, 20, 0),
(19, 'PSS2023510019', 1, 124124, 0),
(20, 'PSS2023510020', 1, 372434, 0),
(21, 'PSS2023510021', 2, 124212, 0),
(22, 'PSS2023510022', 2, 124192, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tblPayments`
--

CREATE TABLE `tblPayments` (
  `id` int(11) NOT NULL,
  `payment_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblPayments`
--

INSERT INTO `tblPayments` (`id`, `payment_type`) VALUES
(2, 'ABA'),
(1, 'Cash');

-- --------------------------------------------------------

--
-- Table structure for table `tblProducts`
--

CREATE TABLE `tblProducts` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT 0,
  `sub_id` int(11) DEFAULT 0,
  `unit_id` int(11) NOT NULL DEFAULT 0,
  `product_code` varchar(100) DEFAULT NULL,
  `product_name` varchar(200) DEFAULT NULL,
  `qty` int(11) DEFAULT 0,
  `unit_price` float DEFAULT 0,
  `price` float DEFAULT 0,
  `exp_date` date DEFAULT NULL,
  `product_image` varchar(250) DEFAULT NULL,
  `desc` varchar(250) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `reorder_number` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblProducts`
--

INSERT INTO `tblProducts` (`product_id`, `category_id`, `brand_id`, `sub_id`, `unit_id`, `product_code`, `product_name`, `qty`, `unit_price`, `price`, `exp_date`, `product_image`, `desc`, `status`, `reorder_number`) VALUES
(1, 1, 0, 1, 14, '000123', 'K Cement', 214, 4.75, 5, '2023-05-10', 'images/168373211957820230422103437_[fpdl.jpg', '', 2, 10),
(15, 10, 6, 0, 15, '942859', 'Capper', 100, 11, 12, '2023-05-10', 'images/168373210792720230417122646_[fpdl.jpg', '', 1, 10),
(16, 1, 6, 0, 14, '0923984', 'Book', 81, 9, 20, '2023-05-10', 'images/1683732095360520320.jpg', '', 1, 100),
(17, 1, 6, 0, 14, '897382', 'Car', 159, 10, 20, '2023-05-10', 'images/default.png', '', 1, 100),
(18, 1, 6, 0, 11, '093759', 'Door', 10, 10, 10, '2023-05-10', 'images/1683732074380520320.jpg', '', 1, 10),
(19, 2, 6, 0, 14, '82375', 'Flag', 252, 10, 20, '2023-05-10', 'images/1683732331323520320.jpg', '', 2, 10),
(21, 2, 15, 0, 11, '78877', 'K Cemen', 6, 112, 124124, '2023-05-10', 'images/default.png', '', 1, 0),
(22, 1, 0, 0, 14, '12345', 'KSDA', 5, 10, 11, '2023-05-10', 'images/default.png', '', 1, 1),
(23, 1, 15, 0, 14, '12324', 'ACement', 100, 10, 15, '2023-05-10', 'images/default.png', '', 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `tblProductUnits`
--

CREATE TABLE `tblProductUnits` (
  `id` int(11) NOT NULL,
  `unit` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblProductUnits`
--

INSERT INTO `tblProductUnits` (`id`, `unit`) VALUES
(8, 'm'),
(11, 'mm'),
(14, 'ton'),
(15, 'pakage');

-- --------------------------------------------------------

--
-- Table structure for table `tblRoles`
--

CREATE TABLE `tblRoles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblRoles`
--

INSERT INTO `tblRoles` (`role_id`, `role_name`) VALUES
(1, 'Admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `tblSaleDetails`
--

CREATE TABLE `tblSaleDetails` (
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty_sales` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblSaleDetails`
--

INSERT INTO `tblSaleDetails` (`sale_id`, `product_id`, `qty_sales`) VALUES
(1, 1, 1),
(1, 15, 1),
(1, 16, 1),
(1, 17, 1),
(1, 18, 1),
(1, 19, 1),
(2, 1, 1),
(2, 15, 1),
(2, 16, 1),
(3, 1, 1),
(4, 1, 1),
(4, 15, 1),
(5, 1, 2),
(5, 15, 1),
(6, 15, 1),
(6, 16, 1),
(6, 17, 1),
(6, 18, 1),
(7, 15, 1),
(7, 16, 1),
(7, 17, 1),
(7, 18, 1),
(8, 15, 1),
(9, 15, 1),
(10, 17, 1),
(11, 17, 1),
(12, 18, 1),
(13, 18, 1),
(14, 16, 1),
(15, 15, 1),
(15, 16, 1),
(15, 17, 1),
(15, 18, 1),
(16, 17, 1),
(17, 15, 1),
(18, 16, 1),
(19, 21, 1),
(20, 15, 1),
(20, 16, 1),
(20, 17, 1),
(20, 18, 1),
(20, 21, 3),
(21, 15, 1),
(21, 16, 1),
(21, 17, 1),
(21, 18, 1),
(21, 21, 1),
(21, 22, 1),
(21, 23, 1),
(22, 15, 1),
(22, 16, 1),
(22, 18, 1),
(22, 21, 1),
(22, 22, 1),
(22, 23, 1);

--
-- Triggers `tblSaleDetails`
--
DELIMITER $$
CREATE TRIGGER `delete_sale` AFTER DELETE ON `tblSaleDetails` FOR EACH ROW BEGIN
   UPDATE tblProducts SET tblProducts.qty = tblProducts.qty + OLD.qty_sales;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_qty` AFTER INSERT ON `tblSaleDetails` FOR EACH ROW UPDATE tblProducts SET qty = qty-new.qty_sales WHERE product_id = new.product_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_sale` AFTER UPDATE ON `tblSaleDetails` FOR EACH ROW BEGIN
    UPDATE tblProducts SET tblProducts.qty = (tblProducts.qty+OLD.qty_sales)-NEW.qty_sales;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblSales`
--

CREATE TABLE `tblSales` (
  `sale_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `invoice_id` int(11) NOT NULL,
  `sale_date` date NOT NULL,
  `desc` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblSales`
--

INSERT INTO `tblSales` (`sale_id`, `user_id`, `customer_id`, `invoice_id`, `sale_date`, `desc`) VALUES
(1, 17, 1, 1, '2023-05-09', ''),
(2, 17, 1, 2, '2023-05-09', ''),
(3, 17, 1, 3, '2023-05-09', ''),
(4, 27, 1, 4, '2023-05-09', ''),
(5, 27, 1, 5, '2023-05-09', ''),
(6, 17, 60, 6, '2023-05-10', ''),
(7, 17, 1, 7, '2023-05-10', ''),
(8, 17, 1, 8, '2023-05-10', ''),
(9, 17, 1, 9, '2023-05-10', ''),
(10, 17, 1, 10, '2023-05-10', ''),
(11, 17, 1, 11, '2023-05-10', ''),
(12, 17, 1, 12, '2023-05-10', ''),
(13, 17, 1, 13, '2023-05-10', ''),
(14, 17, 1, 14, '2023-05-10', ''),
(15, 17, 1, 15, '2023-05-10', ''),
(16, 17, 1, 16, '2023-05-10', ''),
(17, 17, 1, 17, '2023-05-10', ''),
(18, 17, 1, 18, '2023-05-10', ''),
(19, 17, 1, 19, '2023-05-10', ''),
(20, 27, 1, 20, '2023-05-10', ''),
(21, 17, 1, 21, '2023-05-10', ''),
(22, 17, 1, 22, '2023-05-10', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblStatus`
--

CREATE TABLE `tblStatus` (
  `id` int(11) NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblStatus`
--

INSERT INTO `tblStatus` (`id`, `status`) VALUES
(1, 'Enable'),
(2, 'Disable');

-- --------------------------------------------------------

--
-- Table structure for table `tblSupplies`
--

CREATE TABLE `tblSupplies` (
  `id` int(11) NOT NULL,
  `supName` varchar(250) NOT NULL,
  `companyName` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `phone` varchar(250) NOT NULL,
  `address` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblSupplies`
--

INSERT INTO `tblSupplies` (`id`, `supName`, `companyName`, `email`, `phone`, `address`) VALUES
(2, 'mony', '', '', '0933224', ''),
(3, 'mony', '', '', '09332243', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblUsers`
--

CREATE TABLE `tblUsers` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `status_id` int(11) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `phone_number` varchar(100) DEFAULT NULL,
  `token` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblUsers`
--

INSERT INTO `tblUsers` (`id`, `role_id`, `status_id`, `username`, `password`, `email`, `phone_number`, `token`) VALUES
(17, 1, 1, 'mony', '$2b$10$CkGDTvhDg/qQ0SpOmPLJVetk7XHDLBjvXoHynt973Ph7nDqQnrQSe', 'rysarakmony6101@gmail.com', '', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOjE3LCJ1c2VybmFtZSI6Im1vbnkiLCJlbWFpbCI6InJ5c2FyYWttb255NjEwMUBnbWFpbC5jb20iLCJyb2xlIjoiQWRtaW4iLCJpYXQiOjE2ODM3MzQwNzcsImV4cCI6MTY4MzgyMDQ3N30.altbnmOnK-4x8KXLbUZD-TKntynlJFO3gKweBYwhkso'),
(26, 1, 1, 'chea', '$2b$10$orn/fFbKdBwEDcuh7FtxmuLK106zcK1/IilQyRCocAsAuKRGtsQOS', 'chea@gmail.com', '', NULL),
(27, 2, 1, 'dara', '$2b$10$gvt6DNt3NHiVhMNfSvNAA.8hfgi.RaSLUs3G2VTu1Vc5qhApFcBrO', 'chea9999@gmail.com', '', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_chartdayreports`
-- (See below for the actual view)
--
CREATE TABLE `v_chartdayreports` (
`totalAmount` double
,`Day` varchar(32)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_productreports`
-- (See below for the actual view)
--
CREATE TABLE `v_productreports` (
`product_id` int(11)
,`product_code` varchar(100)
,`product_name` varchar(200)
,`qty` decimal(32,0)
,`unit` varchar(20)
,`cost` double
,`revenue` double
,`profit` double
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_todaysale`
-- (See below for the actual view)
--
CREATE TABLE `v_todaysale` (
`product_code` varchar(100)
,`product_name` varchar(200)
,`qty` varchar(59)
,`cost` double
,`revenue` double
,`profit` double
,`sale_date` date
);

-- --------------------------------------------------------

--
-- Structure for view `getallproducts`
--
DROP TABLE IF EXISTS `getallproducts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `getallproducts`  AS SELECT `tblproducts`.`product_id` AS `product_id`, `tblproducts`.`product_name` AS `product_name`, `tblproducts`.`product_code` AS `product_code`, `tblcategories`.`categoryName` AS `categoryName`, `tblbrands`.`brandName` AS `brandName`, `tblproductunits`.`unit` AS `unit`, `tblproducts`.`unit_price` AS `unit_price`, `tblproducts`.`price` AS `price`, `tblproducts`.`qty` AS `qty`, `tblproducts`.`reorder_number` AS `reorder_number`, `tblproducts`.`product_image` AS `product_image` FROM (((`tblproducts` left join `tblcategories` on(`tblproducts`.`category_id` = `tblcategories`.`id`)) left join `tblbrands` on(`tblproducts`.`brand_id` = `tblbrands`.`id`)) left join `tblproductunits` on(`tblproducts`.`unit_id` = `tblproductunits`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_chartdayreports`
--
DROP TABLE IF EXISTS `v_chartdayreports`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_chartdayreports`  AS SELECT sum(`tblinvoice`.`amount`) AS `totalAmount`, date_format(`tblsales`.`sale_date`,'%a') AS `Day` FROM (`tblsales` join `tblinvoice` on(`tblinvoice`.`invoice_id` = `tblsales`.`invoice_id`)) GROUP BY date_format(`tblsales`.`sale_date`,'%a') ;

-- --------------------------------------------------------

--
-- Structure for view `v_productreports`
--
DROP TABLE IF EXISTS `v_productreports`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_productreports`  AS SELECT `tblproducts`.`product_id` AS `product_id`, `tblproducts`.`product_code` AS `product_code`, `tblproducts`.`product_name` AS `product_name`, sum(`tblsaledetails`.`qty_sales`) AS `qty`, `tblproductunits`.`unit` AS `unit`, sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`unit_price` AS `cost`, sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`price` AS `revenue`, sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`price` - sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`unit_price` AS `profit` FROM ((`tblsaledetails` left join `tblproducts` on(`tblsaledetails`.`product_id` = `tblproducts`.`product_id`)) join `tblproductunits` on(`tblproducts`.`unit_id` = `tblproductunits`.`id`)) GROUP BY `tblsaledetails`.`product_id` ;

-- --------------------------------------------------------

--
-- Structure for view `v_todaysale`
--
DROP TABLE IF EXISTS `v_todaysale`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_todaysale`  AS SELECT `tblproducts`.`product_code` AS `product_code`, `tblproducts`.`product_name` AS `product_name`, concat(sum(`tblsaledetails`.`qty_sales`),' ( ',`tblproductunits`.`unit`,' ) ') AS `qty`, sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`unit_price` AS `cost`, sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`price` AS `revenue`, sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`price` - sum(`tblsaledetails`.`qty_sales`) * `tblproducts`.`unit_price` AS `profit`, curdate() AS `sale_date` FROM (((`tblsales` join `tblsaledetails` on(`tblsaledetails`.`sale_id` = `tblsales`.`sale_id`)) join `tblproducts` on(`tblsaledetails`.`product_id` = `tblproducts`.`product_id`)) left join `tblproductunits` on(`tblproducts`.`unit_id` = `tblproductunits`.`id`)) WHERE `tblsales`.`sale_date` = curdate() GROUP BY `tblproducts`.`product_code` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblBrands`
--
ALTER TABLE `tblBrands`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `brandName` (`brandName`);

--
-- Indexes for table `tblCategories`
--
ALTER TABLE `tblCategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblCurrency`
--
ALTER TABLE `tblCurrency`
  ADD PRIMARY KEY (`cur_id`);

--
-- Indexes for table `tblCustomers`
--
ALTER TABLE `tblCustomers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblInvoice`
--
ALTER TABLE `tblInvoice`
  ADD PRIMARY KEY (`invoice_id`);

--
-- Indexes for table `tblPayments`
--
ALTER TABLE `tblPayments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_type` (`payment_type`);

--
-- Indexes for table `tblProducts`
--
ALTER TABLE `tblProducts`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `product_name` (`product_name`),
  ADD UNIQUE KEY `product_code` (`product_code`);

--
-- Indexes for table `tblProductUnits`
--
ALTER TABLE `tblProductUnits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblRoles`
--
ALTER TABLE `tblRoles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `tblSaleDetails`
--
ALTER TABLE `tblSaleDetails`
  ADD PRIMARY KEY (`sale_id`,`product_id`);

--
-- Indexes for table `tblSales`
--
ALTER TABLE `tblSales`
  ADD PRIMARY KEY (`sale_id`);

--
-- Indexes for table `tblStatus`
--
ALTER TABLE `tblStatus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblSupplies`
--
ALTER TABLE `tblSupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblUsers`
--
ALTER TABLE `tblUsers`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblBrands`
--
ALTER TABLE `tblBrands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `tblCategories`
--
ALTER TABLE `tblCategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `tblCurrency`
--
ALTER TABLE `tblCurrency`
  MODIFY `cur_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblCustomers`
--
ALTER TABLE `tblCustomers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `tblInvoice`
--
ALTER TABLE `tblInvoice`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `tblPayments`
--
ALTER TABLE `tblPayments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblProducts`
--
ALTER TABLE `tblProducts`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `tblProductUnits`
--
ALTER TABLE `tblProductUnits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tblRoles`
--
ALTER TABLE `tblRoles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblSales`
--
ALTER TABLE `tblSales`
  MODIFY `sale_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `tblSupplies`
--
ALTER TABLE `tblSupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tblUsers`
--
ALTER TABLE `tblUsers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
