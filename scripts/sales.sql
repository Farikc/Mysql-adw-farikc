use adw;

/*
select 
    SalesOrderId
    OrderDate,
    CustomerID,
    SalesPersonID,
    TerritoryID
from Sales_SalesOrderHeader
limit 5;

select 
    SOH.SalesOrderId,
    SOH.OrderDate,
    SOH.CustomerID,
    SOH.SalesPersonID,
    SOH.TerritoryID,
    SOH.SubTotal,
    ST.Name
from Sales_SalesOrderHeader SOH join
    Sales_SalesTerritory ST using(TerritoryID)
limit 5;

select *
from Sales_SalesOrderDetail
limit 1,1;
*/

with sales_per_territory as (
select 
    SOH.SalesOrderId,
    SOH.TerritoryID,
    sum(SOH.SubTotal) as Sales,
    ST.Name
from Sales_SalesOrderHeader SOH join
    Sales_SalesTerritory ST using(TerritoryID)
group by SOH.SalesOrderId, SOH.TerritoryID ,ST.Name),

-- ventas per month and territory
sales_per_month as (
select 
    year(SOH.OrderDate) order_year,
    month(SOH.OrderDate) order_month,
    SPT.Name,
    sum(SPT.Sales)
from sales_per_territory SPT join
     Sales_SalesOrderHeader SOH using(SalesOrderId)
group by year(SOH.OrderDate), month(SOH.OrderDate), SPT.Name
)

select *
from sales_per_month
limit 10;